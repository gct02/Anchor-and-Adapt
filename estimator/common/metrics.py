from typing import Dict, Union, List

import numpy as np
import torch
from torch import Tensor
from scipy.stats import kendalltau

from estimator.common.constants import AVAILABLE_RESOURCES


def compute_snru(
    util_dict: Dict[str, Union[Tensor, List[float]]],
    as_tensor: bool = True
) -> Union[Tensor, List[float]]:
    snru = None
    for m, avail in AVAILABLE_RESOURCES.items():
        if m not in util_dict:
            raise ValueError(f"Invalid 'util_dict': Missing {m}.")
        rel_util = torch.as_tensor(util_dict[m]) / avail
        if snru is None:
            snru = rel_util
        else:
            snru += rel_util
    if as_tensor: return snru
    return snru.flatten().tolist()


def compute_tau(preds: List[float], targets: List[float]):
    if len(np.unique(targets)) == 1: return None
    if len(np.unique(preds)) == 1: return 0.0
    tau, _ = kendalltau(preds, targets)
    return tau


def mape_loss(pred: Tensor, target: Tensor, eps: float = 1e-12, reduce: bool = True) -> Tensor:
    pred, target = map(torch.as_tensor, (pred, target))
    pred = pred.view_as(target)
    num = torch.abs(pred - target)
    denom = torch.clamp(torch.abs(target), min=eps)
    loss = num / denom
    if reduce: loss = torch.mean(loss)
    return loss * 100


def smape_loss(pred: Tensor, target: Tensor, eps: float = 1e-12, reduce: bool = True) -> Tensor:
    pred, target = map(torch.as_tensor, (pred, target))
    pred = pred.view_as(target)
    num = torch.abs(pred - target)
    denom = torch.clamp((torch.abs(pred) + torch.abs(target)) / 2.0, min=eps)
    loss = num / denom
    if reduce: loss = torch.mean(loss)
    return loss * 100


def metricwise_mape_loss(
    pred: Tensor, target: Tensor, metric: str, 
    eps: float = 1e-6, reduce: bool = True
) -> Tensor:
    if metric in ["bram", "dsp"]:
        return smape_loss(pred, target, eps=eps, reduce=reduce)
    return mape_loss(pred, target, eps=eps, reduce=reduce)