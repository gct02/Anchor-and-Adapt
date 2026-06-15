from estimator.common.graph import BaseKernelGraph
from estimator.common.graph_config import GraphConfig
from estimator.cycles import constants


class ClockCyclesKernelGraph(BaseKernelGraph):
    
    def get_config(self) -> GraphConfig:
        return GraphConfig(
            node_type_set=constants.NODE_TYPE_SET,
            edge_type_set=constants.EDGE_TYPE_SET,
            macro_node_type_set=constants.MACRO_NODE_TYPE_SET,
            macro_edge_type_set=constants.MACRO_EDGE_TYPE_SET,
            node_features=constants.NODE_FEATURES,
            features_to_log_scale=constants.FEATURES_TO_LOG_SCALE,
            optype_map=constants.OPTYPE_MAP,
            ops_to_trim=constants.OPS_TO_TRIM,
            connect_global_mem=False
        )