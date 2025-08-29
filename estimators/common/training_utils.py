import os
import random
from typing import List, Optional

import numpy as np
import torch
from torch import nn, Tensor

from torch_geometric.nn import LayerNorm


class CheckpointManager:
    def __init__(
        self, 
        output_dir: str,  
        burn_in_epochs: int = 10,
        milestone_epochs: Optional[List[int]] = None
    ):
        if burn_in_epochs < 0:
            print("Warning: burn_in_epochs should be non-negative. Setting to 0.")
            burn_in_epochs = 0

        self.burn_in_epochs = burn_in_epochs
        self.output_dir = output_dir

        if not os.path.exists(self.output_dir):
            os.makedirs(self.output_dir)

        if milestone_epochs is None:
            milestone_epochs = [75, 150, 225]
            # milestone_epochs = [25, 50, 100, 150, 200, 250]
        else:
            if (not all(isinstance(epoch, int) for epoch in milestone_epochs) or
                not all(epoch >= self.burn_in_epochs for epoch in milestone_epochs)):
                raise ValueError(
                    "milestone_epochs must be a list of integers "
                    "greater than or equal to burn_in_epochs."
                )
            milestone_epochs = sorted(milestone_epochs)

        self.num_milestones = len(milestone_epochs)
        self.milestone_epochs = milestone_epochs

        # Initialize checkpoints
        self.mape_checkpoints = [float('inf')] * (self.num_milestones + 1)
        self.output_checkpoints = [None] * (self.num_milestones + 1)
        self.checkpoint_index = -1
    
    def check_improvement(self, mape: float, epoch: int, update: bool = True) -> bool:
        if epoch < self.burn_in_epochs:
            return False
        
        if self.checkpoint_index == -1:
            self.checkpoint_index = 0
            if update:
                self.mape_checkpoints[0] = mape
            return True
        
        if self.checkpoint_index < self.num_milestones:
            if epoch > self.milestone_epochs[self.checkpoint_index]:
                self.checkpoint_index += 1

        if mape < self.mape_checkpoints[self.checkpoint_index]:
            if update:
                self.mape_checkpoints[self.checkpoint_index] = mape
            return True
            
        return False
    
    def save_checkpoint(
        self, 
        model: nn.Module, 
        epoch: int, 
        mape: float,
        preds: Tensor, 
        targets: Tensor, 
        indices: List[int],
        check_for_improvement: bool = True
    ):
        if check_for_improvement:
            if not self.check_improvement(mape, epoch, update=True):
                return

        self.output_checkpoints[self.checkpoint_index] = preds

        model_path = f"{self.output_dir}/model_{self.checkpoint_index}.pt"
        preds_path = f"{self.output_dir}/predictions_{self.checkpoint_index}.csv"
        mape_path = f"{self.output_dir}/mape_{self.checkpoint_index}.txt"

        torch.save(obj=model.state_dict(), f=model_path)

        with open(preds_path, "w") as f:
            f.write(f"index,target,prediction\n")
            for index, target, pred in zip(indices, targets.tolist(), preds.tolist()):
                f.write(f"{index},{target},{pred}\n")
        
        with open(mape_path, "w") as f:
            f.write(f"Epoch {epoch + 1}: MAPE = {mape:.4f}\n")
        
    def get_checkpoint_index(self, epoch: int) -> int:
        if epoch <= self.burn_in_epochs:
            return -1
        
        for i, milestone in enumerate(self.milestone_epochs):
            if epoch <= milestone:
                return i
        
        return self.num_milestones
    
    def get_checkpoint_mape(self, epoch: int) -> float:
        index = self.get_checkpoint_index(epoch)
        if index == -1:
            return float('inf')
        return self.mape_checkpoints[index]
    
    def get_checkpoint_output(self, epoch: int) -> Optional[Tensor]:
        index = self.get_checkpoint_index(epoch)
        if index == -1:
            return None
        return self.output_checkpoints[index]
    
    def get_minimum_mape(self) -> float:
        return min(self.mape_checkpoints)
    
    def get_best_checkpoint_index(self) -> int:
        return self.mape_checkpoints.index(min(self.mape_checkpoints))
    
    def get_best_outputs(self) -> Optional[Tensor]:
        best_index = self.get_best_checkpoint_index()
        return self.output_checkpoints[best_index]
    
    def load_optimal_model(self, model, device=None):
        best_index = self.get_best_checkpoint_index()
        model_path = f"{self.output_dir}/model_{best_index}.pt"
        if not os.path.exists(model_path):
            raise FileNotFoundError(f"No model found at {model_path}")
        
        if device is None:
            model.load_state_dict(torch.load(model_path))
            return model

        model.load_state_dict(torch.load(model_path, map_location=device))
        model.to(device)
        return model


def group_params_for_weight_decay(model, weight_decay_val):
    """
    Separates model parameters into two groups: one with weight decay and one without.
    Excludes PReLU parameters, LayerNorm parameters, and all bias terms from weight decay.
    """
    decay_params = []
    no_decay_params = []
    
    no_decay_param_names = get_no_decay_param_names(model)

    # Create the two lists of parameters based on the exclusion set
    for name, param in model.named_parameters():
        if not param.requires_grad:
            continue
        
        if name in no_decay_param_names:
            no_decay_params.append(param)
        else:
            decay_params.append(param)
            
    optimizer_grouped_parameters = [
        {
            "params": decay_params,
            "weight_decay": weight_decay_val,
        },
        {
            "params": no_decay_params,
            "weight_decay": 0.0, # No weight decay for this group
        },
    ]
    return optimizer_grouped_parameters


def get_no_decay_param_names(model):
    no_decay_param_names = set()

    # Find all modules that are PReLU or LayerNorm and add 
    # their parameters to the exclusion set
    for module_name, module in model.named_modules():
        if isinstance(module, (nn.PReLU, nn.LayerNorm, LayerNorm)):
            for param_name, _ in module.named_parameters():
                # Add the full parameter name
                no_decay_param_names.add(f"{module_name}.{param_name}")

    # Add all bias terms to the exclusion set
    for param_name, _ in model.named_parameters():
        if param_name.endswith(".bias"):
            no_decay_param_names.add(param_name)

    return no_decay_param_names


def set_random_seeds(seed: int):
    torch.manual_seed(seed)
    torch.cuda.manual_seed(seed)
    torch.cuda.manual_seed_all(seed)
    np.random.seed(seed)
    random.seed(seed)