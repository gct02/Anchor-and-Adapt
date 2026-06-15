from typing import Optional, List

import torch
import torch.nn as nn
from torch import Tensor


class UncertaintyLoss(nn.Module):
    """
    Uncertainty-based loss for multi-task learning inspired on the loss function presented in
    `"Multi-Task Learning Using Uncertainty to Weigh Losses for Scene Geometry and Semantics" 
    <https://arxiv.org/abs/1705.07115>`_.
    """
    def __init__(self, target_metrics: List[str], loss_type: str = 'l1'):
        super(UncertaintyLoss, self).__init__()
        loss_type = loss_type.lower()
        self.loss_type = loss_type
        self.target_metrics = target_metrics
        self.num_tasks = len(target_metrics)

        # log_var represents log(sigma^2)
        self.log_var = nn.Parameter(torch.zeros(self.num_tasks))

        if loss_type == 'l1':
            self.task_loss_fn = nn.L1Loss(reduction='none')
        elif loss_type == 'mse':
            self.task_loss_fn = nn.MSELoss(reduction='none')
        else:
            raise ValueError(f"Unsupported loss function: {loss_type}. Use 'l1' or 'mse'.")

    def forward(self, y_pred: Tensor, y: Tensor,) -> Tensor:
        log_var = self.log_var.view(1, -1)

        # Compute task-specific loss, shape [batch, num_tasks]
        if y_pred.dim() == 3 and y_pred.shape[2] == 1: y_pred = y_pred.squeeze(-1)
        if y.dim() == 3 and y.shape[2] == 1: y = y.squeeze(-1)
             
        task_loss = self.task_loss_fn(y_pred, y)

        if self.loss_type == 'mse':
            # Gaussian formulation: 0.5 * exp(-log_var) * L2 + 0.5 * log_var
            precision = torch.exp(-log_var)
            weighted_loss = 0.5 * precision * task_loss + 0.5 * log_var
        else:
            # Laplacian formulation: exp(-0.5 * log_var) * L1 + 0.5 * log_var
            precision = torch.exp(-0.5 * log_var)
            weighted_loss = precision * task_loss + 0.5 * log_var

        # Mean across batch, sum across tasks
        return weighted_loss.mean(dim=0).sum()


class GroupWiseRankingLoss(nn.Module):
    def __init__(self, margin=0.0, alpha=0.5, delta=1.0):
        super().__init__()
        self.alpha = alpha
        self.huber_loss = nn.HuberLoss(delta=delta)
        self.margin = margin

    def forward(
        self, 
        pred: Tensor, 
        target: Tensor, 
        group_ids: Optional[Tensor] = None
    ) -> Tensor:
        pred = pred.view(-1)
        target = target.view(-1)
        if group_ids is not None: group_ids = group_ids.view(-1)
            
        # Standard Regression Loss
        reg_loss = self.huber_loss(pred, target)
        
        # Pairwise Ranking Loss
        pred_diff = pred.unsqueeze(1) - pred.unsqueeze(0)
        target_diff = target.unsqueeze(1) - target.unsqueeze(0)

        # Create the ground-truth ordering signs {-1, 0, 1}
        target_signs = torch.sign(target_diff)
        
        # Mask out ties, as they provide no ranking signal
        mask = (target_signs != 0)

        if group_ids is not None:
            group_mask = (group_ids.unsqueeze(1) == group_ids.unsqueeze(0))
            mask = mask & group_mask
        
        # Loss = max(0, -sign * (pred_i - pred_j) + margin)
        rank_loss_matrix = torch.relu(-target_signs * pred_diff + self.margin)
        
        # Apply mask and compute mean only over valid pairs
        # We allow the loss to be 0 if there are no valid pairs
        valid_pairs = mask.sum()
        if valid_pairs > 0:
            rank_loss = (rank_loss_matrix * mask.to(rank_loss_matrix.dtype)).sum() / valid_pairs
        else:
            rank_loss = torch.tensor(0.0, device=pred.device)

        # Combined Loss
        return (1 - self.alpha) * reg_loss + self.alpha * rank_loss