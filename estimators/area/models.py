from typing import Union, Dict, Optional

import torch
import torch.nn as nn
from torch import Tensor
from torch_geometric.nn import (
    Linear,
    HeteroDictLinear,
    LayerNorm,
    HGTConv,
    JumpingKnowledge
)
from torch_geometric.data import HeteroData
from torch_geometric.nn.aggr import AttentionalAggregation
from torch_geometric.typing import Metadata, NodeType, EdgeType

from estimators.area.dataset import NUM_TARGETS


class HGTJK(nn.Module):
    def __init__(
        self,
        in_channels: Union[int, Dict[NodeType, int]],
        hidden_channels: int,
        metadata: Metadata,
        num_layers: int,
        out_channels: Optional[int] = None,
        heads: int = 1,
        jk_mode: str = 'cat',
        apply_out_lin: bool = True
    ):
        super().__init__()

        self.node_types = metadata[0]
        self.edge_types = metadata[1]
        self.num_layers = num_layers
        self.jk_mode = jk_mode

        self.proj_lin = HeteroDictLinear(
            in_channels=in_channels,
            out_channels=hidden_channels,
            types=self.node_types
        )

        self.norms = nn.ModuleList()
        self.convs = nn.ModuleList()
        for _ in range(num_layers):
            norm = nn.ModuleDict({
                ntype: LayerNorm(hidden_channels) for ntype in self.node_types
            })
            conv = HGTConv(
                in_channels=hidden_channels,
                out_channels=hidden_channels,
                metadata=metadata,
                heads=heads
            )
            self.norms.append(norm)
            self.convs.append(conv)

        self.jk = nn.ModuleDict({
            ntype: JumpingKnowledge(
                mode=jk_mode, 
                channels=hidden_channels, 
                num_layers=num_layers
            )
            for ntype in self.node_types
        })

        if apply_out_lin:
            jk_out_dim = hidden_channels
            if jk_mode == 'cat':
                jk_out_dim *= num_layers

            if out_channels is None:
                out_channels = hidden_channels

            self.out_lin = HeteroDictLinear(
                in_channels=jk_out_dim, 
                out_channels=out_channels,
                types=self.node_types
            )
        else:
            self.out_lin = None

    def reset_parameters(self):
        """Reinitializes model parameters."""
        self.proj_lin.reset_parameters()

        for i in range(self.num_layers):
            self.convs[i].reset_parameters()
            for ntype in self.node_types:
                self.norms[i][ntype].reset_parameters()

        for ntype in self.node_types:
            self.jk[ntype].reset_parameters()

        if self.out_lin is not None:
            self.out_lin.reset_parameters()

    def forward(
        self,
        x_dict: Dict[NodeType, Tensor],
        edge_index_dict: Dict[EdgeType, Tensor],
        batch_dict: Dict[NodeType, Tensor],
        batch_size: Optional[int] = None
    ) -> Dict[NodeType, Tensor]:
        x_dict = self.proj_lin(x_dict)

        xs_dict = {nt: [] for nt in self.node_types}
        for i in range(self.num_layers):
            x_dict = {
                ntype: self.norms[i][ntype](
                    x_dict[ntype], batch_dict[ntype], 
                    batch_size=batch_size
                )
                for ntype in self.node_types
            }
            x_dict = self.convs[i](x_dict, edge_index_dict)
            for nt, x in x_dict.items():
                xs_dict[nt].append(x)

        x_dict = {
            nt: self.jk[nt](xs) for nt, xs in xs_dict.items()
        }
        if self.out_lin is not None:
            x_dict = self.out_lin(x_dict)
        return x_dict


class HLSQoREstimator(nn.Module):
    r"""Heterogeneous Graph Transformer (HGT) model with Jumping Knowledge and
    attention-based graph pooling for HLS QoR estimation.

    Args:
        in_channels (int or Dict[str, int]): Size of each input sample of every
            node type, or :obj:`-1` to derive the size from the first input(s)
            to the forward method.
        hidden_channels (int): Size of the hidden node feature vectors.
        metadata (Tuple[List[str], List[Tuple[str, str, str]]]): The metadata
            of the heterogeneous graph, *i.e.* its node and edge types given
            by a list of strings and a list of string triplets, respectively.
            See :meth:`torch_geometric.data.HeteroData.metadata` for more
            information.
        num_layers (int): Number of HGT layers.
        graph_attr_dim (int): Dimension of the graph-level attributes.
        heads (int, optional): Number of attention heads. (default: :obj:`1`)
        dropout (float, optional): Dropout probability. (default: :obj:`0.0`)
        jk_mode (str, optional): Jumping knowledge aggregation scheme to use.
            (default: :obj:`'cat'`)
        graph_attr_emb_dim (int, optional): Dimension of the graph attribute
            embedding. (default: :obj:`32`)
    """
    def __init__(
        self,
        in_channels: Union[int, Dict[NodeType, int]],
        hidden_channels,
        metadata: Metadata,
        num_layers: int,
        graph_attr_dim: int,
        heads: int = 1,
        dropout: float = 0.0,
        jk_mode: str = 'cat',
        graph_attr_emb_dim: int = 32
    ):
        super().__init__()

        self.num_layers = num_layers
        self.node_types = metadata[0]
        self.edge_types = metadata[1]

        self.gnn = HGTJK(
            in_channels=in_channels,
            hidden_channels=hidden_channels,
            metadata=metadata,
            num_layers=num_layers,
            out_channels=hidden_channels,
            heads=heads,
            jk_mode=jk_mode,
            apply_out_lin=False
        )
        gnn_out_dim = hidden_channels
        if jk_mode == 'cat':
            gnn_out_dim *= num_layers

        self._gnn_out_dim = gnn_out_dim

        self.gnn_out_ln = nn.ModuleDict({
            ntype: LayerNorm(gnn_out_dim) for ntype in self.node_types
        })

        # Attention-based graph pooling
        self.node_att = nn.ModuleDict()
        for ntype in self.node_types:
            gate_nn = nn.Sequential(
                Linear(gnn_out_dim, gnn_out_dim // 2),
                nn.PReLU(gnn_out_dim // 2),
                Linear(gnn_out_dim // 2, 1)
            )
            self.node_att[ntype] = AttentionalAggregation(gate_nn=gate_nn)

        self.graph_att = nn.MultiheadAttention(
            embed_dim=gnn_out_dim,
            kdim=gnn_out_dim,
            vdim=gnn_out_dim,
            num_heads=heads
        )

        # Small MLP to process graph attributes
        self.graph_attr_mlp = nn.Sequential(
            Linear(graph_attr_dim, graph_attr_emb_dim), 
            nn.LayerNorm(graph_attr_emb_dim), nn.GELU(),
            Linear(graph_attr_emb_dim, graph_attr_emb_dim)
        )
        graph_emb_dim = gnn_out_dim + graph_attr_emb_dim

        self.mlps = nn.ModuleList(
            [
                nn.Sequential(
                    nn.LayerNorm(graph_emb_dim),
                    Linear(graph_emb_dim, graph_emb_dim // 2), 
                    nn.LayerNorm(graph_emb_dim // 2), nn.GELU(), nn.Dropout(dropout),
                    Linear(graph_emb_dim // 2, graph_emb_dim // 4),
                    nn.LayerNorm(graph_emb_dim // 4), nn.GELU(), nn.Dropout(dropout),
                    Linear(graph_emb_dim // 4, 1)
                )
                for _ in range(NUM_TARGETS)
            ]
        )
        self.reset_parameters()

    def reset_parameters(self):
        """Reinitializes model parameters."""
        self.gnn.reset_parameters()

        for ntype in self.node_types:
            self.gnn_out_ln[ntype].reset_parameters()
            self.node_att[ntype].reset_parameters()
        self.graph_att._reset_parameters()

        for mlp in self.mlps:
            for layer in mlp:
                if hasattr(layer, 'reset_parameters'):
                    layer.reset_parameters()

        for layer in self.graph_attr_mlp:
            if hasattr(layer, 'reset_parameters'):
                layer.reset_parameters()

    def forward(self, data: HeteroData) -> Tensor:
        r"""Performs a forward pass of the model.
        
        Args:
            data (HeteroData): The input heterogeneous data object holding
                node features, edge indices, batch information, and graph-level
                attributes.
        Returns:
            Tensor: The output predictions of shape :obj:`[num_graphs, NUM_TARGETS]`.
        """
        x_dict = data.x_dict
        edge_index_dict = data.edge_index_dict
        batch_dict = data.batch_dict
        graph_attr = data.graph_attr
        
        batch_size = self._compute_batch_size(batch_dict)

        x_dict = self.gnn(x_dict, edge_index_dict, batch_dict, batch_size)
        x_dict = {
            ntype: self.gnn_out_ln[ntype](
                x_dict[ntype], batch_dict[ntype], 
                batch_size=batch_size
            )
            for ntype in self.node_types
        }

        pooled_nodes = []
        for ntype in self.node_types:
            if ntype in x_dict:
                pooled_node = self.node_att[ntype](
                    x_dict[ntype], batch_dict[ntype], 
                    dim_size=batch_size
                )
                pooled_nodes.append(pooled_node)
            else:
                pooled_nodes.append(
                    torch.zeros((batch_size, self._gnn_out_dim), device=graph_attr.device)
                )

        x = torch.stack(pooled_nodes, dim=0)
        attn_out, _ = self.graph_att(x, x, x)
        x = torch.mean(attn_out, dim=0)

        graph_attr_emb = self.graph_attr_mlp(graph_attr)
        x = torch.cat([x, graph_attr_emb], dim=-1)

        outs = []
        for mlp in self.mlps:
            outs.append(mlp(x))

        out = torch.cat(outs, dim=1)
        return out

    def _compute_batch_size(self, batch_dict: Dict[NodeType, Tensor]) -> int:
        batch_size = 0
        for batch in batch_dict.values():
            if batch.numel() > 0:
                batch_size = max(batch_size, int(batch.max().item()) + 1)
        return batch_size