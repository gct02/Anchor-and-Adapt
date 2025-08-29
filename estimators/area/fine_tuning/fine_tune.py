import os
import json
from typing import Dict

import torch
import torch.nn as nn
from torch.nn.utils import clip_grad_norm_

from estimators.common.perf_visualization import plot_prediction_bars
from estimators.area.fine_tuning.utils import (
    load_model_args,
    prepare_data_loader,
    get_layerwise_decay_params,
    mape_loss,
    evaluate
)
from estimators.area.models import HLSQoREstimator
from estimators.common.training_utils import set_random_seeds
from estimators.common.parsers import AVAILABLE_RESOURCES, AREA_METRICS

DEVICE = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')


def average_model_weights(
    model_paths: Dict[int, str], 
    model_scores: Dict[int, float]
) -> Dict[str, torch.Tensor]:
    """
    Averages the weights of multiple models.
    
    Args:
        model_paths (Dict[int, str]): A dictionary mapping model indices to their file paths.
        model_scores (Dict[int, float]): A dictionary mapping model indices to their performance scores.
    
    Returns:
        Dict[str, Tensor]: A dictionary containing the averaged model weights.
    """
    if not model_paths:
        raise ValueError("No model paths provided for averaging.")
    
    if len(model_paths) == 1:
        return torch.load(model_paths[0], map_location=DEVICE)
    
    avg_state_dict = None

    for model_index, model_path in model_paths.items():
        if not os.path.exists(model_path):
            raise FileNotFoundError(f"Model file {model_path} does not exist.")
        
        if not model_index in model_scores:
            raise ValueError(f"Model index {model_index} not found in model_scores.")
        
        score = model_scores[model_index]
        state_dict = torch.load(model_path, map_location=DEVICE)
        
        if avg_state_dict is None:
            avg_state_dict = {key: torch.zeros_like(value) for key, value in state_dict.items()}
        
        for key in avg_state_dict.keys():
            avg_state_dict[key] += state_dict[key] * score

    return avg_state_dict


def main(args: Dict[str, str]):
    dataset_dir = args.get("dataset_dir")
    model_dir = args.get("model_dir")
    batch_size = int(args.get("batch_size", 4))
    epochs = int(args.get("epochs", 30))
    output_dir = args.get("output_dir", "")
    lr = float(args.get("learning_rate", 5e-5))
    decay_rate = float(args.get("decay_rate", 0.85))
    skip_eval = args.get("skip_eval", False)
    pretraining_dataset_dir = args.get("pretraining_dataset_dir", "estimators/area/dataset")
    skip_preprocessing = args.get("skip_preprocessing", False)

    if not os.path.exists(dataset_dir):
        raise FileNotFoundError(f"Dataset directory {dataset_dir} does not exist.")
    
    if not os.path.exists(model_dir):
        raise FileNotFoundError(f"Model directory {model_dir} does not exist.")

    model_args_path = os.path.join(model_dir, 'model_args.json')
    pretraining_args_path = os.path.join(model_dir, 'pretraining_args.json')
    scaling_stats_path = os.path.join(model_dir, 'scaling_stats.json')
    target_scaling_stats_path = os.path.join(model_dir, 'target_scaling_stats.json')
    graph_attr_scaling_stats_path = os.path.join(model_dir, 'graph_attr_scaling_stats.json')

    required_paths = [
        dataset_dir, model_args_path, pretraining_args_path, 
        scaling_stats_path, target_scaling_stats_path, 
        graph_attr_scaling_stats_path
    ]
    if not all(os.path.exists(path) for path in required_paths):
        raise FileNotFoundError("One or more required paths does not exist.")
        
    output_dir = output_dir or os.path.join(model_dir, 'fine_tuning')
    os.makedirs(output_dir, exist_ok=True)
    
    with open(pretraining_args_path, 'r') as f:
        pretraining_args = json.load(f)

    with open(scaling_stats_path, 'r') as f:
        scaling_stats = json.load(f)

    with open(target_scaling_stats_path, 'r') as f:
        target_scaling_stats = json.load(f)

    with open(graph_attr_scaling_stats_path, 'r') as f:
        graph_attr_scaling_stats = json.load(f)

    model_paths, model_scores = {}, {}
    score_sum = 0.0
    for file in os.listdir(model_dir):
        if file.endswith('.pt') and file.startswith('model_'):
            model_index = file.split('_')[1].split('.')[0]
            if not model_index.isdigit():
                print(f"Skipping {file} as it does not have a valid index.")
                continue
            model_index = int(model_index)
            mape_path = os.path.join(model_dir, f'mape_{model_index}.txt')
            if not os.path.exists(mape_path):
                print(f"Skipping {mape_path} as it does not exist.")
                continue
            with open(mape_path, 'r') as f:
                line = f.readline().strip()
            if not line:
                print(f"Skipping {mape_path} due to empty content.")
                continue
            try:
                mape = float(line.split('=')[1].strip())
            except (IndexError, ValueError):
                print(f"Skipping {mape_path} due to parsing error.")
                continue
            perf_score = 1 / (mape + 1e-6)
            epoch_decay = 0.9 ** model_index
            score = perf_score * epoch_decay
            model_scores[model_index] = score
            model_paths[model_index] = os.path.join(model_dir, file)
            score_sum += score

    if not model_paths:
        raise ValueError("No valid model paths found in the specified directory.")
    
    if score_sum == 0:
        raise ValueError("Total score sum is zero, cannot average models.")
    
    for i in model_scores:
        model_scores[i] /= score_sum

    print(f"Performing weighted averaging of {len(model_paths)} models with scores: {model_scores}")
    model_state_dict = average_model_weights(model_paths, model_scores)

    model_args = load_model_args(model_args_path)
    model = HLSQoREstimator(**model_args)

    model.load_state_dict(model_state_dict)
    model.to(DEVICE)
        
    benchmark = pretraining_args.get("test_bench")
    betas = pretraining_args.get('betas', (0.9, 0.999))
    weight_decay = pretraining_args.get('weight_decay', 1e-4)
    max_norm = pretraining_args.get('max_norm', None)
    seed = pretraining_args.get('seed', 999)
    # loss = pretraining_args.get('loss', 'mse')

    # if loss == 'l1':
    #     loss_fn = nn.L1Loss()
    # elif loss == 'mse':
    #     loss_fn = nn.MSELoss()
    # elif loss == 'huber':
    #     delta = pretraining_args.get('huber_delta', 1.0)
    #     loss_fn = nn.HuberLoss(delta=delta)
    # else:
    #     raise ValueError(f"Unsupported loss function: {loss}")

    loss_fn = nn.L1Loss()

    set_random_seeds(seed)

    if skip_preprocessing:
        preprocessed_ft_dataset_dir = os.path.join(dataset_dir, f'fine_tune_{benchmark}/processed')
        preprocessed_pt_dataset_dir = os.path.join(pretraining_dataset_dir, f'eval_{benchmark}/processed')

        if (not os.path.exists(preprocessed_ft_dataset_dir) or 
            not os.path.exists(preprocessed_pt_dataset_dir)):
            preprocessed_ft_dataset_dir = None
            preprocessed_pt_dataset_dir = None
            skip_preprocessing = False
    else:
        preprocessed_ft_dataset_dir = None
        preprocessed_pt_dataset_dir = None

    ft_loader = prepare_data_loader(
        dataset_dir, benchmark, scaling_stats,
        target_scaling_stats, graph_attr_scaling_stats,
        batch_size=batch_size, mode=f"fine_tune_{benchmark}",
        preprocess=not skip_preprocessing,
        processed_dataset_dir=preprocessed_ft_dataset_dir
    )
    
    for param in model.parameters():
        param.requires_grad = True

    # Prepare the optimizer
    grouped_params = get_layerwise_decay_params(
        model,
        initial_lr=lr,
        weight_decay=weight_decay,
        decay_rate=decay_rate
    )
    optimizer = torch.optim.AdamW(grouped_params, betas=betas)

    run_number = 1
    while os.path.exists(f"{output_dir}/run_{run_number}"):
        run_number += 1
    output_dir = f"{output_dir}/run_{run_number}"
    os.makedirs(output_dir, exist_ok=True)

    with open(os.path.join(output_dir, 'model_args.json'), 'w') as f:
        json.dump(model_args, f, indent=2)

    fine_tuning_args = pretraining_args.copy()
    fine_tuning_args.update({
        "batch": batch_size,
        "epoch": epochs,
        "learning_rate": lr,
        "decay_rate": decay_rate
    })
    with open(os.path.join(output_dir, 'fine_tuning_args.json'), 'w') as f:
        json.dump(fine_tuning_args, f, indent=2)

    with open(os.path.join(output_dir, 'solutions.txt'), 'w') as f:
        f.write("\n".join(map(str, [data.solution_index for data in ft_loader.dataset])))

    for _ in range(epochs):
        model.train()
        for data in ft_loader:
            optimizer.zero_grad()
            data = data.to(DEVICE)
            pred = model(data)
            loss = loss_fn(pred, data.y)
            loss.backward()
            if max_norm is not None:
                clip_grad_norm_(model.parameters(), max_norm=max_norm)
            optimizer.step()

    torch.save(model.state_dict(), os.path.join(output_dir, 'model.pt'))

    if skip_eval:
        print("Skipping evaluation as per request.")
        return

    model.eval()
    print("Evaluating the fine-tuned model...")

    if not os.path.exists(pretraining_dataset_dir):
        raise FileNotFoundError(f"Pretraining dataset directory {pretraining_dataset_dir} does not exist.")

    eval_loader = prepare_data_loader(
        pretraining_dataset_dir, benchmark, scaling_stats,
        target_scaling_stats, graph_attr_scaling_stats,
        batch_size=batch_size, mode=f"eval_{benchmark}",
        preprocess=not skip_preprocessing,
        processed_dataset_dir=preprocessed_pt_dataset_dir
    )

    mean_target = torch.tensor(
        [target_scaling_stats[key]['mean'] for key in AREA_METRICS],
        dtype=torch.float32, device=DEVICE
    )
    std_target = torch.tensor(
        [target_scaling_stats[key]['std'] for key in AREA_METRICS],
        dtype=torch.float32, device=DEVICE
    )
    available_resources = torch.tensor(
        [AVAILABLE_RESOURCES[key] for key in AREA_METRICS],
        dtype=torch.float32,
        device=DEVICE
    )
    preds, targets, _ = evaluate(
        model, eval_loader, mean_target, std_target, 
        available_resources=available_resources, device=DEVICE
    )
    indices = [data.solution_index for data in eval_loader.dataset]

    fine_tuning_indices = [data.solution_index for data in ft_loader.dataset]
    eval_results = [
        (idx, target, pred) for idx, target, pred in zip(indices, targets, preds)
        if idx not in fine_tuning_indices
    ]

    preds = [pred for _, _, pred in eval_results]
    targets = [target for _, target, _ in eval_results]
    indices = [idx for idx, _, _ in eval_results]

    with open(os.path.join(output_dir, f"predictions.csv"), 'w') as f:
        f.write("index,target,prediction\n")
        for idx, target, pred in zip(indices, targets, preds):
            f.write(f"{idx},{target},{pred}\n")

    mape = mape_loss(
        torch.tensor(preds, dtype=torch.float32, device=DEVICE),
        torch.tensor(targets, dtype=torch.float32, device=DEVICE)
    ).item()

    plot_prediction_bars(
        targets=targets,
        preds=preds,
        indices=indices,
        benchmark=benchmark,
        metric="area",
        output_path=os.path.join(output_dir, f"predictions.png"),
        mape=mape
    )
    print(f"Evaluation MAPE: {mape:.4f}")


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Fine-tune GNN model.")

    parser.add_argument("-m", "--model_dir", type=str, required=True, 
                        help="Path to the pre-trained model directory.")
    parser.add_argument("-d", "--dataset_dir", type=str, default="estimators/area/fine_tuning/dataset", 
                        help="Path to dataset directory.")
    parser.add_argument("-e", "--epochs", type=int, default=50, 
                        help="Number of epochs for fine-tuning.")
    parser.add_argument("-b", "--batch_size", type=int, default=4,
                        help="Batch size for fine-tuning.")
    parser.add_argument("-o", "--output_dir", type=str, default="", 
                        help="Directory to save the fine-tuned model.")
    parser.add_argument("-lr", "--learning_rate", type=float, default=5e-5,
                        help="Learning rate for the optimizer.")
    parser.add_argument("-dr", "--decay_rate", type=float, default=0.85,
                        help="Decay rate for the learning rate.")
    parser.add_argument("-se", "--skip_eval", action='store_true', 
                        help="Skip evaluation after fine-tuning.")
    parser.add_argument("-p", "--pretraining_dataset_dir", type=str, default="estimators/area/dataset",
                        help="Path to the pretraining dataset directory.")
    parser.add_argument("-sp", "--skip_preprocessing", action='store_true',
                        help="Skip preprocessing and use preprocessed dataset.")
    
    main(vars(parser.parse_args()))