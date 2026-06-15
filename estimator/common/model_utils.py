import random
import os
from dataclasses import dataclass
from typing import (
    Dict, List, Tuple, Union, Set, Type,
    Optional, Any, Iterable, Callable
)

import numpy as np
import torch
import torch.nn as nn
from torch import Tensor
from torch.optim import Optimizer, AdamW
from torch.optim.lr_scheduler import (
    LRScheduler, 
    CosineAnnealingWarmRestarts, 
    LinearLR
)
import torch_geometric
import torch_geometric.nn as pyg_nn
from torch_geometric.loader import DataLoader

from estimator.common.dataset import BaseDataset
from estimator.common.sampler import BalancedBenchmarkSampler
from estimator.common.losses import GroupWiseRankingLoss
from estimator.common.constants import BENCHMARKS, BENCHMARK_INDEX_MAP


@dataclass
class EvalReport:
    indices: List[int]
    preds: Union[Tensor, List[float]]
    targets: Union[Tensor, List[float]]
    errors: Union[Tensor, List[float]]
    smape: float


def set_random_seeds(seed: int):
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)
    torch_geometric.seed_everything(seed)
    np.random.seed(seed)
    random.seed(seed)

    # Additional settings for deterministic run
    torch.backends.cudnn.deterministic = True
    torch.backends.cudnn.benchmark = False
    os.environ['PYTHONHASHSEED'] = str(seed)
    os.environ['CUBLAS_WORKSPACE_CONFIG'] = ':4096:8'
    torch.use_deterministic_algorithms(True, warn_only=True)


def get_no_decay_param_names(model: nn.Module) -> Set[str]:
    no_decay_param_names = set()
    for module_name, module in model.named_modules():
        if isinstance(
            module, 
            (nn.LayerNorm, nn.BatchNorm1d, pyg_nn.LayerNorm, pyg_nn.BatchNorm)
        ):
            for param_name, _ in module.named_parameters():
                prefix = f"{module_name}." if module_name else ""
                no_decay_param_names.add(f"{prefix}{param_name}")

    for param_name, _ in model.named_parameters():
        if param_name.endswith(".bias") or "norm" in param_name:
            no_decay_param_names.add(param_name)
        
    return no_decay_param_names


def group_params_for_weight_decay(
    model: nn.Module, 
    weight_decay: float
) -> List[Dict[str, Any]]:
    """
    Separates parameters into two groups: one with decay and one without.
    Excludes PReLU, Norm, and all bias terms from weight decay.
    """
    no_decay_param_names = get_no_decay_param_names(model)
    decay_params = []
    no_decay_params = []
    for name, param in model.named_parameters():
        if param.requires_grad:
            if name in no_decay_param_names: 
                no_decay_params.append(param)
            else: 
                decay_params.append(param)
    return [
        {"params": decay_params, "weight_decay": weight_decay},
        {"params": no_decay_params, "weight_decay": 0.0}
    ]


def seed_worker(worker_id):
    worker_seed = torch.initial_seed() % 2**32
    np.random.seed(worker_seed)
    random.seed(worker_seed)


def prepare_loader(
    dataset_class: Type[BaseDataset],
    dataset_dir: str, 
    benchmarks: Iterable[str],
    indices: Optional[List[int]] = None,
    batch_size: Optional[int] = None,
    balanced: bool = False,
    shuffle: bool = False,
    drop_last: bool = False,
    num_workers: int = 4,
    pin_memory: bool = True
) -> DataLoader:
    if isinstance(benchmarks, str): 
        benchmarks = [benchmarks]
    benchmarks = set(benchmarks)
    
    dataset = dataset_class(
        root=dataset_dir,
        benchmarks=benchmarks,
        valid_indices=indices
    )
    if batch_size is None:
        batch_size = len(dataset)
        drop_last = False

    if balanced and len(benchmarks) > 1:
        indices = []
        for data in dataset:
            if data.benchmark in benchmarks:
                indices.append(BENCHMARK_INDEX_MAP[data.benchmark])
        sampler = BalancedBenchmarkSampler(indices)
        shuffle = False
    else:
        sampler = None

    g = torch.Generator()
    g.manual_seed(0)

    return DataLoader(
        dataset, batch_size=batch_size, shuffle=shuffle,
        drop_last=drop_last, num_workers=num_workers,
        pin_memory=pin_memory, sampler=sampler,
        worker_init_fn=seed_worker, generator=g
    )


def prepare_train_test_loaders(
    dataset_class: Type[BaseDataset],
    dataset_dir: str, 
    test_bench: str,
    balanced: bool = True,
    batch_size: int = 64, 
    shuffle: bool = True,
    drop_last: bool = False,
    num_workers=4, 
    pin_memory=True
) -> Tuple[DataLoader, DataLoader]:
    test_bench = test_bench.upper()
    train_benches = [b for b in BENCHMARKS if b != test_bench]
    
    _ = dataset_class(root=dataset_dir)

    train_loader = prepare_loader(
        dataset_dir, train_benches, 
        balanced=balanced, batch_size=batch_size, 
        shuffle=shuffle, drop_last=drop_last, 
        num_workers=num_workers, pin_memory=pin_memory
    )
    test_loader = prepare_loader(
        dataset_dir, test_bench,
        balanced=False, batch_size=batch_size, 
        shuffle=False, drop_last=False, 
        num_workers=num_workers, pin_memory=pin_memory
    )
    return train_loader, test_loader


def prepare_optim(
    model: nn.Module, 
    lr: float = 5e-4, 
    weight_decay: float = 5e-4
) -> AdamW:
    grouped_params = group_params_for_weight_decay(model, weight_decay)
    return AdamW(grouped_params, lr=lr)


def prepare_schedulers(
    train_loader: DataLoader,
    optim: Optimizer,
    cycle_epochs: int = 25,
    warmup_epochs: int = 5
) -> Tuple[Optional[LRScheduler], LRScheduler]:
    steps_per_epoch = len(train_loader)
    annealing_steps = cycle_epochs * steps_per_epoch
    warmup_steps = warmup_epochs * steps_per_epoch
    cosine = CosineAnnealingWarmRestarts(optim, T_0=annealing_steps, T_mult=1)
    if warmup_steps == 0: 
        return None, cosine
    warmup = LinearLR(
        optim, start_factor=0.1, end_factor=1.0, 
        total_iters=warmup_steps
    )
    return warmup, cosine


def get_loss_function(loss_type: str) -> Union[nn.Module, Callable]:
    if loss_type == 'rank':
        return GroupWiseRankingLoss(margin=0.0, alpha=0.5, delta=1.0)
    if loss_type == 'mse': 
        loss_fn = nn.MSELoss()
    elif loss_type == 'l1': 
        loss_fn = nn.L1Loss()
    elif loss_type == 'huber': 
        loss_fn = nn.HuberLoss(delta=1.0)
    else:
        raise ValueError(f"Unsupported loss function: {loss_type}")
    return lambda y_pred, y, group_ids=None: loss_fn(y_pred, y)


def get_layerwise_decay_params(
    model: nn.Module, 
    initial_lr: float = 5e-4, 
    weight_decay: float = 5e-4, 
    decay_rate: float = 0.8
):
    params = []
    assigned_names = set()
    no_decay_names = get_no_decay_param_names(model)

    def add_param_groups(named_params, lr):
        decay_params, no_decay_params = [], []
        for n, p in named_params:
            if n in no_decay_names: 
                no_decay_params.append(p)
            else: 
                decay_params.append(p)
        if decay_params:
            params.append({
                'params': decay_params, 
                'lr': lr, 
                'weight_decay': weight_decay
            })
        if no_decay_params:
            params.append({
                'params': no_decay_params, 
                'lr': lr, 
                'weight_decay': 0.0
            })

    group_defs = [
        {'lr': initial_lr, 'prefixes': ['mlp.']},
        {'lr': initial_lr * decay_rate, 
         'prefixes': ['global_att', 'jk_macro.', 'convs_macro.', 'norms_macro.']},
        {'lr': initial_lr * (decay_rate ** 2), 
         'prefixes': ['jk_micro.', 'jk_micro_lin.', 'jk_micro_norm.']}
    ]
    for i in range(1, model.num_layers_micro):
        layer_decay = decay_rate ** (model.num_layers_micro - i + 1)
        group_defs.append({
            'lr': initial_lr * layer_decay,
            'prefixes': [f'convs_micro.{i}.', f'norms_micro.{i}.']
        })

    # Assign parameters to their respective groups
    all_named_params = [
        (n, p) for n, p in model.named_parameters() if p.requires_grad
    ]
    for group_def in group_defs:
        params_to_assign = []
        for n, p in all_named_params:
            if n not in assigned_names:
                if any(n.startswith(pfx) for pfx in group_def['prefixes']):
                    params_to_assign.append((n, p))
        if params_to_assign:
            add_param_groups(params_to_assign, group_def['lr'])
            assigned_names.update(n for n, _ in params_to_assign)

    remaining_params = [
        (n, p) for n, p in all_named_params if n not in assigned_names
    ]
    lowest_lr = initial_lr * (decay_rate ** model.num_layers_micro)
    add_param_groups(remaining_params, lowest_lr)

    return params