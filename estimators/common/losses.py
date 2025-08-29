import torch
from torch import Tensor


def smape_loss(pred: Tensor, target: Tensor, eps: float = 1e-6) -> Tensor:
    pred, target = map(torch.as_tensor, (pred, target))
    num = torch.abs(pred - target)
    denom = (torch.abs(pred) + torch.abs(target)) / 2
    loss = num / (denom + eps)
    return torch.mean(loss)


def mape_loss(pred: Tensor, target: Tensor, eps: float = 1e-6) -> Tensor:
    loss = torch.abs(pred - target) / (torch.abs(target) + eps)
    return torch.mean(loss)