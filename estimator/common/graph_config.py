from dataclasses import dataclass
from typing import Set, Dict, Tuple, List


@dataclass
class GraphConfig:
    node_type_set: Set[str]
    edge_type_set: Set[Tuple[str, str, str]]
    macro_node_type_set: Set[str]
    macro_edge_type_set: Set[Tuple[str, str, str]]
    node_features: Dict[str, List[str]]
    features_to_log_scale: Set[str]
    optype_map: Dict[str, str]
    ops_to_trim: Set[str]
    connect_global_mem: bool