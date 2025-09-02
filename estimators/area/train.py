import os
import argparse
import json
from typing import List, Dict, Tuple, Optional, Union, Any

import matplotlib
import torch
import torch.nn as nn
from torch import Tensor
from torch.nn.utils import clip_grad_norm_
from torch.optim import Optimizer
from torch.optim.lr_scheduler import LRScheduler

from torch_geometric.loader import DataLoader

from estimators.common.parsers import AVAILABLE_RESOURCES, AREA_METRICS
from estimators.common.perf_visualization import (
    plot_prediction_bars,
    plot_prediction_scatter,
    plot_learning_curves
)
from estimators.common.training_utils import (
    CheckpointManager, 
    group_params_for_weight_decay,
    set_random_seeds
)
from estimators.common.metrics import compute_snru
from estimators.common.losses import mape_loss

from estimators.area.models import HLSQoREstimator
from estimators.area.dataset import HLSDataset, StatsDict
from estimators.area.graph import GRAPH_ATTR_DIM, NODE_TYPES, EDGE_TYPES, NODE_DIM_DICT

DEVICE = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

checkpoint_manager = None


def average_model_weights(
    model_paths: List[str], 
    model_scores: List[float]
) -> Dict[str, Tensor]:
    if not model_paths:
        raise ValueError("No model paths provided for averaging.")
    
    if len(model_paths) == 1:
        return torch.load(model_paths[0], map_location=DEVICE)
    
    avg_state_dict = None

    for i, model_path in enumerate(model_paths.items()):
        if not os.path.exists(model_path):
            raise FileNotFoundError(f"Model file {model_path} does not exist.")
        
        if not i in model_scores:
            raise ValueError(f"Model index {i} not found in model_scores.")
        
        score = model_scores[i]
        state_dict = torch.load(model_path, map_location=DEVICE)
        
        if avg_state_dict is None:
            avg_state_dict = {key: torch.zeros_like(value) for key, value in state_dict.items()}
        
        for key in avg_state_dict.keys():
            avg_state_dict[key] += state_dict[key] * score

    return avg_state_dict


def evaluate_ensemble(
    model: nn.Module,
    model_paths: List[str],
    model_scores: List[float],
    loader: DataLoader,
    mean_target: Tensor,
    std_target: Tensor,
    available_resources: Optional[Tensor] = None,
    output_dir: str = None
) -> Tuple[List[float], List[float], float]:
    targets = []
    for data in loader:
        data = data.to(DEVICE)
        targets.append(data.original_y)

    targets = compute_snru(torch.cat(targets, dim=0), available_resources)
    target_list = targets.tolist()

    all_preds = []

    for i, model_path in enumerate(model_paths):
        if not os.path.exists(model_path):
            raise FileNotFoundError(f"Model file {model_path} does not exist.")

        model.load_state_dict(torch.load(model_path, map_location=DEVICE))
        model.eval()

        preds = []
        with torch.no_grad():
            for data in loader:
                data = data.to(DEVICE)
                pred = model(data)
                pred = pred * std_target + mean_target
                pred *= model_scores[i]
                preds.append(pred)

        all_preds.append(torch.cat(preds, dim=0))

    # Aggregate predictions from all models
    preds = torch.sum(torch.stack(all_preds), dim=0)
    preds = torch.expm1(preds)
    preds = compute_snru(preds, available_resources)
    pred_list = preds.tolist()

    mape = mape_loss(preds, targets).item()
    print(f"\nMAPE after ensembling: {mape:.4f}")

    if output_dir:
        indices = [data.solution_index for data in loader.dataset]
        benchmark = loader.dataset[0].benchmark
        plot_prediction_bars(
            target_list, pred_list, indices, benchmark, 'area',
            output_path=os.path.join(output_dir, 'predictions.png'),
            mape=mape
        )
        plot_prediction_scatter(
            targets=target_list, 
            preds=pred_list, 
            output_path=os.path.join(output_dir, 'predictions_scatter.png'), 
            mape=mape
        )
        output_csv = os.path.join(output_dir, 'predictions.csv')
        with open(output_csv, 'w') as f:
            f.write("index,target,prediction\n")
            for idx, target, pred in zip(indices, targets, preds):
                f.write(f"{idx},{target},{pred}\n")

    return pred_list, target_list, mape


def evaluate_ensemble_swa(
    model: nn.Module,
    loader: DataLoader,
    mean_target: Tensor,
    std_target: Tensor,
    available_resources: Optional[Tensor] = None,
    output_dir: str = None
) -> Tuple[List[float], List[float], float]:
    targets, preds = [], []

    model.eval()
    with torch.no_grad():
        for data in loader:
            data = data.to(DEVICE)
            pred = model(data)
            targets.append(data.original_y)
            preds.append(torch.expm1(pred * std_target + mean_target))

    # Aggregate predictions from all models
    targets = compute_snru(torch.cat(targets, dim=0), available_resources)
    preds = compute_snru(torch.cat(preds, dim=0), available_resources)
    mape = mape_loss(preds, targets).item()

    print(f"\nMAPE with SWA: {mape:.4f}")

    target_list = targets.tolist()
    pred_list = preds.tolist()

    if output_dir:
        indices = [data.solution_index for data in loader.dataset]
        benchmark = loader.dataset[0].benchmark
        plot_prediction_bars(
            target_list, pred_list, indices, benchmark, 'area',
            output_path=os.path.join(output_dir, 'predictions.png'),
            mape=mape
        )
        plot_prediction_scatter(
            targets=target_list, 
            preds=pred_list, 
            output_path=os.path.join(output_dir, 'predictions_scatter.png'), 
            mape=mape
        )
        output_csv = os.path.join(output_dir, 'predictions.csv')
        with open(output_csv, 'w') as f:
            f.write("index,target,prediction\n")
            for idx, target, pred in zip(indices, targets, preds):
                f.write(f"{idx},{target},{pred}\n")
                
    return pred_list, target_list, mape


def evaluate(
    model: nn.Module,
    loader: DataLoader,
    epoch: int,
    mean_target: Tensor,
    std_target: Tensor,
    available_resources: Optional[Tensor] = None,
    update: bool = True
) -> float:
    global checkpoint_manager
    
    targets, preds = [], []

    for data in loader:
        data = data.to(DEVICE)
        pred = model(data)
        targets.append(data.original_y)
        preds.append(torch.expm1(pred * std_target + mean_target))

    targets = compute_snru(torch.cat(targets, dim=0), available_resources)
    preds = compute_snru(torch.cat(preds, dim=0), available_resources)
    mape = mape_loss(preds, targets).item()

    print(f"\nMAPE at epoch {epoch + 1}: {mape:.4f}")

    if not update:
        return mape

    if checkpoint_manager.check_improvement(mape, epoch + 1, update=True):
        indices = [data.solution_index for data in loader.dataset]
        checkpoint_manager.save_checkpoint(
            model=model, epoch=epoch + 1, mape=mape, 
            preds=preds, targets=targets, indices=indices,
            check_for_improvement=False
        )
        print(f"Saving model at epoch {epoch + 1} with MAPE = {mape:.4f}")

    return mape


def train_model(
    model: nn.Module,
    loss_fn: nn.Module,
    optimizer: Optimizer,
    train_loader: DataLoader,
    val_loader: DataLoader,
    test_loader: DataLoader,
    epochs: int,
    mean_target: Tensor,
    std_target: Tensor,
    max_norm: float = 5.0,
    scheduler: Optional[LRScheduler] = None,
    available_resources: Optional[Tensor] = None
) -> Tuple[List[float], List[float]]:
    train_mapes, val_mapes = [], []

    for epoch in range(epochs):
        targets, preds = [], []  
        model.train()
        for data in train_loader:
            optimizer.zero_grad()
            data = data.to(DEVICE)
            pred = model(data)
            loss = loss_fn(pred, data.y)
            loss.backward()
            clip_grad_norm_(model.parameters(), max_norm=max_norm)
            optimizer.step()
            if scheduler is not None:
                scheduler.step()

            targets.append(data.original_y)
            preds.append(torch.expm1(pred * std_target + mean_target))

        targets = compute_snru(torch.cat(targets, dim=0), available_resources)
        preds = compute_snru(torch.cat(preds, dim=0), available_resources)
        train_mape = mape_loss(preds, targets).item()
        train_mapes.append(train_mape)

        model.eval()
        with torch.no_grad():
            val_mape = evaluate(
                model=model, 
                loader=val_loader, 
                epoch=epoch,
                mean_target=mean_target,
                std_target=std_target,
                available_resources=available_resources
            )
            val_mapes.append(val_mape)

            if (epoch + 1) % 10 == 0 or (epoch + 1) == epochs:
                evaluate(
                    model=model,
                    loader=test_loader,
                    mean_target=mean_target,
                    std_target=std_target,
                    available_resources=available_resources,
                    update=False
                )

    return train_mapes, val_mapes


def main(args: Dict[str, Any]):
    global checkpoint_manager

    dataset_dir = args['dataset_dir']
    test_bench = args['test_bench']
    epochs = int(args['epoch'])
    batch_size = int(args['batch'])
    seed = int(args['seed'])
    learning_rate = float(args['learning_rate'])
    betas = tuple(map(float, args['betas']))
    weight_decay = float(args['weight_decay'])
    max_norm = float(args['max_norm'])
    loss = args['loss']
    output_dir = args['output_dir']
    val_ratio = float(args.get('val_ratio', 0.15))
    
    if not os.path.exists(dataset_dir):
        raise FileNotFoundError(f"Dataset directory not found: {dataset_dir}")

    full_dataset_dir = f"{dataset_dir}/full"
    if not os.path.exists(full_dataset_dir):
        raise FileNotFoundError(
            f"Full dataset directory {full_dataset_dir} does not exist."
        )
    
    matplotlib.use('Agg')
    torch.autograd.set_detect_anomaly(True)
    torch.set_printoptions(edgeitems=20, linewidth=200, sci_mode=False)

    set_random_seeds(seed)

    test_bench = test_bench.upper()
    benches = sorted(os.listdir(full_dataset_dir))
    train_benches = [b for b in benches if b != test_bench]

    model_args = {
        'in_channels': NODE_DIM_DICT,
        'hidden_channels': 100,
        'metadata': (NODE_TYPES, EDGE_TYPES),
        'num_layers': 3,
        'graph_attr_dim': GRAPH_ATTR_DIM,
        'heads': 4,
        'dropout': 0.1,
        'jk_mode': 'max'
    }
    model = HLSQoREstimator(**model_args).to(DEVICE)

    if loss == 'mse':
        loss_fn = nn.MSELoss()
    elif loss == 'l1':
        loss_fn = nn.L1Loss()
    elif loss == 'huber':
        delta = float(args.get('huber_delta', 1.0))
        if delta <= 0:
            raise ValueError("Huber delta must be a positive number.")
        loss_fn = nn.HuberLoss(delta=delta)
    else:
        raise ValueError(f"Unsupported loss function: {loss}")
    
    if not output_dir:
        output_dir = os.path.dirname(os.path.abspath(__file__))
        output_dir = os.path.join(output_dir, 'models')

    if not os.path.exists(output_dir):
        os.makedirs(output_dir, exist_ok=True)

    output_dir = os.path.join(output_dir, test_bench)
    if not os.path.exists(output_dir):
        output_dir = os.path.join(output_dir, "run_1")
    else:
        run_number = 1
        while os.path.exists(f"{output_dir}/run_{run_number}"):
            run_number += 1
        output_dir = f"{output_dir}/run_{run_number}"
    os.makedirs(output_dir, exist_ok=True)

    with open(f"{output_dir}/pretraining_args.json", 'w') as f:
        json.dump(args, f, indent=2)

    with open(f"{output_dir}/model_args.json", 'w') as f:
        json.dump(model_args, f, indent=2)
    
    train_loader, test_loader, val_loader, \
        scaling_stats, graph_attr_stats, target_stats = prepare_data_loaders(
        dataset_dir=dataset_dir, 
        test_benches=test_bench, 
        train_benches=train_benches, 
        batch_size=batch_size,
        validation_ratio=val_ratio
    )
    with open(f"{output_dir}/scaling_stats.json", 'w') as f:
        json.dump(scaling_stats, f, indent=2)
    with open(f"{output_dir}/graph_attr_scaling_stats.json", 'w') as f:
        json.dump(graph_attr_stats, f, indent=2)
    with open(f"{output_dir}/target_scaling_stats.json", 'w') as f:
        json.dump(target_stats, f, indent=2)

    grouped_params = group_params_for_weight_decay(
        model=model,
        weight_decay_val=weight_decay
    )
    optimizer = torch.optim.AdamW(
        grouped_params,
        lr=learning_rate, 
        betas=betas,
    )
    steps_per_epoch = len(train_loader)
    warmup_steps = 10 * steps_per_epoch
    annealing_steps = 100 * steps_per_epoch

    warmup = torch.optim.lr_scheduler.LinearLR(
        optimizer, start_factor=0.1, end_factor=1.0, total_iters=warmup_steps
    )
    cosine = torch.optim.lr_scheduler.CosineAnnealingWarmRestarts(
        optimizer, T_0=annealing_steps, T_mult=1, eta_min=1e-6
    )
    scheduler = torch.optim.lr_scheduler.SequentialLR(
        optimizer, schedulers=[warmup, cosine], milestones=[warmup_steps]
    )

    available_resources = torch.tensor(
        [AVAILABLE_RESOURCES[key] for key in AREA_METRICS],
        dtype=torch.float32,
        device=DEVICE
    )
    mean_target = torch.tensor(
        [target_stats[key]['mean'] for key in AREA_METRICS],
        dtype=torch.float32, device=DEVICE
    )
    std_target = torch.tensor(
        [target_stats[key]['std'] for key in AREA_METRICS],
        dtype=torch.float32, device=DEVICE
    )

    checkpoint_manager = CheckpointManager(output_dir=output_dir)

    train_errors, test_errors = train_model(
        model, loss_fn, optimizer, 
        train_loader, val_loader, test_loader, epochs, 
        scheduler=scheduler, 
        mean_target=mean_target, std_target=std_target,
        max_norm=max_norm,
        available_resources=available_resources
    )
    plot_learning_curves(
        train_errors=train_errors, 
        test_errors=test_errors, 
        output_path=f"{output_dir}/learning_curve.png"
    )

    model_paths, model_scores = [], []
    score_sum = 0.0
    for file in os.listdir(output_dir):
        if file.startswith('model_') and file.endswith('.pt'):
            model_index = file.split('_')[1].split('.')[0]
            if not model_index.isdigit():
                print(f"Skipping {file} as it does not have a valid index.")
                continue
            model_index = int(model_index)
            mape_path = os.path.join(output_dir, f'mape_{model_index}.txt')
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
            model_scores.append(score)
            model_paths.append(os.path.join(output_dir, file))
            score_sum += score

    if not model_paths:
        raise FileNotFoundError("No model files found in the specified model directory.")
    
    model_scores = [score / score_sum for score in model_scores]

    print(f"Ensembling {len(model_paths)} models with scores: {model_scores}")

    swa_state_dict = average_model_weights(model_paths, model_scores)
    model.load_state_dict(swa_state_dict)
    model.to(DEVICE)

    # Save the averaged model
    torch.save(swa_state_dict, os.path.join(output_dir, 'model.pt'))

    # Evaluate the ensemble model using SWA
    evaluate_ensemble_swa(
        model, 
        test_loader, 
        mean_target, std_target,
        available_resources=available_resources,
        output_dir=output_dir
    )
    # evaluate_ensemble(
    #     model, model_paths, model_scores, 
    #     test_loader, mean_target, std_target,
    #     available_resources=available_resources,
    #     output_dir=output_dir
    # )
    

def prepare_data_loaders(
    dataset_dir: str,
    test_benches: Union[List[str], str],
    train_benches: Union[List[str], str],
    batch_size: int = 32,
    validation_ratio: float = 0.15
) -> Tuple[DataLoader, DataLoader, StatsDict, StatsDict, StatsDict]:
    train_dataset = HLSDataset(
        root=dataset_dir, 
        mode="train",
        benchmarks=train_benches,
        scaling_stats=None,
        graph_attr_scaling_stats=None,
        target_scaling_stats=None
    )
    scaling_stats = train_dataset.scaling_stats
    graph_attr_scaling_stats = train_dataset.graph_attr_scaling_stats
    target_scaling_stats = train_dataset.target_scaling_stats

    if isinstance(test_benches, str):
        test_benches = [test_benches]

    test_dataset = HLSDataset(
        root=dataset_dir, 
        mode=f"test_{'_'.join(test_benches)}",
        benchmarks=test_benches,
        scaling_stats=scaling_stats,
        graph_attr_scaling_stats=graph_attr_scaling_stats,
        target_scaling_stats=target_scaling_stats,
    )
    num_train = len(train_dataset)
    num_val = int(num_train * validation_ratio)
    num_train -= num_val
    train_dataset, val_dataset = torch.utils.data.random_split(
        train_dataset, [num_train, num_val]
    )

    val_loader = DataLoader(val_dataset, batch_size=batch_size, shuffle=False)
    train_loader = DataLoader(train_dataset, batch_size=batch_size, shuffle=True)
    test_loader = DataLoader(test_dataset, batch_size=batch_size, shuffle=False)

    return (
        train_loader, test_loader, val_loader, 
        scaling_stats, graph_attr_scaling_stats, target_scaling_stats
    )

def parse_arguments():
    parser = argparse.ArgumentParser()
    parser.add_argument('-d', '--dataset-dir', type=str, default='estimators/area/dataset', 
                        help='The root directory of the dataset.')
    parser.add_argument('-tb', '--test-bench', type=str, required=True, 
                        help='The name of the benchmark to use for testing.')
    parser.add_argument('-e', '--epoch', type=int, default=300, 
                        help='The number of training epochs (default: 300).')
    parser.add_argument('-s', '--seed', type=int, default=999, 
                        help='Random seed for repeatability (default: 999).')
    parser.add_argument('-b', '--batch', type=int, default=32, 
                        help='The size of the training batch (default: 32).')
    parser.add_argument('-l', '--loss', type=str, default='mse', choices=['mse', 'l1', 'huber'],
                        help='The loss function to use for training (default: mse).')
    parser.add_argument('-lr', '--learning-rate', type=float, default=1e-4,
                        help='The learning rate for the optimizer (default: 1e-4).')
    parser.add_argument('-bs', '--betas', type=float, nargs=2, default=(0.9, 0.999),
                        help='The betas for the Adam optimizer (default: 0.9, 0.999).')
    parser.add_argument('-wd', '--weight-decay', type=float, default=1e-4,
                        help='Weight decay for the optimizer (default: 1e-4).')
    parser.add_argument('-mn', '--max-norm', type=float, default=5.0,
                        help='Maximum norm for gradient clipping (default: 5.0).')
    parser.add_argument('-hd', '--huber-delta', type=float, default=1.0,
                        help='Delta parameter for Huber loss (default: 1.0). Only used if loss is set to "huber".')
    parser.add_argument('-o', '--output-dir', type=str, default='',
                        help='Directory to save the output files (default: the script directory).')
    parser.add_argument('-vr', '--val-ratio', type=float, default=0.15,
                        help='Ratio of training data to use for validation (default: 0.15).')
    return vars(parser.parse_args())


if __name__ == '__main__':
    args = parse_arguments()
    main(args)