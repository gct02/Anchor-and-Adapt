from typing import List, Dict, Tuple, Set

from estimator.common.dataset import BaseDataset
from estimator.power.constants import (
    NODE_TYPES, 
    EDGE_TYPES,
    NODE_DIM_DICT,
    FEATURES_TO_LOG_SCALE,
    DIRECTIVE_FEATURE_INDEX_MAP
)


class PowerDataset(BaseDataset):
    @property
    def default_root(self) -> str:
        return 'estimator/power/dataset'

    @property
    def target_metrics(self):
        return ['dynamic_power']
    
    @property
    def node_types(self) -> List[str]:
        return NODE_TYPES
    
    @property
    def edge_types(self) -> List[Tuple[str, str, str]]:
        return EDGE_TYPES

    @property
    def node_dim_dict(self) -> Dict[str, int]:
        return NODE_DIM_DICT

    @property
    def features_to_log_scale(self) -> Set[str]:
        return FEATURES_TO_LOG_SCALE

    @property
    def directive_feature_index_map(self) -> Dict[str, Dict[str, int]]:
        return DIRECTIVE_FEATURE_INDEX_MAP

    @property
    def use_log1p(self) -> bool:
        return False