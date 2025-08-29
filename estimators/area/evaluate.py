import json
import os
from typing import Union, List

import torch
import torch.nn as nn
from torch import Tensor

from torch_geometric.loader import DataLoader

from estimators.common.parsers import AVAILABLE_RESOURCES, AREA_METRICS
from estimators.common.perf_visualization import plot_prediction_bars
from estimators.common.metrics import compute_snru
from estimators.common.losses import mape_loss
from estimators.area.models import HLSQoREstimator
from estimators.area.dataset import HLSDataset, StatsDict

DEVICE = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')


def evaluate(
    model: nn.Module,
    loader: DataLoader,
    mean_target: Tensor,
    std_target: Tensor,
    available_resources: Tensor
):
    targets, preds = [], []

    for data in loader:
        data = data.to(DEVICE)
        pred = model(data)
        targets.append(data.original_y)
        preds.append(torch.expm1(pred * std_target + mean_target))

    targets = compute_snru(torch.cat(targets, dim=0), available_resources)
    preds = compute_snru(torch.cat(preds, dim=0), available_resources)
    mape = mape_loss(preds, targets).item()

    preds = preds.tolist()
    targets = targets.tolist()
    for p, t in zip(preds, targets):
        print(f"Target: {t}; Prediction: {p}")

    print(f"MAPE: {mape:.4f}%")
    
    return preds, targets, mape


def load_model(model_path: str, model_args_path: str) -> nn.Module:
    with open(model_args_path, 'r') as f:
        model_args = json.load(f)
    metadata = model_args['metadata']
    model_args['metadata'] = (
        [ntype for ntype in metadata[0]],
        [(etype[0], etype[1], etype[2]) for etype in metadata[1]]
    )
    model = HLSQoREstimator(**model_args)

    model.load_state_dict(torch.load(model_path, map_location=DEVICE))
    return model.to(DEVICE)


def prepare_data_loader(
    dataset_dir: str,
    benchmarks: Union[str, List[str]],
    scaling_stats: StatsDict,
    target_scaling_stats: StatsDict,
    graph_attr_scaling_stats: StatsDict,
    batch_size: int = 32,
    mode: str = "evaluate"
) -> DataLoader:
    if isinstance(benchmarks, str):
        benchmarks = [benchmarks]
    dataset = HLSDataset(
        root=dataset_dir, 
        mode=mode,
        benchmarks=benchmarks,
        scaling_stats=scaling_stats,
        target_scaling_stats=target_scaling_stats,
        graph_attr_scaling_stats=graph_attr_scaling_stats
    )
    loader = DataLoader(
        dataset, 
        batch_size=batch_size, 
        shuffle=False,
        num_workers=4,
        pin_memory=True
    )
    return loader


def main(args):
    dataset_dir = args.get("dataset_dir")
    model_dir = args.get("model_dir")
    benchmark = args.get("benchmark")
    batch_size = args.get("batch_size", 32)
    output_dir = args.get("output_dir", "")

    if not os.path.exists(dataset_dir):
        raise FileNotFoundError(f"Dataset directory {dataset_dir} does not exist.")
    
    if not os.path.exists(model_dir):
        raise FileNotFoundError(f"Model directory {model_dir} does not exist.")

    model_path = os.path.join(model_dir, 'model.pt')
    model_args_path = os.path.join(model_dir, 'model_args.json')
    scaling_stats_path = os.path.join(model_dir, 'scaling_stats.json')
    target_scaling_stats_path = os.path.join(model_dir, 'target_scaling_stats.json')
    graph_attr_scaling_stats_path = os.path.join(model_dir, 'graph_attr_scaling_stats.json')

    required_paths = [
        dataset_dir, model_path, model_args_path, scaling_stats_path, 
        target_scaling_stats_path, graph_attr_scaling_stats_path
    ]
    if not all(os.path.exists(path) for path in required_paths):
        raise FileNotFoundError("One or more required paths do not exist.")

    with open(scaling_stats_path, 'r') as f:
        scaling_stats = json.load(f)
    
    with open(target_scaling_stats_path, 'r') as f:
        target_scaling_stats = json.load(f)
    
    with open(graph_attr_scaling_stats_path, 'r') as f:
        graph_attr_scaling_stats = json.load(f)

    loader = prepare_data_loader(
        dataset_dir, 
        benchmark, 
        scaling_stats, 
        target_scaling_stats,
        graph_attr_scaling_stats,
        batch_size=batch_size,
        mode=f"eval_{benchmark}"
    )
    model = load_model(model_path, model_args_path)

    available_resources = torch.tensor(
        [AVAILABLE_RESOURCES[key] for key in AREA_METRICS],
        dtype=torch.float32,
        device=DEVICE
    )
    mean_target = torch.tensor(
        [target_scaling_stats[key]['mean'] for key in AREA_METRICS],
        dtype=torch.float32, device=DEVICE
    )
    std_target = torch.tensor(
        [target_scaling_stats[key]['std'] for key in AREA_METRICS],
        dtype=torch.float32, device=DEVICE
    )

    model.eval()
    with torch.no_grad():
        preds, targets, mape = evaluate(
            model, loader, mean_target, std_target,
            available_resources=available_resources
        )

    if not output_dir:
        output_dir = os.path.dirname(model_path)

    os.makedirs(output_dir, exist_ok=True)

    output_csv = os.path.join(output_dir, f"predictions.csv")
    output_png = os.path.join(output_dir, f"predictions.png")

    indices = [data.solution_index for data in loader.dataset]

    with open(output_csv, 'w') as f:
        f.write("index,target,prediction\n")
        for idx, target, pred in zip(indices, targets, preds):
            f.write(f"{idx},{target},{pred}\n")

    plot_prediction_bars(
        targets=targets,
        preds=preds,
        indices=indices,
        benchmark=benchmark,
        metric="area",
        output_path=output_png,
        mape=mape
    )


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Evaluate HLS model")

    parser.add_argument("-m", "--model_dir", type=str, required=True,
                        help="Path to the pre-trained model directory")
    parser.add_argument("-b", "--benchmark", type=str, required=True, 
                        help="Benchmark name for evaluation")
    parser.add_argument("-d", "--dataset_dir", type=str, default="estimators/area/dataset",
                        help="Path to dataset directory")
    parser.add_argument("-bs", "--batch_size", type=int, default=32,
                        help="Batch size for evaluation")
    parser.add_argument("-o", "--output_dir", type=str, default="",
                        help="Directory to save outputs")

    main(vars(parser.parse_args()))