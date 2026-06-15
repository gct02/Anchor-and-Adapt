import os
import json
import shutil
from pathlib import Path
from typing import Dict

import torch
from torch.nn.utils import clip_grad_norm_

from estimator.common.constants import BENCHMARK_INFO_PATH
from estimator.common.model_utils import (
    set_random_seeds,
    prepare_loader, 
    get_loss_function,
    get_layerwise_decay_params
)
from estimator.power.models import PowerModel
from estimator.power.dataset import PowerDataset
from estimator.power.train import (
    evaluate_ensemble, 
    evaluate,
    export_eval_results
)

DEVICE = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')


def main(args: Dict[str, str]):
    model_dir = Path(args["model_dir"])
    dataset_dir = Path(args["dataset_dir"])
    epochs = args["epochs"]
    output_dir = args["output_dir"]
    batch_size = args["batch_size"]
    loss_type = args["loss"]
    lr = args["learning_rate"]
    weight_decay = args['weight_decay']
    decay_rate = args["decay_rate"]
    train_dataset_dir = Path(args["train_dataset_dir"])

    if not model_dir.is_dir():
        raise FileNotFoundError(f"Directory not found: {model_dir}.")
    
    train_args_path = model_dir / "training_args.json"
    if not train_args_path.exists():
        raise FileNotFoundError(f"File not found: {train_args_path}.") 
    
    model_paths = sorted(
        [
            p for p in model_dir.iterdir()
            if p.name.startswith('model_') and p.name.endswith('.pt')
        ],
        key=lambda p: int(p.stem.replace('model_', ''))
    )
    if not model_paths:
        raise FileNotFoundError(f"No model saved in {model_dir}.")
    
    if not output_dir:
        output_dir = model_dir / 'fine_tuned'
    else:
        output_dir = Path(output_dir)
        
    if output_dir.is_dir(): 
        shutil.rmtree(output_dir)
    output_dir.mkdir()
    
    with open(train_args_path, 'r') as f:
        train_args = json.load(f)

    benchmark = train_args['test_bench']
    seed = train_args.get('seed', 42)
    set_random_seeds(seed)

    train_loader = prepare_loader(
        PowerDataset, dataset_dir, benchmark, 
        balanced=False, batch_size=None, shuffle=True, 
        drop_last=False, num_workers=4, pin_memory=True
    )

    with open(BENCHMARK_INFO_PATH, 'r') as f:
        bench_info_dict = json.load(f)

    bench_info = bench_info_dict.get(benchmark, {})
    last_base = bench_info.get('last_base_index', 0)

    ft_solutions = set()
    n_base, n_complex = 0, 0
    for data in train_loader.dataset:
        ft_solutions.add(data.solution)
        if data.solution <= last_base: n_base += 1
        else: n_complex += 1

    ft_args = train_args.copy()
    ft_args.update({
        "ft_epoch": epochs,
        "ft_learning_rate": lr,
        "ft_decay_rate": decay_rate,
        "ft_solutions": list(ft_solutions),
        "ft_num_base_solutions": n_base,
        "ft_num_complex_solutions": n_complex
    })
    ft_args_path = output_dir / 'fine_tuning_args.json'
    with open(ft_args_path, 'w') as f:
        json.dump(ft_args, f, indent=2)

    proc_dataset_dir = train_dataset_dir / 'processed'
    if not proc_dataset_dir.is_dir():
        raise FileNotFoundError("Training dataset was not processed.")
    
    manifest_path = proc_dataset_dir / 'manifest.json'
    if not manifest_path.is_file():
        raise FileNotFoundError("Manifest not found for training dataset.")
    
    with open(manifest_path, 'r') as f:
        manifest = json.load(f)

    test_indices = []
    for data_idx, data_info in manifest.items():
        if (data_info["benchmark"] == benchmark 
            and int(data_info['sol_idx']) not in ft_solutions):
            test_indices.append(int(data_idx))

    test_loader = prepare_loader(
        PowerDataset, train_dataset_dir, benchmark, 
        balanced=False, indices=test_indices, batch_size=batch_size, 
        shuffle=False, drop_last=False, num_workers=4, pin_memory=True
    )

    model = PowerModel(
        hidden_dim=train_args['hidden_dim'],
        num_layers_micro=train_args['num_layers_micro'],
        num_layers_macro=train_args['num_layers_macro'],
        heads=train_args['heads'],
        dropout=train_args['dropout']
    )

    if loss_type == '': 
        loss_type = train_args['loss']

    loss_fn = get_loss_function(loss_type)

    freeze_prefixes = [
        'proj_lin.', 'proj_norm.', 'convs_micro.0.', 'norms_micro.0.'
    ]

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
            if any(n.startswith(pfx) for pfx in freeze_prefixes):
                p.requires_grad = False
            else:
                p.requires_grad  = True
                trainable_params.append(p)

        grouped_params = get_layerwise_decay_params(
            model, initial_lr=lr, weight_decay=weight_decay, 
            decay_rate=decay_rate
        )
        optimizer = torch.optim.AdamW(grouped_params)

        for _ in range(epochs):
            for data in train_loader:
                optimizer.zero_grad()
                data = data.to(DEVICE)
                out = model(
                    x_dict=data.x_dict, 
                    edge_index_dict=data.edge_index_dict, 
                    y_anchor=data.y_anchor,
                    batch_dict=data.batch_dict,
                    batch_size=data.num_graphs
                )
                loss = loss_fn(out, data.y)
                loss.backward()
                clip_grad_norm_(trainable_params, max_norm=1.0)
                optimizer.step()
        
        model.eval()
        rpt = evaluate(model, test_loader)
        print(f"Average SMAPE (Test Set): {rpt.smape:.4f}")
        export_eval_results(benchmark, rpt, output_dir)

        ft_model_path = os.path.join(output_dir, os.path.basename(path))
        ft_model_paths.append(ft_model_path)
        torch.save(model.state_dict(), ft_model_path)

    print("Evaluating the fine-tuned model...")

    model.eval()
    final_rpt = evaluate_ensemble(model, test_loader, ft_model_paths)
    print(f"Final Ensemble SMAPE (Test Set): {final_rpt.smape:.4f}")
    export_eval_results(benchmark, final_rpt, output_dir)


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Fine-tune a pre-trained Dynamic Power estimator.")
    parser.add_argument("model_dir", type=str, 
                        help="Path to the pre-trained model directory.")
    parser.add_argument("-d", "--dataset-dir", type=str, default="estimator/common/fine_tuning/samples/power/dataset", 
                        help="Path to dataset directory.")
    parser.add_argument("-e", "--epochs", type=int, default=100, 
                        help="Number of epochs for fine-tuning.")
    parser.add_argument("-b", "--batch-size", type=int, default=64,
                        help="Batch size for evaluation.")
    parser.add_argument("-o", "--output-dir", type=str, default="", 
                        help="Directory to save the fine-tuned model.")
    parser.add_argument("-l", "--loss", type=str, choices=['mse', 'l1', 'huber', 'rank'], default='',
                        help="The loss function for fine-tuning. Default: '' (use the training loss function).")
    parser.add_argument("-r", "--learning-rate", type=float, default=5e-4,
                        help="Learning rate for the optimizer.")
    parser.add_argument('-w', '--weight-decay', type=float, default=5e-4,
                        help='Weight decay for the optimizer (default: 5e-4).')
    parser.add_argument("--decay-rate", type=float, default=0.8,
                        help="Decay rate for the learning rate.")
    parser.add_argument("--train-dataset-dir", type=str, default="estimator/power/dataset",
                        help="Path to the pretraining dataset directory.")
    args = vars(parser.parse_args())

    main(args)