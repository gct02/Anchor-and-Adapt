import torch
from torch import Tensor

def compute_snru(util: Tensor, avail: Tensor) -> Tensor:
    """Compute the SNRU (Sum of Normalized Resource Utilization) metric."""
    if util.dim() == 1:
        util = util.unsqueeze(0)
    if avail.dim() == 1:
        avail = avail.unsqueeze(0)
        
    if util.size(1) != avail.size(1):
        raise ValueError(
            f"Expected util_resources and avail_resources with same number of columns, "
            f"got {util.size(1)} and {avail.size(1)}"
        )
    
    avail = avail.to(util.device)
    return torch.sum((util * 100) / avail, dim=1)