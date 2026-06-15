import os
import json
from pathlib import Path
from typing import Dict, List, Tuple, Callable, Union, Optional, Any

import torch
import torch.nn as nn
from torch import Tensor
from torch.nn.utils import clip_grad_norm_
from torch.optim import Optimizer
from torch.optim.lr_scheduler import LRScheduler
from torch_geometric.loader import DataLoader

from estimator.common.metrics import smape_loss
from estimator.common.visualization import (
    export_predictions_as_csv,
    plot_prediction_bars,
    plot_prediction_scatter
)
from estimator.common.model_utils import (
    EvalReport,
    set_random_seeds,
    prepare_train_test_loaders,
    prepare_optim,
    prepare_schedulers,
    get_loss_function
)
from estimator.cycles.models import ClockCyclesModel
from estimator.cycles.dataset import ClockCyclesDataset

DEVICE = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

METRIC_NAME = "cc"


@torch.no_grad()
def run_inference(
    model: nn.Module,
    loader: DataLoader
) -> Tuple[Tensor, Tensor]:
    preds, targets = [], []
    model.eval()
    for data in loader:
        data = data.to(DEVICE)
        out = model(
            x_dict=data.x_dict, 
            edge_index_dict=data.edge_index_dict, 
            y_anchor=data.y_anchor,
            batch_dict=data.batch_dict, 
            batch_size=data.num_graphs
        )
        pred = torch.exp(out + data.y_anchor.view_as(out))
        target = data.y_abs.view_as(pred)
        preds.append(pred)
        targets.append(target)
    preds = torch.cat(preds, dim=0)
    targets = torch.cat(targets, dim=0)
    return preds, targets


@torch.no_grad()
def evaluate(
    model: nn.Module,
    loader: DataLoader,
    as_tensor: bool = False
) -> EvalReport:
    model.eval()
    preds, targets = run_inference(model, loader)
    errors = smape_loss(preds, targets, reduce=False).view_as(preds)
    mape = torch.mean(errors, dim=0).item()
    if not as_tensor:
        preds = preds.flatten().tolist()
        targets = targets.flatten().tolist()
        errors = errors.flatten().tolist()

    return EvalReport(
        indices=[data.solution for data in loader.dataset],
        preds=preds,
        targets=targets,
        errors=errors,
        smape=mape
    )


@torch.no_grad()
def evaluate_ensemble(
    model: nn.Module,
    loader: DataLoader,
    snapshot_paths: List[str],
    as_tensor: bool = False
) -> EvalReport:
    """Evaluates an ensemble of models by averaging their predictions."""
    # Note: This assumes the loader is not shuffling.
    all_preds = []
    for path in snapshot_paths:
        state = torch.load(path, map_location=DEVICE, weights_only=False)
        model.load_state_dict(state)
        model.to(DEVICE)
        model.eval()
        preds, targets = run_inference(model, loader)
        all_preds.append(preds)

    avg_preds = torch.stack(all_preds).mean(dim=0).view_as(targets)
    errors = smape_loss(avg_preds, targets, reduce=False).view_as(targets)
    mape = torch.mean(errors, dim=0).item()
    if not as_tensor:
        avg_preds = avg_preds.flatten().tolist()
        targets = targets.flatten().tolist()
        errors = errors.flatten().tolist()

    return EvalReport(
        indices=[data.solution for data in loader.dataset],
        preds=avg_preds,
        targets=targets,
        errors=errors,
        smape=mape
    )


def train_epoch(
    model: nn.Module, 
    loader: DataLoader, 
    loss_fn: Union[nn.Module, Callable], 
    optim: Optimizer, 
    scheduler: LRScheduler
):
    model.train()
    for data in loader:
        optim.zero_grad()
        data = data.to(DEVICE)
        out = model(
            x_dict=data.x_dict, 
            edge_index_dict=data.edge_index_dict, 
            y_anchor=data.y_anchor,
            batch_dict=data.batch_dict, 
            batch_size=data.num_graphs
        )
        loss = loss_fn(out, data.y, data.benchmark_index)
        loss.backward()
        clip_grad_norm_(model.parameters(), max_norm=1.0)
        optim.step()
        scheduler.step()


def train_and_eval(
    model: nn.Module, 
    train_loader: DataLoader, 
    test_loader: DataLoader,
    loss_fn: Union[nn.Module, Callable], 
    optim: Optimizer, 
    output_dir: Path,
    scheduler: LRScheduler,
    warmup_scheduler: Optional[LRScheduler] = None,
    warmup_epochs: int = 5,
    num_cycles: int = 3,
    cycle_epochs: int = 25
):
    test_bench = test_loader.dataset[0].benchmark

    print("=======================================================")
    print("STARTING MODEL TRAINING")
    print(f"  Test Benchmark: {test_bench}")
    print("=======================================================")

    if warmup_epochs > 0 and warmup_scheduler is not None:
        print(f"Warming up ({warmup_epochs} epochs)...")
        for _ in range(warmup_epochs):
            train_epoch(model, train_loader, loss_fn, optim, warmup_scheduler)

    snap_paths = []
    snap_dir = output_dir / 'snap_reports'
    snap_dir.mkdir(exist_ok=True)

    for cycle in range(num_cycles):
        print(f"Cycle {cycle + 1}/{num_cycles}:")

        for _ in range(cycle_epochs):
            train_epoch(model, train_loader, loss_fn, optim, scheduler)
        
        rpt = evaluate(model, test_loader)
        print(f"Average SMAPE (Test Set): {rpt.smape:.4f}")

        rpt_path = snap_dir / f'{METRIC_NAME}_report_{cycle}.csv'
        export_predictions_as_csv(
            rpt.targets, rpt.preds, rpt.errors, rpt.indices, rpt_path
        )
        snap_path = output_dir / f'model_{cycle}.pt'
        torch.save(model.state_dict(), snap_path)
        snap_paths.append(snap_path)

    print("\n=======================================================")
    print("EVALUATING ENSEMBLE")
    print("=======================================================")

    final_rpt = evaluate_ensemble(model, test_loader, snap_paths)
    print(f"Final Ensemble SMAPE (Test Set): {final_rpt.smape:.4f}")
    export_eval_results(test_bench, final_rpt, output_dir)


def export_eval_results(test_bench, eval_rpt, output_dir):
    output_dir = Path(output_dir)
    barplot_path = output_dir / f'{METRIC_NAME}_barplot.png'
    scatterplot_path = output_dir / f'{METRIC_NAME}_scatterplot.png'
    rpt_path = output_dir / f'{METRIC_NAME}_report.csv'
    plot_prediction_bars(
        eval_rpt.targets, eval_rpt.preds, eval_rpt.indices, 
        test_bench, METRIC_NAME, barplot_path, 
        errors=eval_rpt.errors, mape=eval_rpt.smape
    )
    plot_prediction_scatter(
        eval_rpt.targets, eval_rpt.preds, test_bench, METRIC_NAME, 
        scatterplot_path, mape=eval_rpt.smape
    )
    export_predictions_as_csv(
        eval_rpt.targets, eval_rpt.preds, eval_rpt.errors, 
        eval_rpt.indices, rpt_path
    )


if __name__ == "__main__":
    import argparse
    import os
    import json

    def parse_arguments() -> Dict[str, Any]:
        parser = argparse.ArgumentParser(
            description='Pre-train estimator to infer the Total Clock Cycles of HLS designs.'
        )
        parser.add_argument('-t', '--test-bench', type=str, required=True,
                            help='Name of the benchmark to use for testing.')
        parser.add_argument('-d', '--dataset-dir', type=str, default='estimator/cycles/dataset',
                            help='Dataset root directory. Default: \'estimator/cycles/dataset\'')
        parser.add_argument('-o', '--output-dir', type=str, default='',
                            help='Directory to save the output files. Default: the script directory.')
        parser.add_argument('-s', '--seed', type=int, default=42, 
                            help='Random seed for repeatability. Default: 42.')
        parser.add_argument('-b', '--batch-size', type=int, default=96, 
                            help='The size of the training batch. Default: 96.')
        parser.add_argument('-l', '--loss', type=str, default='huber', choices=['mse', 'l1', 'huber', 'rank'],
                            help='The loss function to use for training. Default: \'huber\'.')
        parser.add_argument('-r', '--learning-rate', type=float, default=5e-4,
                            help='AdamW learning rate. Default: 5e-4.')
        parser.add_argument('-w', '--weight-decay', type=float, default=5e-4,
                            help='AdamW weight decay. Default: 5e-4.')
        parser.add_argument('--warmup-epochs', type=int, default=5,
                            help='Number of warmup epochs. Default: 5.')
        parser.add_argument('--num-cycles', type=int, default=3,
                            help='Number of training cycles for Snapshot Ensembles. Default: 3.')
        parser.add_argument('--cycle-epochs', type=int, default=25,
                            help='Number of epochs per training cycle. Default: 25.')
        parser.add_argument('--hidden-dim', type=int, default=96,
                            help='GNN hidden dimension (layer width). Default: 96')
        parser.add_argument('--num-layers-micro', type=int, default=2,
                            help='Number of layers of the 1st GNN (micro/low-level). Default: 2.')
        parser.add_argument('--num-layers-macro', type=int, default=3,
                            help='Number of layers of the 2nd GNN (macro/high-level). Default: 3.')
        parser.add_argument('--heads', type=int, default=4,
                            help='Number of attention heads. Default: 4.')
        parser.add_argument('--dropout', type=float, default=0.1,
                            help='Dropout probability. Default: 0.1.')
        return vars(parser.parse_args())

    args = parse_arguments()
    dataset_dir = args["dataset_dir"]
    test_bench = args["test_bench"].upper()

    batch_size = args["batch_size"]
    seed = args['seed']
    lr = args["learning_rate"]
    weight_decay = args["weight_decay"]
    loss = args['loss']
    warmup_epochs = args['warmup_epochs']
    num_cycles = args['num_cycles']
    cycle_epochs = args['cycle_epochs']

    hidden_dim = args["hidden_dim"]
    num_layers_micro = args["num_layers_micro"]
    num_layers_macro = args["num_layers_macro"]
    heads = args["heads"]
    dropout = args["dropout"]

    output_dir = args['output_dir']

    if not output_dir:
        cwd = os.path.dirname(os.path.abspath(__file__))
        output_dir = (Path(cwd) / 'models') / test_bench
    else:
        output_dir = Path(output_dir)

    output_dir.mkdir(parents=True, exist_ok=True)
    with open(output_dir / 'training_args.json', 'w') as f:
        json.dump(args, f, indent=2)

    set_random_seeds(seed)

    train_loader, test_loader = prepare_train_test_loaders(
        ClockCyclesDataset, dataset_dir, test_bench, 
        batch_size=batch_size, num_workers=4, pin_memory=True
    )

    loss_fn = get_loss_function(loss)

    model = ClockCyclesModel(
        hidden_dim=hidden_dim, 
        num_layers_micro=num_layers_micro, 
        num_layers_macro=num_layers_macro, 
        heads=heads, 
        dropout=dropout
    )
    model.to(DEVICE)

    optim = prepare_optim(model, lr, weight_decay)

    warmup_sched, cosine_sched = prepare_schedulers(
        train_loader, optim, cycle_epochs=cycle_epochs, 
        warmup_epochs=warmup_epochs
    )

    train_and_eval(
        model, train_loader, test_loader, loss_fn, optim, 
        output_dir, cosine_sched, warmup_scheduler=warmup_sched, 
        warmup_epochs=warmup_epochs, num_cycles=num_cycles, 
        cycle_epochs=cycle_epochs
    )