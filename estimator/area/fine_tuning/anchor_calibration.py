import os
import json
import pickle
import shutil
from typing import Dict

import torch
import torch.nn as nn
from torch.nn.utils import clip_grad_norm_

from estimator.common.model_utils import prepare_loader, set_random_seeds
from estimator.area.models import AreaModel
from estimator.area.dataset import AreaDataset
from estimator.area.train import export_eval_results, evaluate_ensemble, AREA_METRICS

DEVICE = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')


def main(args: Dict[str, str]):
    model_dir = args.get("model_dir")
    anchor_path = args.get("anchor_path")
    batch_size = int(args.get("batch_size", 16))
    epochs = int(args.get("epochs", 30))
    output_dir = args.get("output_dir", "")
    train_dataset_dir = args.get("train_dataset_dir", "estimator/area/dataset")
    
    if not os.path.exists(model_dir):
        raise FileNotFoundError(f"Model directory {model_dir} does not exist.")
    
    if not os.path.exists(anchor_path):
        raise FileNotFoundError(f"Anchor instance path {anchor_path} does not exist.")

    if not os.path.exists(train_dataset_dir):
        raise FileNotFoundError(
            f"Training dataset not found in {train_dataset_dir}."
        )

    train_args_path = os.path.join(model_dir, 'training_args.json')

    model_paths = [
        os.path.join(model_dir, f) for f in os.listdir(model_dir)
        if f.startswith('model_') and f.endswith('.pt')
    ]
    if not model_paths:
        raise FileNotFoundError(f"No model path found in {model_dir}.")
    
    if not output_dir:
        output_dir = os.path.join(model_dir, 'calibrated')

    if os.path.exists(output_dir): 
        shutil.rmtree(output_dir)
    os.makedirs(output_dir)
    
    with open(train_args_path, 'r') as f:
        train_args = json.load(f)
        
    with open(anchor_path, 'rb') as f:
        graph = pickle.load(f)

    set_random_seeds(train_args.get('seed', 42))

    model = AreaModel(
        hidden_dim=train_args['hidden_dim'],
        num_layers_micro=train_args['num_layers_micro'],
        num_layers_macro=train_args['num_layers_macro'],
        heads=train_args['heads'],
        dropout=train_args['dropout']
    )

    loss_fn = nn.HuberLoss(delta=1.0)

    dataset = AreaDataset()

    anchor = dataset.preprocess_data(
        graph=graph,
        target={m: float(graph.anchor_metrics[m]) for m in AREA_METRICS},
        solution=0
    )
    anchor = anchor.to(DEVICE)

    batch_dict = {
        nt: torch.zeros(x.size(0), dtype=torch.long, device=x.device) 
        for nt, x in anchor.x_dict.items()
    }

    ft_model_paths = []
    for path in model_paths:
        print(f"Fine-tuning {path}")

        model.reset_parameters()
        model.load_state_dict(
            torch.load(path, weights_only=False, map_location=DEVICE)
        )
        model.to(DEVICE)
        model.eval()

        trainable_params = []
        for n, p in model.named_parameters():
            if n.startswith('mlp.') and '.0.' not in n:
                p.requires_grad  = True
                trainable_params.append(p)
            else:
                p.requires_grad = False

        optimizer = torch.optim.AdamW(trainable_params, lr=1e-4, weight_decay=0.0)

        for _ in range(epochs):
            out = model(
                x_dict=anchor.x_dict,
                edge_index_dict=anchor.edge_index_dict,
                y_anchor=anchor.y_anchor,
                batch_dict=batch_dict,
                batch_size=1
            )
            loss = loss_fn(out, anchor.y)
            loss.backward()
            clip_grad_norm_(trainable_params, max_norm=1.0)
            optimizer.step()

        ft_model_path = os.path.join(output_dir, os.path.basename(path))
        ft_model_paths.append(ft_model_path)
        torch.save(model.state_dict(), ft_model_path)

    test_loader = prepare_loader(
        AreaDataset,
        dataset_dir=train_dataset_dir, 
        benchmarks=[graph.benchmark], 
        batch_size=batch_size,
        shuffle=False
    )

    print("Evaluating the fine-tuned model...")

    model.eval()
    rpt_dict = evaluate_ensemble(model, test_loader, ft_model_paths)
    print("Average SMAPE (Test Set):")
    for m, rpt in rpt_dict.items():
        print(f"  {m}: {rpt.smape:.4f}")
    export_eval_results(graph.benchmark, rpt_dict, output_dir)


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(
        description="Calibrate pre-trained estimator using Anchor Instance from target kernel."
    )
    parser.add_argument("model_dir", type=str,
                        help="Pre-trained model directory.")
    parser.add_argument("-a", "--anchor-path", type=str, required=True, 
                        help="Anchor instance graph path.")
    parser.add_argument("-b", "--batch-size", type=int, default=16,
                        help="Batch size for fine-tuning.")
    parser.add_argument("-o", "--output_dir", type=str, default="", 
                        help="Directory to save the anchored model.")
    parser.add_argument("-d", "--train-dataset-dir", type=str, default="estimator/area/dataset",
                        help="Pre-training dataset directory.")
    parser.add_argument("-e", "--epochs", type=int, default=30,
                        help="Number of fine-tuning epochs. Default: 30.")
    args = vars(parser.parse_args())
    
    main(args)