import json
import os
from typing import Dict, Optional, List, Any, Tuple

import torch
import torch.nn as nn
from torch import Tensor

from torch_geometric.loader import DataLoader

from estimators.common.parsers import AREA_METRICS, AVAILABLE_RESOURCES
from estimators.common.training_utils import get_no_decay_param_names
from estimators.common.losses import mape_loss
from estimators.common.metrics import compute_snru
from estimators.area.models import HLSQoREstimator
from estimators.area.dataset import HLSDataset, StatsDict


def get_layerwise_decay_params(model, initial_lr, weight_decay, decay_rate=0.9):
    """Creates parameter groups with a decaying learning rate for each layer."""

    def add_param_groups(named_params, lr, wd):
        decay_params = [p for n, p in named_params if n not in no_decay_param_names]
        no_decay_params = [p for n, p in named_params if n in no_decay_param_names]
        if decay_params:
            params.append({'params': decay_params, 'lr': lr, 'weight_decay': wd})
        if no_decay_params:
            params.append({'params': no_decay_params, 'lr': lr, 'weight_decay': 0.0})

    params = []
    assigned_param_names = set()
    no_decay_param_names = get_no_decay_param_names(model)
    num_gnn_layers = model.gnn.num_layers

    group_definitions = [
        # Head MLPs with the highest LR
        {'lr': initial_lr, 'prefixes': ['mlps.']},
        # JK, readout, and attention layers with intermediate LRs
        {'lr': initial_lr * decay_rate, 'prefixes': ['graph_att.', 'node_att.', 'gnn_out_ln.', 'graph_attr_mlp.']},
        {'lr': initial_lr * (decay_rate ** 1.5), 'prefixes': ['gnn.jk.', 'gnn.out_lin']},
    ]
    
    # Add GNN layers with decaying LR
    for i in range(num_gnn_layers):
        layer_lr = initial_lr * (decay_rate ** (num_gnn_layers - i + 1))
        group_definitions.append({
            'lr': layer_lr,
            'prefixes': [f'gnn.convs.{i}.', f'gnn.norms.{i}.']
        })

    # Assign parameters to their respective groups
    all_named_params = list(model.named_parameters())
    for group_def in group_definitions:
        params_to_assign = [
            (n, p) for n, p in all_named_params
            if n not in assigned_param_names and any(n.startswith(pfx) for pfx in group_def['prefixes'])
        ]
        if params_to_assign:
            add_param_groups(params_to_assign, group_def['lr'], weight_decay)
            assigned_param_names.update(n for n, p in params_to_assign)

    # Handle all remaining parameters with the lowest LR
    remaining_params = [(n, p) for n, p in all_named_params if n not in assigned_param_names]
    lowest_lr = initial_lr * (decay_rate ** (num_gnn_layers + 2))
    add_param_groups(remaining_params, lowest_lr, weight_decay)

    # Ensure all parameters have been assigned to a group
    all_params_in_groups = set(id(p) for group in params for p in group['params'])
    if len(all_params_in_groups) != len(all_named_params):
        raise ValueError("Some parameters were missed during grouping.")

    return params


def prepare_data_loader(
    dataset_dir: str, 
    benchmark: str,
    scaling_stats: StatsDict,
    target_scaling_stats: StatsDict,
    graph_attr_scaling_stats: StatsDict,
    batch_size: int = 4,
    mode: str = "fine_tune",
    preprocess: bool = True,
    processed_dataset_dir: Optional[str] = None
) -> DataLoader:
    if preprocess or processed_dataset_dir is None:
        dataset = HLSDataset(
            root=dataset_dir,
            mode=mode,
            benchmarks=benchmark,
            scaling_stats=scaling_stats,
            target_scaling_stats=target_scaling_stats,
            graph_attr_scaling_stats=graph_attr_scaling_stats,
        )
    else:
        dataset = []
        for filename in os.listdir(processed_dataset_dir):
            if filename.endswith('.pt') and filename.startswith(benchmark):
                data = torch.load(os.path.join(processed_dataset_dir, filename))
                dataset.append(data)

    loader = DataLoader(
        dataset, 
        batch_size=batch_size, 
        shuffle=True,
        num_workers=4,
        pin_memory=True
    )
    return loader


def evaluate(
    model: nn.Module,
    loader: DataLoader,
    mean_target: Tensor,
    std_target: Tensor,
    available_resources: Tensor,
    device: Optional[torch.device] = None
) -> Tuple[List[float], List[float], float]:
    if device is None:
        device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

    if available_resources is None:
        available_resources = torch.tensor(
            [AVAILABLE_RESOURCES[key] for key in AREA_METRICS],
            dtype=torch.float32,
            device=device
        )

    preds, targets = [], []
    model.eval()
    with torch.no_grad():
        for data in loader:
            data = data.to(device)
            pred = model(data)
            targets.append(data.original_y)
            preds.append(torch.expm1(pred * std_target + mean_target))

    targets = compute_snru(torch.cat(targets, dim=0), available_resources)
    preds = compute_snru(torch.cat(preds, dim=0), available_resources)
    mape = mape_loss(preds, targets).item()

    return preds.tolist(), targets.tolist(), mape


def load_pretrained_model(
    model_path: str, 
    model_args: Optional[Dict[str, Any]] = None,
    model_args_path: Optional[str] = None,
    device: Optional[torch.device] = None,
    **kwargs: Any
) -> Tuple[HLSQoREstimator, Dict[str, Any]]:
    if device is None:
        device = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')

    if model_args is None:
        if model_args_path is None or not os.path.exists(model_args_path):
            raise FileNotFoundError(f"Model args file {model_args_path} does not exist.")
        model_args = load_model_args(model_args_path, **kwargs)

    model = HLSQoREstimator(**model_args)
    model.load_state_dict(torch.load(model_path, map_location=device))
    model.to(device)
    return model


def load_model_args(model_args_path: str, **kwargs: Any) -> Dict[str, Any]:
    with open(model_args_path, 'r') as f:
        model_args = json.load(f)
    metadata = model_args['metadata']
    model_args['metadata'] = (
        [ntype for ntype in metadata[0]],
        [(etype[0], etype[1], etype[2]) for etype in metadata[1]]
    )
    model_args.update(kwargs)
    return model_args