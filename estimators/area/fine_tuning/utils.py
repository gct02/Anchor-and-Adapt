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
    """Creates parameter groups with a decaying learning rate for each GNN layer."""
    params = []
    no_decay_param_names = get_no_decay_param_names(model)

    # Add the head MLPs with the highest learning rate
    head_prefixes = ['mlps.']
    params.append({
        'params': [
            p for n, p in model.named_parameters() 
            if any(n.startswith(prefix) for prefix in head_prefixes)
            and n not in no_decay_param_names
        ],
        'lr': initial_lr,
        'weight_decay': weight_decay
    })
    params.append({
        'params': [
            p for n, p in model.named_parameters() 
            if any(n.startswith(prefix) for prefix in head_prefixes)
            and n in no_decay_param_names
        ],
        'lr': initial_lr,
        'weight_decay': 0.0
    })

    # Add each GNN layer with a successively larger LR
    num_gnn_layers = model.gnn.num_layers
    for i in range(num_gnn_layers):
        layer_lr = initial_lr * (decay_rate ** (num_gnn_layers - i + 1))
        layer_prefixes = [f'gnn.convs.{i}.', f'gnn.norms.{i}.']
        params.append({
            'params': [
                p for n, p in model.named_parameters() 
                if any(n.startswith(prefix) for prefix in layer_prefixes)
                and n not in no_decay_param_names
            ],
            'lr': layer_lr,
            'weight_decay': weight_decay
        })
        params.append({
            'params': [
                p for n, p in model.named_parameters() 
                if any(n.startswith(prefix) for prefix in layer_prefixes)
                and n in no_decay_param_names
            ],
            'lr': layer_lr,
            'weight_decay': 0.0
        })

    # For JK, node_lin and pool layers, use a LR that is slightly lower than the head MLPs
    jk_readout_prefixes = ['gnn.jk.', 'gnn.out_lin']
    params.append({
        'params': [
            p for n, p in model.named_parameters() 
            if any(n.startswith(prefix) for prefix in jk_readout_prefixes)
            and n not in no_decay_param_names
        ],
        'lr': initial_lr * (decay_rate ** 1.5),
        'weight_decay': weight_decay
    })
    params.append({
        'params': [
            p for n, p in model.named_parameters() 
            if any(n.startswith(prefix) for prefix in jk_readout_prefixes)
            and n in no_decay_param_names
        ],
        'lr': initial_lr * (decay_rate ** 1.5),
        'weight_decay': 0.0
    })

    glob_att_prefixes = ['graph_att.', 'node_att.', 'gnn_out_ln.', 'graph_attr_mlp.']
    params.append({
        'params': [
            p for n, p in model.named_parameters() 
            if any(n.startswith(prefix) for prefix in glob_att_prefixes)
            and n not in no_decay_param_names
        ],
        'lr': initial_lr * decay_rate,
        'weight_decay': weight_decay
    })
    params.append({
        'params': [
            p for n, p in model.named_parameters() 
            if any(n.startswith(prefix) for prefix in glob_att_prefixes)
            and n in no_decay_param_names
        ],
        'lr': initial_lr * decay_rate,
        'weight_decay': 0.0
    })

    # Finally, add any remaining parameters with the lowest LR
    prefixes = head_prefixes + glob_att_prefixes + ['gnn.convs.', 'gnn.norms.']
    params.append({
        'params': [
            p for n, p in model.named_parameters() 
            if not any(n.startswith(pfx) for pfx in prefixes)
            and n not in no_decay_param_names
        ],
        'lr': initial_lr * (decay_rate ** (num_gnn_layers + 2)),
        'weight_decay': weight_decay
    })
    params.append({
        'params': [
            p for n, p in model.named_parameters() 
            if not any(n.startswith(pfx) for pfx in prefixes)
            and n in no_decay_param_names
        ],
        'lr': initial_lr * (decay_rate ** (num_gnn_layers + 2)),
        'weight_decay': 0.0
    })

    # Filter out any empty parameter groups
    params = [p for p in params if p['params']]

    # Ensure all parameters are included
    all_params = set(p for group in params for p in group['params'])
    missing_params = set(model.parameters()) - all_params
    if missing_params:
        raise ValueError(f"Some parameters are not included in any group: {missing_params}")

    return params


def prepare_data_loader(
    dataset_dir: str, 
    benchmark: str,
    scaling_stats: StatsDict,
    target_scaling_stats: StatsDict,
    graph_attr_scaling_stats: StatsDict,
    batch_size: int = 5,
    mode: str = "fine_tune",
    preprocess: bool = True,
    processed_dataset_dir: Optional[str] = None
) -> DataLoader:
    if preprocess or processed_dataset_dir is None:
        if not isinstance(benchmark, list):
            benchmark = [benchmark]
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