from typing import Union, Dict, Tuple, Optional

import torch
import torch.nn as nn
import torch.nn.functional as F
from torch import Tensor

from torch_geometric.nn.dense import Linear, HeteroDictLinear
from torch_geometric.nn.norm import LayerNorm
from torch_geometric.nn.conv import HGTConv
from torch_geometric.nn.aggr import AttentionalAggregation
from torch_geometric.nn.models import (
    JumpingKnowledge, 
    HeteroJumpingKnowledge
)
from torch_geometric.typing import NodeType, EdgeType

from estimator.common.layers import HeteroDictLayerNorm
from estimator.area.constants import (
    NODE_DIM_DICT,
    NODE_TYPES, 
    EDGE_TYPES,
    MACRO_NODE_TYPES, 
    MACRO_EDGE_TYPES,
    AREA_METRICS
)


class AreaModel(nn.Module):
    def __init__(
        self,
        hidden_dim: int,
        num_layers_micro: int = 2,
        num_layers_macro: int = 3,
        heads: int = 1,
        dropout: float = 0.0
    ):
        super().__init__()
        self.in_channels = NODE_DIM_DICT
        self.out_channels = len(AREA_METRICS)
        self.node_types = NODE_TYPES
        self.edge_types = EDGE_TYPES
        self.macro_node_types = MACRO_NODE_TYPES
        self.macro_edge_types = MACRO_EDGE_TYPES
        self.hidden_dim = hidden_dim
        self.num_layers_micro = num_layers_micro
        self.num_layers_macro = num_layers_macro
        self.heads = heads
        self.dropout = dropout

        self.proj_lin = HeteroDictLinear(self.in_channels, hidden_dim)
        self.proj_norm = HeteroDictLayerNorm(hidden_dim, self.node_types)

        metadata = (self.node_types, self.edge_types)
        self.convs_micro = nn.ModuleList()
        self.norms_micro = nn.ModuleList()
        for _ in range(num_layers_micro - 1):
            conv = HGTConv(hidden_dim, hidden_dim, metadata, heads=heads)
            norm = HeteroDictLayerNorm(hidden_dim, self.node_types)
            self.convs_micro.append(conv)
            self.norms_micro.append(norm)

        conv = HGTConv(hidden_dim, hidden_dim, metadata, heads=heads)
        norm = HeteroDictLayerNorm(hidden_dim, self.macro_node_types)
        self.convs_micro.append(conv)
        self.norms_micro.append(norm)

        self.jk_micro = HeteroJumpingKnowledge(self.macro_node_types, mode='cat')

        self.jk_micro_lin = HeteroDictLinear(
            hidden_dim * (num_layers_micro + 1), hidden_dim, 
            types=self.macro_node_types
        )
        self.jk_micro_norm = HeteroDictLayerNorm(hidden_dim, self.macro_node_types)

        macro_metadata = (self.macro_node_types, self.macro_edge_types)
        self.convs_macro = nn.ModuleList()
        self.norms_macro = nn.ModuleList()
        for _ in range(num_layers_macro - 1):
            conv = HGTConv(hidden_dim, hidden_dim, macro_metadata, heads=heads)
            norm = HeteroDictLayerNorm(hidden_dim, self.macro_node_types)
            self.convs_macro.append(conv)
            self.norms_macro.append(norm)

        conv = HGTConv(hidden_dim, hidden_dim, macro_metadata, heads=heads)
        norm = LayerNorm(hidden_dim)
        self.convs_macro.append(conv)
        self.norms_macro.append(norm)

        self.jk_macro = JumpingKnowledge(mode='cat')

        gnn_out_dim = hidden_dim * (num_layers_macro + 1)
        emb_dim = gnn_out_dim + self.out_channels

        self.global_att = AttentionalAggregation(
            gate_nn=nn.Sequential(
                Linear(gnn_out_dim, gnn_out_dim),
                nn.GELU(), nn.Dropout(dropout),
                Linear(gnn_out_dim, 1)
            )
        )

        self.mlp = nn.Sequential(
            nn.Linear(emb_dim, emb_dim // 2), 
            nn.GELU(), nn.Dropout(dropout),
            nn.Linear(emb_dim // 2, emb_dim // 4),
            nn.GELU(), nn.Dropout(dropout),
            nn.Linear(emb_dim // 4, emb_dim // 8),
            nn.GELU(),
            nn.Linear(emb_dim // 8, self.out_channels)
        )
        self.reset_parameters()

    def reset_parameters(self):
        self.proj_lin.reset_parameters()
        self.proj_norm.reset_parameters()
        for conv in self.convs_micro: conv.reset_parameters()
        for norm in self.norms_micro: norm.reset_parameters()
        self.jk_micro.reset_parameters()
        self.jk_micro_lin.reset_parameters()
        self.jk_micro_norm.reset_parameters()
        for conv in self.convs_macro: conv.reset_parameters()
        for norm in self.norms_macro: norm.reset_parameters()
        self.jk_macro.reset_parameters()
        self.global_att.reset_parameters()
        for layer in self.mlp:
            if isinstance(layer, nn.Linear):
                nn.init.kaiming_uniform_(layer.weight, nonlinearity='relu')
                if layer.bias is not None:
                    nn.init.zeros_(layer.bias)
    def forward(
        self, 
        x_dict: Dict[NodeType, Tensor],
        edge_index_dict: Dict[EdgeType, Tensor],
        y_anchor: Tensor,
        batch_dict: Optional[Dict[NodeType, Tensor]] = None,
        batch_size: Optional[int] = None,
        return_embedding: bool = False
    ) -> Union[Tensor, Tuple[Tensor, Tensor]]:
        if batch_dict is None:
            batch_dict = {
                nt: torch.zeros(x.size(0), dtype=torch.long, device=x.device) 
                for nt, x in x_dict.items()
            }
            batch_size = 1

        elif batch_size is None:
            batch_size = max([
                int(b.max()) + 1 for b in batch_dict.values() if b.numel() > 0
            ])

        macro_nts = self.macro_node_types
        macro_ets = self.macro_edge_types
        sub_batch_dict = {nt: batch_dict[nt] for nt in macro_nts}
        sub_edge_index_dict = {et: edge_index_dict[et] for et in macro_ets}
        region_batch = batch_dict['region']

        x_dict = self.proj_lin(x_dict)
        x_dict = {nt: F.gelu(x) for nt, x in x_dict.items()}
        x_dict = self.proj_norm(x_dict, batch_dict, batch_size)

        xs_dict = {nt: [x_dict[nt]] for nt in macro_nts}
        for i in range(self.num_layers_micro - 1):
            x_dict = self.convs_micro[i](x_dict, edge_index_dict)
            x_dict = self.norms_micro[i](x_dict, batch_dict, batch_size)
            for nt in macro_nts: 
                xs_dict[nt].append(x_dict[nt])

        x_dict = self.convs_micro[-1](x_dict, edge_index_dict)
        x_dict = {nt: x_dict[nt] for nt in macro_nts}
        x_dict = self.norms_micro[-1](x_dict, sub_batch_dict, batch_size)
        for nt, x in x_dict.items(): 
            xs_dict[nt].append(x)

        x_dict = self.jk_micro(xs_dict)
        x_dict = self.jk_micro_lin(x_dict)
        x_dict = self.jk_micro_norm(x_dict, sub_batch_dict, batch_size)

        xs = [x_dict['region']]
        for i in range(self.num_layers_macro - 1):
            x_dict = self.convs_macro[i](x_dict, sub_edge_index_dict)
            x_dict = self.norms_macro[i](x_dict, sub_batch_dict, batch_size)
            xs.append(x_dict['region'])
        
        x_dict = self.convs_macro[-1](x_dict, sub_edge_index_dict)
        x = self.norms_macro[-1](x_dict['region'], region_batch, batch_size)
        xs.append(x)

        x = self.jk_macro(xs)

        emb_att = self.global_att(x, index=region_batch, dim_size=batch_size)
        emb = torch.cat([emb_att, y_anchor], dim=-1)

        out = self.mlp(emb)

        if return_embedding: return out, emb
        return out
