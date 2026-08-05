import math
from typing import Dict, Optional, List

import torch
import torch.nn as nn
import torch.nn.functional as F
from torch import Tensor
from torch.nn.parameter import Parameter
from torch.nn.modules import Module, Dropout
from torch.nn.modules.container import Sequential, ModuleDict
from torch.nn.modules.activation import GELU

from torch_geometric.nn.conv import MessagePassing
from torch_geometric.nn.dense import HeteroLinear, Linear
from torch_geometric.nn.norm import LayerNorm
from torch_geometric.nn.inits import ones
from torch_geometric.utils import softmax
from torch_geometric.typing import NodeType


class HeteroDictLayerNorm(Module):
    def __init__(self, channels: int, node_types: List[NodeType]):
        super().__init__()
        self.norms = ModuleDict({
            nt: LayerNorm(channels) for nt in node_types
        })

    def reset_parameters(self):
        for norm in self.norms.values(): 
            norm.reset_parameters()

    def forward(
        self,
        x_dict: Dict[NodeType, Tensor],
        batch_dict: Optional[Dict[NodeType, Tensor]] = None,
        batch_size: Optional[int] = None
    ):
        out_dict = {}
        for nt, norm in self.norms.items():
            batch = batch_dict[nt] if batch_dict is not None else None
            out_dict[nt] = norm(x_dict[nt], batch, batch_size)
        return out_dict


class LightHGTConv(MessagePassing):
    def __init__(
        self,
        in_channels: int,
        out_channels: int,
        num_node_types: int,
        num_relations: int,
        heads: int = 1,
        dropout: float = 0.0,
        **kwargs
    ):
        super().__init__(aggr='add', node_dim=0, **kwargs)

        if out_channels % heads != 0:
            raise ValueError(
                f"'out_channels' (got {out_channels}) must be "
                f"divisible by the number of heads (got {heads})"
            )
        self.in_channels = in_channels
        self.out_channels = out_channels
        self.heads = heads
        self.dropout = dropout
        self.num_node_types = num_node_types
        self.num_relations = num_relations

        self.kqv_lin = HeteroLinear(in_channels, 3 * out_channels, num_node_types)
        self.out_lin = HeteroLinear(out_channels, out_channels, num_node_types)

        dim = out_channels // heads
        num_types = heads * num_relations
        self.k_rel = HeteroLinear(dim, dim, num_types, bias=False)
        self.v_rel = HeteroLinear(dim, dim, num_types, bias=False)
        self.p_rel = Parameter(torch.empty(num_relations, heads))

        self.reset_parameters()

    def reset_parameters(self):
        super().reset_parameters()
        self.kqv_lin.reset_parameters()
        self.out_lin.reset_parameters()
        self.k_rel.reset_parameters()
        self.v_rel.reset_parameters()
        ones(self.p_rel)

    def forward(
        self,
        x: Tensor,
        edge_index: Tensor,
        node_type_vec: Tensor,
        relation_vec: Tensor,
        type_vec: Optional[Tensor] = None
    ) -> Tensor:
        H, D = self.heads, self.out_channels // self.heads

        kqv = self.kqv_lin(x, node_type_vec)
        k, q, v = torch.tensor_split(kqv, 3, dim=1)
        k = k.view(-1, H, D)
        q = q.view(-1, H, D)
        v = v.view(-1, H, D)

        k = k[edge_index[0]].transpose(0, 1).reshape(-1, D)
        v = v[edge_index[0]].transpose(0, 1).reshape(-1, D)

        if type_vec is None:
            type_vec = (
                torch.arange(H, device=x.device).unsqueeze(1) 
                * self.num_relations + relation_vec.unsqueeze(0)
            ).flatten()

        k = self.k_rel(k, type_vec).view(H, -1, D).transpose(0, 1)
        v = self.v_rel(v, type_vec).view(H, -1, D).transpose(0, 1)
        p = self.p_rel[relation_vec]

        out = self.propagate(edge_index, k=k, q=q, v=v, edge_attr=p)
        out = self.out_lin(F.gelu(out), node_type_vec)
        return out
    
    def message(
        self, k: Tensor, q_i: Tensor, v: Tensor, edge_attr: Tensor,
        index: Tensor, ptr: Optional[Tensor], size_i: Optional[int]
    ) -> Tensor:
        alpha = (q_i * k).sum(dim=-1) * edge_attr
        alpha = alpha / math.sqrt(q_i.size(-1))
        alpha = softmax(alpha, index, ptr, size_i)
        alpha = F.dropout(alpha, p=self.dropout, training=self.training)
        out = v * alpha.view(-1, self.heads, 1)
        return out.reshape(-1, self.out_channels)

    def __repr__(self) -> str:
        return (f'{self.__class__.__name__}(-1, {self.out_channels}, '
                f'heads={self.heads})')


class GatedJumpingKnowledge(Module):
    def __init__(
        self,
        dim: int,
        num_layers: int
    ):
        super().__init__()
        self.gate = Linear(dim * num_layers, num_layers)
        self.reset_parameters()

    def reset_parameters(self):
        self.gate.reset_parameters()

    def forward(self, xs: List[Tensor]) -> Tensor:
        x_cat = torch.cat(xs, dim=-1)
        gate = torch.softmax(self.gate(x_cat), dim=1).unsqueeze(-1)
        x_stack = torch.stack(xs, dim=1)
        return (gate * x_stack).sum(dim=1)
    

class ResBlock(Module):
    def __init__(
        self, 
        in_channels: int, 
        out_channels: int, 
        dropout: float = 0.0
    ):
        super().__init__()
        self.block = Sequential(
            nn.Linear(in_channels, out_channels),
            GELU(),
            Dropout(dropout),
            nn.Linear(out_channels, out_channels)
        )
        self.skip = Parameter(torch.empty(1))
        self.reset_parameters()

    def reset_parameters(self):
        for layer in self.block:
            if isinstance(layer, nn.Linear):
                nn.init.kaiming_uniform_(layer.weight, nonlinearity='relu')
                if layer.bias is not None:
                    nn.init.zeros_(layer.bias)
        ones(self.skip)

    def forward(self, x):
        out = self.block(x)
        alpha = self.skip.sigmoid()
        out = alpha * out + (1 - alpha) * x
        return out
