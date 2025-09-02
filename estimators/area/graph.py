import os
import json
import copy
import math
import re
import pickle
import xml.etree.ElementTree as ET
from typing import Optional, Dict, List, Any, Union

import torch
import numpy as np

from estimators.common.xml_utils import findint, findfloat
from estimators.common.parsers import (
    AREA_METRICS,
    extract_per_module_area,
    extract_area_metrics,
    parse_tcl_directives,
    extract_auto_dcts_from_log
)

DIRECTIVES = [
    "array_partition", "loop_flatten",
    "loop_merge", "pipeline", "unroll",
    "inline", "dataflow"
]

OP_CATEGS = [
    'mem', 'control', 'arith_int', 'arith_fp',
    'logical', 'data_manipulation', 'conversion',
    'rel_spec', 'io'
]
OP_CATEG_MAP = {
    'alloca': 'mem', 'load': 'mem', 
    'store': 'mem', 'getelementptr': 'mem',
    'br': 'control', 'ret': 'control', 
    'call': 'control', 'switch': 'control',
    'add': 'arith_int', 'sub': 'arith_int', 'mul': 'arith_int',
    'dadd': 'arith_fp', 'dsub': 'arith_fp', 'dmul': 'arith_fp',
    'ddiv': 'arith_fp', 'dsqrt': 'arith_fp', 'dexp': 'arith_fp',
    'sitodp': 'arith_fp',
    'and': 'logical', 'or': 'logical', 'xor': 'logical',
    'shl': 'logical', 'lshr': 'logical', 'ashr': 'logical',
    'phi': 'data_manipulation', 'select': 'data_manipulation',
    'mux': 'data_manipulation', 'sparsemux': 'data_manipulation',
    'bitconcatenate': 'data_manipulation', 'bitselect': 'data_manipulation',
    'partselect': 'data_manipulation', 'insertvalue': 'data_manipulation',
    'extractvalue': 'data_manipulation',
    'zext': 'conversion', 'sext': 'conversion',
    'trunc': 'conversion', 'bitcast': 'conversion',
    'icmp': 'rel_spec', 'cttz': 'rel_spec',
    'read': 'io', 'write': 'io'
}

OPCODES = [
    'alloca', 'load', 'store', 'getelementptr',
    'br', 'ret', 'call', 'switch',
    'add', 'sub', 'mul',
    'dadd', 'dsub', 'dmul', 'ddiv', 'dsqrt', 'dexp', 'sitodp',
    'and', 'or', 'xor', 'shl', 'lshr', 'ashr',
    'phi', 'select', 'mux', 'sparsemux', 'bitconcatenate',
    'bitselect', 'partselect', 'insertvalue', 'extractvalue',
    'zext', 'sext', 'trunc', 'bitcast',
    'icmp', 'cttz',
    'read', 'write',
    'unknown'
]
OPCODE_MAP = {op: i for i, op in enumerate(OPCODES)}
NUM_OPCODES = len(OPCODES) 

BASE_TYPE_MAP = {
    '11': 0, # Integer
    '1': 1,  # Floating-point types
    '2': 1,
    '3': 1,
    '4': 1,
    '5': 1,
    '6': 1,
    'unknown': 2,
    'none': 3
}
NUM_BASE_TYPES = len(set(BASE_TYPE_MAP.values()))

CONST_TYPES = ['0', '1', '3', '5']
CONST_TYPE_MAP = {ctype: i for i, ctype in enumerate(CONST_TYPES)}
NUM_CONST_TYPES = len(CONST_TYPES)

CORE_TYPES = [
    'TAddSub', 'LogicGate', 'Shifter', 'Int2Double',
    'Multiplexer', 'Adder', 'DMul_maxdsp', 'SparseMux',
    'Sel', 'DSqrt', 'RAM', 'DAddSub_fulldsp',
    'ROM_1P_LUTRAM', 'ROM', 'DDiv', 'Cmp',
    'DSP48', 'Multiplier', 'DExp_fulldsp', 'none'
]
CORE_TYPE_MAP = {name: i for i, name in enumerate(CORE_TYPES)}
NUM_CORE_TYPES = len(CORE_TYPES)

RELATION_TYPES = [
    'data', 'control' 'memory',
    'hier', 'hier_rev', 'store', 'alloca',
    'port', 'internal_mem', 
    'port_rev', 'internal_mem_rev',
    'call', 'ret', 'arg', 
    'module_hier', 'module_hier_rev'
]
RELATION_TYPE_MAP = {etype: i for i, etype in enumerate(RELATION_TYPES)}
NUM_RELATION_TYPES = len(RELATION_TYPES)

NODE_TYPES = ['port', 'internal_mem', 'op', 'const', 'block', 'region', 'function']
NODE_TYPE_MAP = {ntype: i for i, ntype in enumerate(NODE_TYPES)}
NUM_NODE_TYPES = len(NODE_TYPES)

EDGE_TYPES = [
    ('port', 'port', 'function'), ('function', 'module_hier', 'function'), 
    ('region', 'hier', 'op'), ('block', 'control', 'block'), 
    ('function', 'module_hier_rev', 'function'), ('function', 'hier', 'block'), 
    ('const', 'data', 'op'), ('function', 'internal_mem_rev', 'internal_mem'), 
    ('op', 'memory', 'op'), ('region', 'hier_rev', 'function'), 
    ('internal_mem', 'data', 'op'), ('op', 'alloca', 'internal_mem'), 
    ('region', 'hier', 'block'), ('function', 'hier', 'region'), 
    ('op', 'data', 'internal_mem'), ('op', 'store', 'internal_mem'), 
    ('port', 'arg', 'port'), ('op', 'hier_rev', 'function'), 
    ('region', 'hier', 'region'), ('op', 'data', 'op'), ('op', 'hier_rev', 'block'), 
    ('region', 'hier_rev', 'region'), ('block', 'hier', 'op'), 
    ('op', 'hier_rev', 'region'), ('block', 'hier_rev', 'function'), 
    ('op', 'store', 'port'), ('op', 'call', 'function'), ('port', 'data', 'op'), 
    ('op', 'control', 'op'), ('function', 'port_rev', 'port'), 
    ('internal_mem', 'internal_mem', 'function'), ('block', 'hier_rev', 'region'), 
    ('function', 'ret', 'op'), ('function', 'hier', 'op'), ('block', 'control', 'op'), 
    ('op', 'control', 'block')
] + [
    (ntype, 'self', ntype) for ntype in NODE_TYPES
]

MAX_ARRAY_DIM = 4
MAX_LOOP_DEPTH = 5

DEFAULT_NODE_FEATURES_DICT = {
    'port': {
        'bitwidth': 0,
        'direction': [0] * 3,
        'is_top_level_port': 0,
        'is_array': 0,
        'array_size': 0,
        'is_large_array': 0,
        'base_type': [0] * NUM_BASE_TYPES,
        'original_array_dims': [0] * MAX_ARRAY_DIM,
        'array_partition': 0,
        'partition_type': [0] * 3,
        'partition_dim': [0] * (MAX_ARRAY_DIM + 1),
        'partition_factor': 0,
        'is_unevenly_partitioned': 0,
        'has_hybrid_impl': 0
    },
    'internal_mem': {
        'bitwidth': 0,
        'is_global_mem': 0,
        'is_array': 0,
        'array_size': 0,
        'is_large_array': 0,
        'base_type': [0] * NUM_BASE_TYPES,
        'original_array_dims': [0] * MAX_ARRAY_DIM,
        'array_partition': 0,
        'partition_type': [0] * 3,
        'partition_dim': [0] * (MAX_ARRAY_DIM + 1),
        'partition_factor': 0,
        'is_unevenly_partitioned': 0,
        'has_hybrid_impl': 0,
        **{f'internal_mem_{metric}': 0 for metric in AREA_METRICS}
    },
    'op': {
        'bitwidth': 0,
        'opcode': [0] * NUM_OPCODES,
        'core_type': [0] * NUM_CORE_TYPES,
        'delay': 0.0,
        'is_on_critical_path': 0,
        'callee_size': 0,
        **{f'op_{metric}': 0 for metric in AREA_METRICS}
    },
    'const': {
        'bitwidth': 0,
        'const_type': [0] * NUM_CONST_TYPES
    },
    'block': {
        'block_num_ops': 0,
        **{f'block_num_{categ}_ops': 0 for categ in OP_CATEGS},
        **{f'block_{metric}_sum': 0 for metric in AREA_METRICS}
    },
    'region': {
        'is_loop': 0,
        'latency': 0,
        'trip_count': 0,
        'ii': 0, 'il': 0,
        'loop_depth': [0] * (MAX_LOOP_DEPTH + 1),
        'has_perfectly_nested_child': 0,
        'is_part_of_perfect_nest': 0,
        'pipeline': 0,
        'unroll': 0,
        'unroll_factor': 0,
        'loop_flatten': 0,
        'loop_merge': 0,
        'region_num_ops': 0,
        'region_num_blocks': 0,
        'region_num_sub_regions': 0,
        **{f'region_num_{categ}_ops': 0 for categ in OP_CATEGS},
        **{f'region_{metric}_sum': 0 for metric in AREA_METRICS}
    },
    'function': {
        'is_top_level_function': 0,
        'bitwidth': 0,
        'latency': 0,
        'loop_merge': 0,
        'inline': 0,
        'dataflow': 0,
        'num_array_ports': 0,
        'num_internal_arrays': 0,
        'function_num_ops': 0,
        'function_num_blocks': 0,
        'function_num_sub_regions': 0,
        **{f'function_num_{categ}_ops': 0 for categ in OP_CATEGS},
        **{f'module_{metric}': 0 for metric in AREA_METRICS}
    }
}
NODE_FEATURES_DICT = {
    ntype: list(DEFAULT_NODE_FEATURES_DICT[ntype].keys())
    for ntype in NODE_TYPES
}

NUMERICAL_FEATURES = [
    'bitwidth', 'delay', 'callee_size',
    'ii', 'il', 'latency', 'trip_count',
    'array_size', 'original_array_dims',
    'partition_factor', 'unroll_factor',
    'block_num_ops', 'region_num_ops', 'function_num_ops',
    'region_num_sub_regions', 'region_num_blocks',
    'function_num_sub_regions', 'function_num_blocks'
] + [
    f'block_num_{categ}_ops' for categ in OP_CATEGS
] + [
    f'region_num_{categ}_ops' for categ in OP_CATEGS
] + [
    f'function_num_{categ}_ops' for categ in OP_CATEGS
] + [
    f'module_{metric}' for metric in AREA_METRICS
] + [
    f'block_{metric}_sum' for metric in AREA_METRICS
] + [
    f'region_{metric}_sum' for metric in AREA_METRICS
] + AREA_METRICS

NO_LOG_SCALING_KEYS = ['bitwidth', 'delay']

GRAPH_ATTRS = [
    'num_nodes', 'num_edges', 'num_ops',
    'num_blocks', 'num_functions', 'num_loops',
    'num_arrays', 'num_mem_ops', 'num_arith_ops',
    'mem_intensity', 'num_int_ops', 'num_fp_ops',
    'num_branch_ops', 'avg_op_bitwidth',
    'max_loop_depth', 'max_loop_trip_count',
    'max_loop_il', 'avg_loop_depth', 'avg_loop_trip_count',
    'avg_loop_il', 'max_pipelined_loop_il',
    'max_unrolled_loop_il', 'max_unroll_factor',
    'max_flattened_loop_depth', 'avg_pipelined_loop_il',
    'avg_unrolled_loop_il', 'avg_unroll_factor',
    'avg_flattened_loop_depth', 'ratio_pipelined_loops',
    'ratio_unrolled_loops', 'ratio_partitioned_arrays',
    'max_array_size', 'max_partitioned_array_size',
    'max_partition_factor', 'avg_array_size',
    'avg_partitioned_array_size', 'avg_partition_factor',
    'num_unrolled_loops', 'num_pipelined_loops',
    'num_flattened_loops', 'num_partitioned_arrays',
    'num_loop_merges', 'num_inlines', 'num_dataflows'
] + AREA_METRICS

NO_LOG_SCALING_GRAPH_KEYS = [
    'ratio_pipelined_loops', 'ratio_unrolled_loops',
    'ratio_partitioned_arrays', 'avg_op_bitwidth',
    'avg_flattened_loop_depth', 'max_flattened_loop_depth',
    'max_loop_depth', 'avg_loop_depth', 'mem_intensity'
]

NODE_DIM_DICT = {
    ntype: sum(len(v) if isinstance(v, list) else 1 for v in DEFAULT_NODE_FEATURES_DICT[ntype].values())
    for ntype in NODE_TYPES
}
GRAPH_ATTR_DIM = len(GRAPH_ATTRS)


def get_default_feature_value(ntype, key):
    if key not in DEFAULT_NODE_FEATURES_DICT[ntype]:
        raise ValueError(f"Invalid feature key for {ntype} node: {key}")
    
    value = DEFAULT_NODE_FEATURES_DICT[ntype][key]
    if isinstance(value, list):
        return value.copy()
    return value


class Node:
    def __init__(
        self, 
        node_type: str, 
        element: Optional[ET.Element] = None,
        node_id: Optional[int] = None,
        node_name: Optional[str] = None,
        rtl_name: Optional[str] = None,
        function_name: str = ''
    ):
        if element is not None:
            if node_type in ['region', 'function']:
                if node_id is None:
                    node_id = findint(element, 'mId')
                    if node_id is None:
                        raise ValueError("Element does not contain 'mId' tag")
                
                if node_name is None:
                    node_name = element.findtext('mNormTag', '')
                    if not node_name:
                        node_name = element.findtext('mTag', '')
                    chars_to_replace = ['.', '-', ' ', '(', ')', '[', ']', '<', '>', ':']
                    for char in chars_to_replace:
                        node_name = node_name.replace(char, '_')
            else:
                value = element.find('Value')
                obj = element.find('Obj') if value is None else value.find('Obj')
                if obj is None:
                    raise ValueError("Element does not contain 'Obj' or 'Value/Obj' tag")
                
                if node_id is None:
                    node_id = findint(obj, 'id')
                    if node_id is None:
                        raise ValueError("Element does not contain 'id' tag")
            
                if node_name is None:
                    node_name = obj.findtext('name', '')

                rtl_name = obj.findtext('rtlName', '')

        self.node_type = node_type
        self.id = node_id if node_id is not None else 0
        self.name = node_name if node_name is not None else ''
        self.rtl_name = rtl_name if rtl_name is not None else ''
        self.function_name = function_name if node_type != 'function' else self.name
        self.label = f'{self.function_name}/{self.name}' if node_type != 'function' else self.name
        
        self.feature_dict = copy.deepcopy(DEFAULT_NODE_FEATURES_DICT[node_type])

    def get_feature_tensor(self) -> torch.Tensor:
        feature_vector = []
        for key in NODE_FEATURES_DICT[self.node_type]:
            if key not in self.feature_dict:
                value = get_default_feature_value(self.node_type, key)
            else:
                value = self.feature_dict[key]
            if isinstance(value, (list, tuple, np.ndarray)):
                feature_vector.extend([float(v) for v in value])
            else:
                feature_vector.append(float(value))

        return torch.tensor(feature_vector, dtype=torch.float32)

    def as_dict(self):
        node_as_dict = {
            'node_type': self.node_type,
            'label': self.label,
            'feature_dict': self.feature_dict
        }
        if self.rtl_name:
            node_as_dict['rtl_name'] = self.rtl_name
        return node_as_dict

    def __str__(self):
        return json.dumps(self.as_dict(), indent=2)
    
    def __repr__(self):
        return self.__str__()
    

class PortNode(Node):
    def __init__(
        self,
        element: ET.Element,
        function_name: str,
        is_top_level: bool = False,
        array_md: Optional[Dict[str, Any]] = None
    ):
        super().__init__('port', element=element, function_name=function_name)

        if array_md is not None and 'OriginalDimensions' in array_md:
            self.is_array = True
            self.array_size = array_md['TotalSize']
            self.num_dims = array_md['OriginalNumDimensions']

            base_type = str(array_md['BaseType'])
            array_dims = array_md['OriginalDimensions']

            if self.num_dims > MAX_ARRAY_DIM:
                # Truncate to MAX_ARRAY_DIM
                for i in range(self.num_dims - 1, MAX_ARRAY_DIM - 1, -1):
                    array_dims[i - 1] *= array_dims[i]
                    array_dims.pop()
            elif self.num_dims < MAX_ARRAY_DIM:
                # Pad with 1s
                array_dims.extend([1] * (MAX_ARRAY_DIM - self.num_dims))
        else:
            self.array_size = findint(element, 'array_size', 0)
            self.is_array = self.array_size > 0

            if self.is_array:
                self.num_dims = 1
                base_type = 'unknown'
                array_dims = [self.array_size] + [1] * (MAX_ARRAY_DIM - 1)
            else:
                self.num_dims = 0
                base_type = 'none'
                array_dims = [0] * MAX_ARRAY_DIM
        
        self.is_top_level_port = is_top_level
        self.base_type = base_type
        
        base_type_index = BASE_TYPE_MAP.get(base_type, -1)
        if base_type_index >= 0:
            self.feature_dict['base_type'][base_type_index] = 1

        direction_index = findint(element, 'direction', 2)
        if direction_index not in [0, 1, 2]:
            direction_index = 2  # Default to 'BI'
        self.feature_dict['direction'][direction_index] = 1

        self.feature_dict.update({
            'bitwidth': max(0, findint(element, 'Value/bitwidth', 0)),
            'is_top_level_port': int(is_top_level),
            'is_array': int(self.is_array),
            'array_size': self.array_size,
            'is_large_array': int(self.array_size >= 1024),
            'original_array_dims': array_dims
        })
        self.matching_ports = []
    
    def as_dict(self):
        feat_dict = copy.deepcopy(self.feature_dict)
        ap_type = feat_dict['partition_type']
        ap_dim = feat_dict['partition_dim']
        feat_dict['partition_type'] = ap_type.index(1) if 1 in ap_type else -1
        feat_dict['partition_dim'] = ap_dim.index(1) if 1 in ap_dim else -1
        node_as_dict = {
            'node_type': self.node_type,
            'label': self.label,
            'feature_dict': feat_dict,
            'matching_ports': self.matching_ports
        }
        return node_as_dict


class InternalMemNode(Node):
    def __init__(
        self,
        element: Optional[ET.Element] = None,
        node_id: Optional[int] = None,
        node_name: str = '',
        rtl_name: str = '',
        function_name: str = '',
        is_global_mem: bool = False,
        array_md: Optional[Dict[str, Any]] = None,
        utilization: Optional[Dict[str, int]] = None
    ):
        super().__init__(
            'internal_mem', 
            element=element,
            node_id=node_id,
            node_name=node_name,
            rtl_name=rtl_name,
            function_name=function_name
        )

        if array_md is not None:
            self.is_array = True
            self.array_size = array_md['TotalSize']
            self.num_dims = array_md['OriginalNumDimensions']

            bitwidth = array_md['BaseBitwidth']
            base_type = str(array_md['BaseType'])
            array_dims = array_md['OriginalDimensions']

            if self.num_dims > MAX_ARRAY_DIM:
                # Truncate to MAX_ARRAY_DIM
                for i in range(self.num_dims - 1, MAX_ARRAY_DIM - 1, -1):
                    array_dims[i - 1] *= array_dims[i]
                    array_dims.pop()
            elif self.num_dims < MAX_ARRAY_DIM:
                # Pad with 1s
                array_dims.extend([1] * (MAX_ARRAY_DIM - self.num_dims))
        else:
            if element is not None:
                bitwidth = max(0, findint(element, 'Value/bitwidth', 0))
                self.array_size = max(0, findint(element, 'Value/Obj/storageDepth', 0))
            else:
                bitwidth = 0
                self.array_size = 0

            self.is_array = self.array_size > 0

            if self.is_array:
                self.num_dims = 1
                array_dims = [self.array_size] + [1] * (MAX_ARRAY_DIM - 1)
                base_type = 'unknown'
            else:
                self.num_dims = 0
                array_dims = [0] * MAX_ARRAY_DIM
                base_type = 'none'

        self.is_global_mem = is_global_mem
        self.base_type = base_type

        base_type_index = BASE_TYPE_MAP.get(base_type, -1)
        if base_type_index >= 0:
            self.feature_dict['base_type'][base_type_index] = 1

        self.feature_dict.update({
            'bitwidth': bitwidth,
            'is_global_mem': int(is_global_mem),
            'is_array': int(self.is_array),
            'is_large_array': int(self.array_size >= 1024),
            'array_size': self.array_size,
            'original_array_dims': array_dims
        })
        if utilization is not None:
            for res in AREA_METRICS:
                self.feature_dict[res] = utilization.get(res, 0)

        self.matching_ports = []

    def as_dict(self):
        feat_dict = copy.deepcopy(self.feature_dict)
        ap_type = feat_dict['partition_type']
        ap_dim = feat_dict['partition_dim']
        feat_dict['partition_type'] = ap_type.index(1) if 1 in ap_type else -1
        feat_dict['partition_dim'] = ap_dim.index(1) if 1 in ap_dim else -1
        node_as_dict = {
            'node_type': self.node_type,
            'label': self.label,
            'rtl_name': self.rtl_name,
            'feature_dict': feat_dict,
            'matching_ports': self.matching_ports
        }
        return node_as_dict
    

class OperationNode(Node):
    def __init__(
        self, 
        element: ET.Element, 
        function_name: str,
        utilization: Optional[Dict[str, int]] = None
    ):
        super().__init__('op', element=element, function_name=function_name)

        self.opcode = element.findtext('opcode', 'unknown')
        self.op_category = OP_CATEG_MAP.get(self.opcode, 'unknown')

        self.core_type = element.findtext('Value/Obj/coreName', 'none')
        if not self.core_type:
            self.core_type = 'none'

        self.feature_dict['core_type']

        core_type_index = CORE_TYPE_MAP.get(self.core_type, -1)
        if core_type_index >= 0:
            self.feature_dict['core_type'][core_type_index] = 1

        opcode_index = OPCODE_MAP.get(self.opcode, -1)
        if opcode_index >= 0:
            self.feature_dict['opcode'][opcode_index] = 1

        self.feature_dict.update({
            'bitwidth': max(0, findint(element, 'Value/bitwidth', 0)),
            'delay': findfloat(element, 'm_delay', 0.0),
            'is_on_critical_path': findint(element, 'm_isOnCriticalPath', 0)
        })
        if utilization is not None:
            for res in AREA_METRICS:
                self.feature_dict[res] = utilization.get(res, 0)

        op_edges = element.find('oprand_edges') # ** This is not a typo **
        if op_edges is None:
            self.operand_edges = []
        else:
            self.operand_edges = [int(edge.text) for edge in op_edges.findall('item')]
    
    def as_dict(self):
        node_as_dict = {
            'node_type': self.node_type,
            'label': self.label,
            'rtl_name': self.rtl_name,
            'core_type': self.core_type,
            'opcode': self.opcode,
            'feature_dict': {
                key: value for key, value in self.feature_dict.items() 
                if key not in ['opcode', 'core_type']
            },
            'operand_edges': self.operand_edges
        }
        return node_as_dict


class ConstantNode(Node):
    def __init__(self, element: ET.Element, function_name: str):
        super().__init__('const', element=element, function_name=function_name)

        self.content = element.findtext('content', '')
        self.label += f" ({self.content})"

        self.const_type = str(element.findtext('const_type', 'unknown'))
        if not self.const_type:
            self.const_type = 'unknown'

        const_type_index = CONST_TYPE_MAP.get(self.const_type, -1)
        if const_type_index >= 0:
            self.feature_dict['const_type'][const_type_index] = 1

        self.feature_dict.update({
            'bitwidth': max(0, findint(element, 'Value/bitwidth', 0))
        })

    def as_dict(self):
        node_as_dict = {
            'node_type': self.node_type,
            'label': self.label,
            'const_type': self.const_type,
            'feature_dict': {
                key: value for key, value in self.feature_dict.items()
                if key != 'const_type'
            }
        }
        return node_as_dict


class BlockNode(Node):
    def __init__(self, element: ET.Element, function_name: str):
        super().__init__('block', element=element, function_name=function_name)

        self.ops = self._extract_items(element, 'node_objs')

    def _extract_items(self, element, tag):
        parent_tag = element.find(tag)
        if parent_tag is None:
            return []
        return [int(item.text) for item in parent_tag.findall('item')]
    
    def as_dict(self):
        node_as_dict = {
            'node_type': self.node_type,
            'label': self.label,
            'feature_dict': self.feature_dict,
            'ops': self.ops,
        }
        return node_as_dict


class RegionNode(Node):
    def __init__(
        self, 
        element: ET.Element, 
        function_name: str,
        loop_md: Optional[Dict[str, Any]] = None
    ):
        super().__init__('region', element=element, function_name=function_name)

        latency = max(0, findint(element, 'mMaxLatency', 0))
        trip_count = max(0, findint(element, 'mMaxTripCount', 0))
        ii = max(0, findint(element, 'mII', 0))
        il = latency // trip_count if trip_count > 0 else 0

        if loop_md is not None:
            self.is_loop = True
            has_perfectly_nested_child = loop_md.get('HasPerfectlyNestedChild', 0)
            is_part_of_perfect_nest = loop_md.get('IsPartOfPerfectNest', 0)
            loop_depth = max(1, loop_md.get('Depth', 0))
            if loop_depth > MAX_LOOP_DEPTH:
                loop_depth = MAX_LOOP_DEPTH
        else:
            self.is_loop = findint(element, 'mType', 0) == 1
            has_perfectly_nested_child = 0
            is_part_of_perfect_nest = 0
            loop_depth = 1 if self.is_loop else 0

        self.loop_depth = loop_depth
        self.feature_dict['loop_depth'][loop_depth] = 1

        self.feature_dict.update({
            'is_loop': int(self.is_loop),
            'latency': latency, 'trip_count': trip_count,
            'ii': ii, 'il': il,
            'has_perfectly_nested_child': has_perfectly_nested_child,
            'is_part_of_perfect_nest': is_part_of_perfect_nest,
        })
        self.sub_regions = self._extract_items(element, 'sub_regions')
        self.blocks = self._extract_items(element, 'basic_blocks')
    
    def _extract_items(self, element, tag):
        parent_tag = element.find(tag)
        if parent_tag is None:
            return []
        return [int(item.text) for item in parent_tag.findall('item')]

    def as_dict(self):
        feat_dict = copy.deepcopy(self.feature_dict)
        feat_dict['loop_depth'] = self.loop_depth
        node_as_dict = {
            'node_type': self.node_type,
            'label': self.label,
            'feature_dict': {
                key: value if key != 'loop_depth' else self.loop_depth 
                for key, value in self.feature_dict.items()
            },
            'sub_regions': self.sub_regions,
            'blocks': self.blocks
        }
        return node_as_dict


class FunctionNode(Node):
    def __init__(
        self, 
        element: ET.Element, 
        node_name: str,
        is_top_level: str,
        ret_bitwidth: int,
        num_array_ports: int,
        num_internal_arrays: int,
        sub_regions: List[str],
        blocks: List[str],
        op_nodes: List[OperationNode],
        original_name: Optional[str] = None,
        utilization: Optional[Dict[str, int]] = None,
    ):
        super().__init__(
            'function', 
            node_id=0,
            element=element, 
            node_name=node_name,
            function_name=node_name
        )
        self.norm_id = f'{node_name}.region.0'
        self.original_name = original_name if original_name is not None else node_name

        self.is_top_level_function = is_top_level
        self.bitwidth = ret_bitwidth
        self.latency = max(0, findint(element, 'mMaxLatency', 0))
        self.num_sub_regions = len(sub_regions)
        self.num_blocks = len(blocks)
        self.num_ops = len(op_nodes)

        self.feature_dict.update({
            'is_top_level_function': is_top_level,
            'bitwidth': ret_bitwidth,
            'latency': self.latency,
            'function_num_sub_regions': self.num_sub_regions,
            'function_num_blocks': self.num_blocks,
            'function_num_ops': self.num_ops,
            'num_array_ports': num_array_ports,
            'num_internal_arrays': num_internal_arrays
        })
        if utilization is not None:
            for res in AREA_METRICS:
                self.feature_dict[f'module_{res}'] = utilization.get(res, 0)

        for op in op_nodes:
            if op.opcode in OP_CATEG_MAP:
                self.feature_dict[f'function_num_{OP_CATEG_MAP[op.opcode]}_ops'] += 1

        self.sub_regions = sub_regions

        block_set = set(blocks)
        self.blocks = [
            f'{self.name}.{i}' 
            for i in self._extract_items(element, 'basic_blocks')
            if f'{self.name}.{i}' in block_set
        ]

    def _extract_items(self, element, tag):
        parent_tag = element.find(tag)
        if parent_tag is None:
            return []
        return [int(item.text) for item in parent_tag.findall('item')]
    
    def as_dict(self):
        node_as_dict = {
            'node_type': self.node_type,
            'label': self.label,
            'original_name': self.original_name,
            'feature_dict': self.feature_dict,
            'sub_regions': self.sub_regions,
            'blocks': self.blocks
        }
        return node_as_dict
    

class Edge:
    def __init__(
        self, src: str, dst: str, etype: str, 
        src_type: str = '', dst_type: str = '',
        is_back_edge: bool = False
    ):
        self.src = src
        self.dst = dst
        self.etype = etype
        self.src_type = src_type
        self.dst_type = dst_type

        self.is_back_edge = is_back_edge
        self.label = f"{src} -> {dst} ({etype})"

        self.one_hot_etype = [0] * NUM_RELATION_TYPES
        etype_index = RELATION_TYPE_MAP.get(etype, -1)
        if etype_index >= 0:
            self.one_hot_etype[etype_index] = 1

    def as_dict(self):
        edge_as_dict = {
            'label': self.label,
            'is_back_edge': self.is_back_edge
        }
        return edge_as_dict
    
    def __str__(self):
        return json.dumps(self.as_dict(), indent=2)
    
    def __repr__(self):
        return self.__str__()
    

class CDFG:
    def __init__(
        self,
        root: ET.Element,
        top_level_name: str,
        global_names: List[str],
        array_md_dict: Dict[str, Dict[str, Any]],
        loop_md_dict: Dict[str, Dict[str, Any]],
        utilization_dict: Dict[str, Dict[str, int]]
    ):
        cdfg = root.find('syndb/cdfg')
        if cdfg is None:
            raise ValueError("CDFG not found in the XML file")
        
        cdfg_regions = root.find('syndb/cdfg_regions')
        if cdfg_regions is None:
            raise ValueError("CDFG regions not found in the XML file")
        
        self.name = cdfg.findtext('name')
        
        if re.search(r"_[1-9]\d*$", self.name) and 'Pipeline' not in self.name:
            self.original_name = self.name[:self.name.rfind('_')]
            self.unnormalized_name = self.original_name + f'.{self.name[self.name.rfind("_") + 1:]}'
        else:
            self.original_name = self.name
            self.unnormalized_name = self.name

        self.ret_bitwidth = findint(cdfg, 'ret_bitwidth', 0)
        self.is_top_level = self.original_name == top_level_name
        
        self.nodes = {}
        self.edges = {}
        self.function_calls = []
        self.global_rtl_name_dict = {}

        self._parse_nodes(
            cdfg, cdfg_regions, global_names, 
            array_md_dict, loop_md_dict, utilization_dict
        )
        self._parse_edges(cdfg)
        self._build_hierarchy_edges()

    def _parse_nodes(
        self, cdfg, cdfg_regions, global_names, 
        array_md_dict, loop_md_dict, utilization_dict
    ):
        if (consts := cdfg.find('consts')) is None:
            raise ValueError("CDFG does not contain 'consts' section")
        if (ops_and_mem := cdfg.find('nodes')) is None:
            raise ValueError("CDFG does not contain 'nodes' section")
        if (ports := cdfg.find('ports')) is None:
            raise ValueError("CDFG does not contain 'ports' section")
        if (blocks := cdfg.find('blocks')) is None:
            raise ValueError("CDFG does not contain 'blocks' section")
        
        self._process_ops_and_internal_mem(ops_and_mem, array_md_dict, utilization_dict)
        self._process_ports(ports, global_names, array_md_dict)
        self._process_consts(consts)
        self._process_blocks(blocks)
        self._process_regions(cdfg_regions, loop_md_dict, utilization_dict)

    def _process_ops_and_internal_mem(self, ops_and_mem, array_md_dict, utilization_dict):
        self._allocas = []

        for elem in ops_and_mem.findall('item'):
            value = elem.find('Value')
            obj = elem.find('Obj') if value is None else value.find('Obj')
            if obj is None:
                raise ValueError("Element does not contain 'Obj' or 'Value/Obj' tag")
            
            name = obj.findtext('name', '')
            rtl_name = obj.findtext('rtlName', '')
            
            opcode = elem.findtext('opcode', '')
            if opcode == 'GlobalMem':
                if name and rtl_name and name not in self.global_rtl_name_dict:
                    self.global_rtl_name_dict[name] = rtl_name
                continue # Skip globals for now

            utilization = utilization_dict.get(rtl_name) if rtl_name else None

            op_node = OperationNode(elem, self.original_name, utilization=utilization)
            op_id = f'{self.name}.{op_node.id}'
            self.nodes[op_id] = op_node

            if opcode == 'alloca':
                self._allocas.append(op_id)

                array_md = None
                if f'{self.unnormalized_name}/{name}' in array_md_dict:
                    array_md = array_md_dict[f'{self.unnormalized_name}/{name}']
                elif f'{self.name}/{name}' in array_md_dict:
                    array_md = array_md_dict[f'{self.name}/{name}']
                elif f'{self.original_name}/{name}' in array_md_dict:
                    array_md = array_md_dict[f'{self.original_name}/{name}']

                internal_mem_node = InternalMemNode(
                    element=elem, node_id=op_node.id, function_name=self.original_name, 
                    node_name=name, rtl_name=rtl_name, is_global_mem=False,
                    array_md=array_md, utilization=utilization
                )
                self.nodes[f'{op_id}.internal_mem'] = internal_mem_node

    def _process_ports(self, ports, global_names, array_md_dict):
        for elem in ports.findall('item'):
            value = elem.find('Value')
            obj = elem.find('Obj') if value is None else value.find('Obj')
            if obj is None:
                raise ValueError("Element does not contain 'Obj' or 'Value/Obj' tag")
            
            name = obj.findtext('name', '')
            if name in global_names:
                continue # Skip globals for now

            array_md = None
            if f'{self.unnormalized_name}/{name}' in array_md_dict:
                array_md = array_md_dict[f'{self.unnormalized_name}/{name}']
            elif f'{self.name}/{name}' in array_md_dict:
                array_md = array_md_dict[f'{self.name}/{name}']
            elif f'{self.original_name}/{name}' in array_md_dict:
                array_md = array_md_dict[f'{self.original_name}/{name}']

            node = PortNode(
                elem, self.original_name, 
                is_top_level=self.is_top_level, array_md=array_md 
            )
            port_id = f'{self.name}.{node.id}'
            self.nodes[port_id] = node

    def _process_consts(self, consts):
        # Note: Constant nodes with type '4' and '6' are used to represent 
        # indices for getelementptr operations and call edges, respectivelly. 
        # Those will be removed later.
        self._gep_index_consts = []
        self._const_callee_name_map = {}

        for elem in consts.findall('item'):
            node = ConstantNode(elem, self.original_name)
            const_id = f'{self.name}.{node.id}'

            if node.const_type == '4':
                self._gep_index_consts.append(const_id)
            elif node.const_type == '6':
                self._const_callee_name_map[const_id] = node.name
            else:
                self.nodes[const_id] = node

    def _process_blocks(self, blocks):
        for elem in blocks.findall('item'):
            node = BlockNode(elem, self.original_name)
            block_id = f'{self.name}.{node.id}'

            node.ops = [
                f'{self.name}.{op_id}' for op_id in node.ops 
                if f'{self.name}.{op_id}' in self.nodes
            ]
            node.feature_dict['block_num_ops'] = len(node.ops)

            for op_id in node.ops:
                op_node = self.nodes[op_id]
                op_categ = op_node.op_category
                if op_categ != 'unknown':
                    node.feature_dict[f'block_num_{op_categ}_ops'] += 1
                for metric in AREA_METRICS:
                    node.feature_dict[f'block_{metric}_sum'] += op_node.feature_dict.get(metric, 0)

            self.nodes[block_id] = node

    def _process_regions(self, regions, loop_md_dict, utilization_dict):
        elems = regions.findall('item')

        function_node = None
        if elems:
            first_elem = elems[0]
            if findint(first_elem, 'mType', 0) != 1: # Not a loop
                sub_regions = []
                for elem in elems[1:]:
                    region_id = findint(elem, 'mId')
                    if region_id is not None:
                        sub_regions.append(f'{self.name}.region.{region_id - 1}')

                blocks = [node_id for node_id, node in self.nodes.items() if node.node_type == 'block']
                op_nodes = [node for node in self.nodes.values() if node.node_type == 'op']

                num_array_ports = sum(
                    1 for node in self.nodes.values() if node.node_type == 'port' and node.is_array
                )
                num_internal_arrays = sum(
                    1 for node in self.nodes.values() if node.node_type == 'internal_mem' and node.is_array
                )
                utilization = None
                if self.name in utilization_dict:
                    utilization = utilization_dict[self.name]
                elif self.original_name in utilization_dict:
                    utilization = utilization_dict[self.original_name]
                elif self.unnormalized_name in utilization_dict:
                    utilization = utilization_dict[self.unnormalized_name]

                function_node = FunctionNode(
                    first_elem, self.name, 
                    self.is_top_level, self.ret_bitwidth,
                    num_array_ports, num_internal_arrays,
                    sub_regions, blocks, op_nodes,
                    original_name=self.original_name,
                    utilization=utilization
                )

        if function_node is None:
            raise ValueError("CDFG does not contain a function region")

        self.nodes[function_node.norm_id] = function_node

        region_nodes = {}
        for elem in elems[1:]:
            name = elem.findtext('mTag', '')
            loop_md = None
            if f'{self.unnormalized_name}/{name}' in loop_md_dict:
                loop_md = loop_md_dict[f'{self.unnormalized_name}/{name}']
            elif f'{self.name}/{name}' in loop_md_dict:
                loop_md = loop_md_dict[f'{self.name}/{name}']
            elif f'{self.original_name}/{name}' in loop_md_dict:
                loop_md = loop_md_dict[f'{self.original_name}/{name}']

            node = RegionNode(elem, self.original_name, loop_md=loop_md) 
            region_id = f'{self.name}.region.{node.id - 1}'

            node.sub_regions = [
                f'{self.name}.region.{int(sub_region) - 1}'
                for sub_region in node.sub_regions
            ]
            node.blocks = [
                f'{self.name}.{int(block)}' for block in node.blocks
                if f'{self.name}.{int(block)}' in self.nodes
            ]
            region_nodes[region_id] = node

        for region_id in region_nodes:
            region_nodes[region_id].sub_regions = [
                sub_region for sub_region in region_nodes[region_id].sub_regions 
                if sub_region in region_nodes
            ]
            
        for region_id, node in region_nodes.items():
            all_sub_regions = self._get_all_sub_regions(region_nodes, node)
            all_blocks = set(node.blocks)
            for sub_region_id in all_sub_regions:
                all_blocks.update(region_nodes[sub_region_id].blocks)

            node.feature_dict.update({
                'region_num_sub_regions': len(all_sub_regions),
                'region_num_blocks': len(all_blocks),
            })
            for block_id in all_blocks:
                block_node = self.nodes[block_id]
                for categ in OP_CATEGS:
                    num_ops = block_node.feature_dict.get(f'block_num_{categ}_ops', 0)
                    node.feature_dict[f'region_num_{categ}_ops'] += num_ops

                for metric in AREA_METRICS:
                    metric_sum = block_node.feature_dict.get(f'block_{metric}_sum', 0)
                    node.feature_dict[f'region_{metric}_sum'] += metric_sum
                
                node.feature_dict['region_num_ops'] += block_node.feature_dict.get('block_num_ops', 0)

            self.nodes[region_id] = node

    def _get_all_sub_regions(self, region_nodes, region_node):
        all_sub_regions = set(region_node.sub_regions)
        for region_id in region_node.sub_regions:
            all_sub_regions.update(
                self._get_all_sub_regions(region_nodes, region_nodes[region_id])
            )
        return all_sub_regions

    def _parse_edges(self, cdfg):
        src_gep_index_consts = []
        dst_get_index_consts = []

        for elem in cdfg.find('edges').findall('item'):
            etype = elem.findtext('edge_type', '')
            edge_id = elem.findtext('id', '')
            if not etype or not edge_id:
                continue

            is_back_edge = findint(elem, 'is_back_edge', 0) == 1
            src = findint(elem, 'source_obj')
            dst = findint(elem, 'sink_obj')
            if src is None or dst is None:
                continue

            src_id = f'{self.name}.{src}'
            dst_id = f'{self.name}.{dst}'

            if src_id in self._const_callee_name_map:
                if dst_id in self.nodes:
                    callee_name = self._const_callee_name_map[src_id]
                    self.function_calls.append((dst_id, callee_name))
                continue

            if src_id in self._gep_index_consts:
                if dst_id in self.nodes:
                    src_gep_index_consts.append((src_id, dst_id))
                continue

            if dst_id in self._gep_index_consts:
                if src_id in self.nodes:
                    if src_id in self._allocas:
                        internal_mem_id = src_id + '.internal_mem'
                        dst_get_index_consts.append((internal_mem_id, dst_id))
                    dst_get_index_consts.append((src_id, dst_id))
                continue

            if src_id not in self.nodes or dst_id not in self.nodes:
                continue

            src_type = self.nodes[src_id].node_type
            dst_type = self.nodes[dst_id].node_type

            if etype == '2':
                etype = 'control'
            elif etype in ['1', '3']:
                etype = 'data'
            elif etype == '4':
                etype = 'memory'
            else:
                print(f"Skipping edge with unknown type '{etype}': {edge_id}")
                continue
            
            edge_id = f'{self.name}.{edge_id}'
            if src_id in self._allocas and etype in ['data', 'memory']:
                internal_mem_id = src_id + '.internal_mem'
                if internal_mem_id in self.nodes:
                    internal_mem_edge_id = edge_id + '.internal_mem'
                    internal_mem_edge = Edge(
                        src_id, internal_mem_id, etype, src_type='op', dst_type='internal_mem',
                        is_back_edge=is_back_edge
                    )
                    self.edges[internal_mem_edge_id] = internal_mem_edge

            edge = Edge(
                src_id, dst_id, etype, src_type=src_type, dst_type=dst_type,
                is_back_edge=is_back_edge
            )
            self.edges[edge_id] = edge

        num_edges = len(self.edges) + 1

        for src, dst_const in dst_get_index_consts:
            if src not in self.nodes:
                continue
            src_type = self.nodes[src].node_type 
            for src_const, op in src_gep_index_consts:
                if src_const == dst_const:
                    self.edges[f'{self.name}.gep.{num_edges}'] = Edge(
                        src, op, 'data', src_type=src_type, dst_type='op'
                    )
                    num_edges += 1

        for alloca_id in self._allocas:
            self.edges[f'{self.name}.alloca.{num_edges}'] = Edge(
                alloca_id, f'{alloca_id}.internal_mem', 'alloca', 
                src_type= 'op', dst_type='internal_mem'
            )
            num_edges += 1

        for block_node in self.nodes.values():
            if block_node.node_type == 'block' and block_node.ops:
                block_ops = block_node.ops.copy()
                sorted_ops = sorted(block_ops, key=lambda op: self.nodes[op].id)
                control_edges = [
                    Edge(sorted_ops[i], sorted_ops[i + 1], 'control', src_type='op', dst_type='op')
                    for i in range(len(sorted_ops) - 1)
                ]
                for edge in control_edges:
                    edge_id = f'{self.name}.control.{num_edges}'
                    self.edges[edge_id] = edge
                    num_edges += 1

                first_op = sorted_ops[0]
                last_op = sorted_ops[-1]

                # Find the next block in the control flow
                block_id = f'{self.name}.{block_node.id}'
                next_blocks = []
                for edge in self.edges.values():
                    if edge.src == block_id and edge.etype == 'control':
                        next_block_id = edge.dst
                        if next_block_id in self.nodes and self.nodes[next_block_id].node_type == 'block':
                            next_blocks.append(self.nodes[next_block_id])

                for next_block in next_blocks:
                    if not next_block.ops:
                        continue
                    sorted_next_ops = sorted(next_block.ops, key=lambda op: self.nodes[op].id)
                    next_op = sorted_next_ops[0]
                    if next_op in self.nodes:
                        self.edges[f'{self.name}.control.{num_edges}'] = Edge(
                            last_op, next_op, 'control', src_type='op', dst_type='op'
                        )
                        num_edges += 1
                    
                prev_blocks = []
                for edge in self.edges.values():
                    if edge.dst == block_id and edge.etype == 'control':
                        prev_block_id = edge.src
                        if prev_block_id in self.nodes and self.nodes[prev_block_id].node_type == 'block':
                            prev_blocks.append(self.nodes[prev_block_id])  

                for prev_block in prev_blocks:
                    if not prev_block.ops:
                        continue
                    sorted_prev_ops = sorted(prev_block.ops, key=lambda op: self.nodes[op].id)
                    prev_op = sorted_prev_ops[-1]
                    if prev_op in self.nodes:
                        self.edges[f'{self.name}.control.{num_edges}'] = Edge(
                            prev_op, first_op, 'control', src_type='op', dst_type='op'
                        )
                        num_edges += 1

                existing_control_edges = {(edge.src, edge.dst) for edge in self.edges.values() if edge.etype == 'control'}
                new_edges = {}
                for edge in self.edges.values():
                    if edge.dst not in self.nodes or edge.src not in self.nodes:
                        continue
                    dst_type = self.nodes[edge.dst].node_type
                    if edge.src == block_id and dst_type == 'op':
                        # Find block containing the operation
                        if not (edge.dst, block_id) in existing_control_edges:
                            new_edges[f'{self.name}.control.{num_edges}'] = Edge(
                                edge.dst, block_id, 'control', src_type=dst_type, dst_type='block'
                            )
                            num_edges += 1

                        for prev_block_id, prev_block_node in self.nodes.items():
                            if prev_block_node.node_type == 'block' and edge.dst in prev_block_node.ops:
                                if not (prev_block_id, block_id) in existing_control_edges:
                                    new_edges[f'{self.name}.control.{num_edges}'] = Edge(
                                        prev_block_id, block_id, 'control', src_type='block', dst_type='block'
                                    )
                                    num_edges += 1
                                break

                self.edges.update(new_edges)

        function_id = f'{self.name}.region.0'
        for node_id, node in self.nodes.items():
            if node.node_type in ['port', 'internal_mem']:
                self.edges[f'{self.name}.local.{num_edges}'] = Edge(
                    node_id, function_id, node.node_type, src_type=node.node_type, dst_type='function'
                )
                self.edges[f'{self.name}.local.{num_edges + 1}'] = Edge(
                    function_id, node_id, f'{node.node_type}_rev', src_type='function', dst_type=node.node_type
                )
                num_edges += 2

    def _build_hierarchy_edges(self):
        num_edges = len(self.edges) + 1

        for node_id, node in self.nodes.items():
            if node.node_type == 'block':  
                for op_id in node.ops:
                    self.edges[f'{self.name}.hier.{num_edges}'] = Edge(
                        node_id, op_id, 'hier', src_type='block', dst_type='op'
                    )
                    num_edges += 1

            elif node.node_type in ['region', 'function']:
                for sub_region_id in node.sub_regions:
                    self.edges[f'{self.name}.hier.{num_edges}'] = Edge(
                        node_id, sub_region_id, 'hier', src_type=node.node_type, dst_type='region'
                    )
                    num_edges += 1

                for block_id in node.blocks:
                    self.edges[f'{self.name}.hier.{num_edges}'] = Edge(
                        node_id, block_id, 'hier', src_type=node.node_type, dst_type='block'
                    )
                    num_edges += 1
                    for op_id in self.nodes[block_id].ops:
                        self.edges[f'{self.name}.hier.{num_edges}'] = Edge(
                            node_id, op_id, 'hier', src_type=node.node_type, dst_type='op'
                        )
                        num_edges += 1
        
        rev_hier_edges = {}
        for edge_id, edge in self.edges.items():
            if edge.etype == 'hier':
                rev_hier_edges[edge_id + '.rev'] = Edge(
                    edge.dst, edge.src, 'hier_rev', src_type=edge.dst_type, dst_type=edge.src_type,
                )
                
        self.edges.update(rev_hier_edges)
    
    def as_dict(self):
        return {
            'name': self.name,
            'ret_bitwidth': self.ret_bitwidth,
            'is_top_level': self.is_top_level,
            'function_calls': self.function_calls,
            'nodes': {
                node_id: node.as_dict()
                for node_id, node in self.nodes.items()
            },
            'edges': {
                edge_id: edge.as_dict()
                for edge_id, edge in self.edges.items()
            }
        }

    def __str__(self):
        return json.dumps(self.as_dict(), indent=2)

class KernelGraph:
    def __init__(
        self,
        solution_dir: str,
        top_level_name: str,
        array_md_dict: Dict[str, Dict[str, Any]],
        loop_md_dict: Dict[str, Dict[str, Any]],
        benchmark_name: Optional[str] = None
    ):
        self.top_level_name = top_level_name
        self.benchmark_name = benchmark_name or top_level_name

        if 'Global' not in array_md_dict or 'Local' not in array_md_dict:
            raise ValueError("Global and Local arrays must be present in the array metadata dictionary.")

        self._global_array_md_dict = array_md_dict['Global']
        self._local_array_md_dict = array_md_dict['Local']
        self._loop_md_dict = loop_md_dict
        self._global_array_names = list(self._global_array_md_dict.keys())

        self.base_ground_truth = extract_area_metrics(solution_dir)
        if any(self.base_ground_truth.get(res, 0) < 0 for res in AREA_METRICS):
            raise ValueError("Invalid area metrics found in the solution directory.")
        
        self.module_area_dict = extract_per_module_area(solution_dir)

        self.nodes = {}
        self.edges = {}
        self._cdfgs = {}

        self._process_adb_files(solution_dir)
        self._update_array_info()
        self._include_call_flow()
        self._update_edge_types()

        self.graph_attr = self.compute_graph_attrs()

    def compute_graph_attrs(self):
        num_nodes = len(self.nodes)
        num_edges = len(self.edges)

        num_ops = sum(1 for node in self.nodes.values() if node.node_type == 'op')
        num_blocks = sum(1 for node in self.nodes.values() if node.node_type == 'block')
        num_functions = sum(1 for node in self.nodes.values() if node.node_type == 'function')
        num_loops = sum(1 for node in self.nodes.values() if node.node_type == 'region' and node.is_loop)
        num_arrays = sum(1 for node in self.nodes.values() if node.node_type in ['internal_mem', 'port'] and node.is_array)

        num_mem_ops = sum(1 for node in self.nodes.values() if node.node_type == 'op' and node.opcode in ['load', 'store'])
        num_arith_ops = sum(1 for node in self.nodes.values() if node.node_type == 'op' and node.op_category in ['arith_int', 'arith_fp'])
        mem_intensity = num_mem_ops / (num_arith_ops + 1e-6)

        num_int_ops = sum(1 for node in self.nodes.values() if node.node_type == 'op' and node.op_category == 'arith_int')
        num_fp_ops = sum(1 for node in self.nodes.values() if node.node_type == 'op' and node.op_category == 'arith_fp')
        num_branch_ops = sum(1 for node in self.nodes.values() if node.node_type == 'op' and node.opcode in ['br', 'switch'])

        avg_op_bitwidth = sum(
            node.feature_dict.get('bitwidth', 0) 
            for node in self.nodes.values() if node.node_type == 'op'
        ) / num_ops if num_ops > 0 else 0

        loop_depths = []
        loop_trip_counts = []
        loop_ils = []
        pipelined_loop_ils = []
        unrolled_loop_ils = []
        unroll_factors = []
        flattened_loop_depths = []

        for node in self.nodes.values():
            if node.node_type == 'region' and node.is_loop:
                loop_depth = node.feature_dict.get('loop_depth', [0] * (MAX_LOOP_DEPTH + 1))
                loop_depth = loop_depth.index(1) if 1 in loop_depth else 0
                loop_il = node.feature_dict.get('il', 0)
                loop_trip_count = node.feature_dict.get('trip_count', 0)

                loop_depths.append(loop_depth)
                loop_trip_counts.append(loop_trip_count)
                loop_ils.append(loop_il)

                if node.feature_dict.get('pipeline', 0) == 1:
                    pipelined_loop_ils.append(loop_il)

                unroll_factor = node.feature_dict.get('unroll_factor', 0)
                if unroll_factor > 0:
                    unroll_factors.append(unroll_factor)
                    unrolled_loop_ils.append(loop_il)

                if node.feature_dict.get('loop_flatten', 0) == 1:
                    flattened_loop_depths.append(loop_depth)

        num_pipelined_loops = len(pipelined_loop_ils)
        num_unrolled_loops = len(unroll_factors)
        num_flattened_loops = len(flattened_loop_depths)

        max_loop_depth = max(loop_depths) if loop_depths else 0
        max_loop_trip_count = max(loop_trip_counts) if loop_trip_counts else 0
        max_loop_il = max(loop_ils) if loop_ils else 0

        avg_loop_trip_count = sum(loop_trip_counts) / len(loop_trip_counts) if loop_trip_counts else 0
        avg_loop_il = sum(loop_ils) / len(loop_ils) if loop_ils else 0
        avg_loop_depth = sum(loop_depths) / len(loop_depths) if loop_depths else 0

        max_pipelined_loop_il = max(pipelined_loop_ils) if pipelined_loop_ils else 0
        max_unrolled_loop_il = max(unrolled_loop_ils) if unrolled_loop_ils else 0
        max_flattened_loop_depth = max(flattened_loop_depths) if flattened_loop_depths else 0

        avg_pipelined_loop_il = sum(pipelined_loop_ils) / num_pipelined_loops if num_pipelined_loops > 0 else 0
        avg_unrolled_loop_il = sum(unrolled_loop_ils) / num_unrolled_loops if num_unrolled_loops > 0 else 0
        avg_flattened_loop_depth = sum(flattened_loop_depths) / num_flattened_loops if num_flattened_loops > 0 else 0

        avg_unroll_factor = sum(unroll_factors) / num_unrolled_loops if num_unrolled_loops > 0 else 0
        max_unroll_factor = max(unroll_factors) if unroll_factors else 0

        ratio_pipelined_loops = num_pipelined_loops / num_loops if num_loops > 0 else 0
        ratio_unrolled_loops = num_unrolled_loops / num_loops if num_loops > 0 else 0

        array_sizes = []
        partitioned_array_sizes = []
        partition_factors = []

        for node in self.nodes.values():
            if node.node_type in ['internal_mem', 'port'] and node.is_array:
                array_size = node.feature_dict.get('array_size', 0)
                array_sizes.append(array_size)
                partition_factor = node.feature_dict.get('partition_factor', 0)
                if partition_factor > 0:
                    partition_factors.append(partition_factor)
                    partitioned_array_sizes.append(array_size)

        num_arrays = len(array_sizes)
        num_partitioned_arrays = len(partitioned_array_sizes)

        max_array_size = max(array_sizes) if array_sizes else 0
        max_partitioned_array_size = max(partitioned_array_sizes) if partitioned_array_sizes else 0
        max_partition_factor = max(partition_factors) if partition_factors else 0

        avg_array_size = sum(array_sizes) / num_arrays if num_arrays > 0 else 0
        avg_partitioned_array_size = sum(partitioned_array_sizes) / num_partitioned_arrays if num_partitioned_arrays > 0 else 0
        avg_partition_factor = sum(partition_factors) / len(partition_factors) if partition_factors else 0

        ratio_partitioned_arrays = num_partitioned_arrays / num_arrays if num_arrays > 0 else 0

        num_loop_merges = sum(
            1 for node in self.nodes.values() if node.node_type in ['region', 'function']
            and node.feature_dict.get('loop_merge', 0) == 1
        )
        num_inlines = sum(
            1 for node in self.nodes.values() if node.node_type == 'function'
            and node.feature_dict.get('inline', 0) == 1
        )
        num_dataflows = sum(
            1 for node in self.nodes.values() if node.node_type == 'function'
            and node.feature_dict.get('dataflow', 0) == 1
        )
        graph_attrs = {
            'num_nodes': num_nodes, 
            'num_edges': num_edges,
            'num_ops': num_ops, 
            'num_blocks': num_blocks, 
            'num_functions': num_functions, 
            'num_loops': num_loops, 
            'num_arrays': num_arrays,
            'num_mem_ops': num_mem_ops, 
            'num_arith_ops': num_arith_ops,
            'mem_intensity': mem_intensity, 
            'num_int_ops': num_int_ops,
            'num_fp_ops': num_fp_ops, 
            'num_branch_ops': num_branch_ops,
            'avg_op_bitwidth': avg_op_bitwidth,

            'max_loop_depth': max_loop_depth,
            'max_loop_trip_count': max_loop_trip_count,
            'max_loop_il': max_loop_il,
            'avg_loop_depth': avg_loop_depth,
            'avg_loop_trip_count': avg_loop_trip_count,
            'avg_loop_il': avg_loop_il,

            'max_pipelined_loop_il': max_pipelined_loop_il,
            'max_unrolled_loop_il': max_unrolled_loop_il,
            'max_unroll_factor': max_unroll_factor,
            'max_flattened_loop_depth': max_flattened_loop_depth,
            'avg_pipelined_loop_il': avg_pipelined_loop_il,
            'avg_unrolled_loop_il': avg_unrolled_loop_il,
            'avg_unroll_factor': avg_unroll_factor,
            'avg_flattened_loop_depth': avg_flattened_loop_depth,

            'ratio_pipelined_loops': ratio_pipelined_loops,
            'ratio_unrolled_loops': ratio_unrolled_loops,
            'ratio_partitioned_arrays': ratio_partitioned_arrays,

            'max_array_size': max_array_size,
            'max_partitioned_array_size': max_partitioned_array_size,
            'max_partition_factor': max_partition_factor,
            'avg_array_size': avg_array_size,
            'avg_partitioned_array_size': avg_partitioned_array_size,
            'avg_partition_factor': avg_partition_factor,

            'num_unrolled_loops': num_unrolled_loops,
            'num_pipelined_loops': num_pipelined_loops,
            'num_flattened_loops': num_flattened_loops,
            'num_partitioned_arrays': num_partitioned_arrays,
            'num_loop_merges': num_loop_merges,
            'num_inlines': num_inlines,
            'num_dataflows': num_dataflows
        }
        graph_attrs.update(copy.deepcopy(self.base_ground_truth))
        return graph_attrs

    def _process_adb_files(self, solution_dir):
        try:
            adb_file_list = collect_adb_files(solution_dir)
        except FileNotFoundError as e:
            print(e)
            raise

        if not adb_file_list:
            print(f"No ADB files found in {solution_dir}")
            raise FileNotFoundError("No ADB files found")
        
        self._global_rtl_name_dict = {}

        for path in adb_file_list:
            print(f"Processing file: {path}")
            tree = ET.parse(path)
            root = tree.getroot()
            cdfg = CDFG(
                root=root, 
                top_level_name=self.top_level_name, 
                global_names=self._global_array_names,
                array_md_dict=self._local_array_md_dict,
                loop_md_dict=self._loop_md_dict,
                utilization_dict=self.module_area_dict
            )
            self.nodes.update(cdfg.nodes)
            self.edges.update(cdfg.edges)
            self._global_rtl_name_dict.update(cdfg.global_rtl_name_dict)
            self._cdfgs[cdfg.name] = cdfg

    def _include_call_flow(self):
        # Collect array operands from function calls
        operand_dict = {}
        for edge in self.edges.values():
            src_node = self.nodes[edge.src]
            dst_node = self.nodes[edge.dst]
            if (dst_node.node_type == 'op' and dst_node.opcode == 'call' and 
                src_node.node_type in ['internal_mem', 'port'] and src_node.is_array):
                if edge.dst not in operand_dict:
                    operand_dict[edge.dst] = []
                operand_dict[edge.dst].append(edge.src)

        for cdfg in self._cdfgs.values():
            for (call_op_id, callee) in cdfg.function_calls:
                if callee not in self._cdfgs:
                    print(f"Warning: Callee {callee} not found in CDFGs, skipping call flow.")
                    continue
                num_edges = len(self.edges)
                callee_cdfg = self._cdfgs[callee]

                caller_id = f'{cdfg.name}.region.0'
                callee_id = f'{callee_cdfg.name}.region.0'

                for src_id in operand_dict.get(call_op_id, []):
                    src_node = self.nodes[src_id]

                    # Find matching port in callee CDFG
                    for callee_port_id, callee_port in callee_cdfg.nodes.items():
                        if callee_port.node_type == 'port' and callee_port.name == src_node.name:
                            self.nodes[src_id].matching_ports.append(callee_port_id)
                            self.edges[f'call_flow.{num_edges}'] = Edge(
                                src_id, callee_port_id, 'arg', src_type=src_node.node_type, dst_type='port'
                            )
                            num_edges += 1
                            break
                        
                callee_node = callee_cdfg.nodes[callee_id]
                self.nodes[call_op_id].feature_dict['callee_size'] = callee_node.num_ops
                self.edges[f'call_flow.{num_edges}'] = Edge(
                    call_op_id, callee_id, 'call', src_type='op', dst_type='function'
                )
                self.edges[f'call_flow.{num_edges + 1}'] = Edge(
                    callee_id, call_op_id, 'ret', src_type='function', dst_type='op'
                )
                self.edges[f'call_flow.{num_edges + 2}'] = Edge(
                    caller_id, callee_id, 'module_hier', src_type='function', dst_type='function'
                )
                self.edges[f'call_flow.{num_edges + 3}'] = Edge(
                    callee_id, caller_id, 'module_hier_rev', src_type='function', dst_type='function'
                )
                num_edges += 4

    def _update_array_info(self):
        num_nodes = len(self.nodes)
        num_edges = len(self.edges)
        
        for array_name, array_md in self._global_array_md_dict.items():
            rtl_name = ''
            utilization = None
            if array_name in self._global_rtl_name_dict:
                rtl_name = self._global_rtl_name_dict[array_name]
                if rtl_name in self.module_area_dict:
                    utilization = self.module_area_dict[rtl_name]

            array_node = InternalMemNode(
                node_id=num_nodes,
                function_name=self.top_level_name, # Use top-level name for global arrays
                node_name=array_name,
                rtl_name=rtl_name,
                is_global_mem=True,
                array_md=array_md,
                utilization=utilization
            )
            array_id = f'global.{array_node.id}'
            self.nodes[array_id] = array_node
            num_nodes += 1

            for store_info in array_md.get('Stores', []):
                function_name = store_info.get('FunctionName', '')
                idx = store_info.get('Index', -1)
                if not function_name or idx < 0 or function_name not in self._cdfgs:
                    print(f"Warning: Invalid store info for {array_name} in {function_name}, skipping.")
                    continue

                cdfg = self._cdfgs[function_name]
                count = 0
                for op_id, op_node in cdfg.nodes.items():
                    if op_node.node_type == 'op' and op_node.opcode == 'store':
                        if count == idx:
                            self.edges[f'global.{num_edges}'] = Edge(
                                array_id, op_id, 'data', src_type='internal_mem', dst_type='op'
                            )
                            num_edges += 1
                            break
                        count += 1

            for key in ['Loads', 'GEPs']:
                for op_info in array_md.get(key, []):
                    inst_name = op_info.get('Name', '')
                    function_name = op_info.get('FunctionName', '')
                    if not function_name or not inst_name or function_name not in self._cdfgs:
                        print(f"Warning: Invalid load info for {array_name} in {function_name}, skipping.")
                        continue

                    cdfg = self._cdfgs[function_name]
                    for op_id, op_node in cdfg.nodes.items():
                        if op_node.node_type == 'op' and op_node.name == inst_name:
                            self.edges[f'global.{num_edges}'] = Edge(
                                array_id, op_id, 'data', src_type='internal_mem', dst_type='op'
                            )
                            num_edges += 1
                            break

        existing_edges_set = set((e.src, e.dst, e.etype) for e in self.edges.values())

        for array_label, array_md in self._local_array_md_dict.items():
            function_name, array_name = array_label.split('/')
            if function_name not in self._cdfgs:
                print(f"Warning: Function {function_name} not found in CDFGs, skipping array {array_name}.")
                continue

            cdfg = self._cdfgs[function_name]
            array_id = None
            for port_id, port_node in cdfg.nodes.items():
                if port_node.node_type == 'port' and port_node.name == array_name:
                    array_id = port_id
                    break

            if array_id is None:
                continue

            for store_info in array_md.get('Stores', []):
                idx = store_info.get('Index', -1)
                if store_info.get('FunctionName', '') != function_name or idx < 0:
                    continue

                count = 0
                for op_id, op_node in cdfg.nodes.items():
                    if op_node.node_type == 'op' and op_node.opcode == 'store':
                        if count == idx:
                            if (array_id, op_id, 'data') not in existing_edges_set:
                                self.edges[f'global.{num_edges}'] = Edge(
                                    array_id, op_id, 'data', src_type='port', dst_type='op'
                                )
                                existing_edges_set.add((array_id, op_id, 'data'))
                                num_edges += 1
                            break
                        count += 1

            for key in ['Loads', 'GEPs']:
                for op_info in array_md.get(key, []):
                    inst_name = op_info.get('Name', '')
                    if not inst_name or op_info.get('FunctionName', '') != function_name:
                        continue

                    for op_id, op_node in cdfg.nodes.items():
                        if op_node.node_type == 'op' and op_node.name == inst_name:
                            if (array_id, op_id, 'data') not in existing_edges_set:
                                self.edges[f'global.{num_edges}'] = Edge(
                                    array_id, op_id, 'data', src_type='port', dst_type='op'
                                )
                                existing_edges_set.add((array_id, op_id, 'data'))
                                num_edges += 1
                            break
        
        new_edges = {}
        for edge in self.edges.values():
            if edge.etype != 'data':
                continue
            src_node = self.nodes[edge.src]
            dst_node = self.nodes[edge.dst]
            if src_node.node_type in ['internal_mem', 'port'] and dst_node.node_type == 'op':
                if dst_node.opcode == 'getelementptr':
                    # Add a (Node -> Op) edge for each (Node -> GEP -> Op) path
                    for next_edge in self.edges.values():
                        if next_edge.etype == 'data' and next_edge.src == edge.dst:
                            next_dst_node = self.nodes[next_edge.dst]
                            if next_dst_node.node_type == 'op':
                                if (edge.src, next_edge.dst, 'data') not in existing_edges_set:
                                    new_edges[f'additional.{num_edges}'] = Edge(
                                        edge.src, next_edge.dst, 'data', 
                                        src_type=src_node.node_type, dst_type='op'
                                    )
                                    num_edges += 1

        for edge in self.edges.values():
            if edge.etype != 'data':
                continue
            src_node = self.nodes[edge.src]
            dst_node = self.nodes[edge.dst]
            if src_node.node_type in ['internal_mem', 'port'] and dst_node.node_type == 'op':
                if dst_node.opcode == 'store':
                    # Add a (Store -> Array) edge for each (Array -> Store) edge
                    if (edge.dst, edge.src, 'store') not in existing_edges_set:
                        new_edges[f'additional.{num_edges}'] = Edge(
                            edge.dst, edge.src, 'store', src_type=src_node.node_type, dst_type='op'
                        )
                        num_edges += 1

        self.edges.update(new_edges)

    def _update_edge_types(self):
        for edge_id, edge in self.edges.items():
            src_type = self.nodes[edge.src].node_type
            dst_type = self.nodes[edge.dst].node_type
            self.edges[edge_id].src_type = src_type
            self.edges[edge_id].dst_type = dst_type

    def as_dict(self):
        node_dict = {
            node_id: node.as_dict() 
            for node_id, node in self.nodes.items()
        }
        edge_dict = {
            edge_id: edge.as_dict() 
            for edge_id, edge in self.edges.items()
        }
        return {
            'name': self.benchmark_name,
            'top_level': self.top_level_name,
            'graph_attr': self.graph_attr,
            'modules': [cdfg.name for cdfg in self._cdfgs.values()],
            'nodes': node_dict,
            'edges': edge_dict
        }

    def save_as_json(self, filepath):
        with open(filepath, 'w') as f:
            json.dump(self.as_dict(), f, indent=2)
    
    def __str__(self):
        return json.dumps(self.as_dict(), indent=2)
    
    def __repr__(self):
        return self.__str__()


def collect_adb_files(solution_dir):
    ir_dir = os.path.join(solution_dir, "IRs")
    if not os.path.exists(ir_dir):
        ir_dir = os.path.join(solution_dir, ".autopilot/db")
        if not os.path.exists(ir_dir):
            raise FileNotFoundError(f"IR directory not found in {solution_dir}")

    file_paths = []
    for file_name in os.listdir(ir_dir):
        if file_name.endswith(".adb"):
            if ".bind" in file_name or ".sched" in file_name:
                continue
            file_paths.append(os.path.join(ir_dir, file_name))

    return file_paths


def compute_scaling_stats(
    dataset_dir: str,
    benchmarks: Optional[Union[str, List[str]]] = None,
) -> Dict[str, Dict[str, float]]:
    numerical_feats = {feat: [] for feat in NUMERICAL_FEATURES}

    if benchmarks is None:
        benchmarks = sorted(os.listdir(dataset_dir))
    elif isinstance(benchmarks, str):
        benchmarks = [benchmarks]

    for bench in benchmarks:
        bench_dir = os.path.join(dataset_dir, bench)
        if not os.path.isdir(bench_dir):
            print(f"Skipping {bench} (directory not found)")
            continue

        for sol in os.listdir(bench_dir):
            sol_dir = os.path.join(bench_dir, sol)
            if not os.path.isdir(sol_dir) or not sol.startswith("solution"):
                continue

            graph_path = os.path.join(sol_dir, "graph.pkl")
            if not os.path.exists(graph_path):
                print(f"Skipping {sol} (kernel info file not found)")
                continue

            with open(graph_path, 'rb') as f:
                kernel_graph = pickle.load(f)

            for node in kernel_graph.nodes.values():
                for key, value in node.feature_dict.items():
                    if 'bitwidth' in key:
                        base_key = 'bitwidth'
                    else:
                        base_key = key
                    
                    if base_key in numerical_feats:
                        if 'dims' in base_key:
                            for dim in value:
                                if dim > 1:
                                    numerical_feats[base_key].append(float(dim))
                        elif value > 0:
                            numerical_feats[base_key].append(float(value))

    scaling_stats = {}
    for key, values in numerical_feats.items():
        if not values:
            scaling_stats[key] = {'mean': 0.0, 'std': 1.0}
            continue

        values_arr = np.array(values, dtype=np.float64)
        if key not in NO_LOG_SCALING_KEYS:
            values_arr = np.log1p(values_arr)

        mean = np.mean(values_arr)
        std = np.std(values_arr)
        if std < 1e-8:
            std = 1.0
            
        scaling_stats[key] = {'mean': mean, 'std': std}

    return scaling_stats


def compute_graph_attr_scaling_stats(
    dataset_dir: str,
    benchmarks: Optional[Union[str, List[str]]] = None,
) -> Dict[str, Dict[str, float]]:
    graph_attrs = {feat: [] for feat in GRAPH_ATTRS}

    if benchmarks is None:
        benchmarks = sorted(os.listdir(dataset_dir))
    elif isinstance(benchmarks, str):
        benchmarks = [benchmarks]

    for bench in benchmarks:
        bench_dir = os.path.join(dataset_dir, bench)
        if not os.path.isdir(bench_dir):
            print(f"Skipping {bench} (directory not found)")
            continue

        for sol in os.listdir(bench_dir):
            sol_dir = os.path.join(bench_dir, sol)
            if not os.path.isdir(sol_dir) or not sol.startswith("solution"):
                continue

            graph_path = os.path.join(sol_dir, "graph.pkl")
            if not os.path.exists(graph_path):
                print(f"Skipping {sol} (kernel info file not found)")
                continue

            with open(graph_path, 'rb') as f:
                kernel_graph = pickle.load(f)

            for key, value in kernel_graph.graph_attr.items():
                if key in graph_attrs:
                    graph_attrs[key].append(float(value))

    scaling_stats = {}
    for key, values in graph_attrs.items():
        if not values:
            scaling_stats[key] = {'mean': 0.0, 'std': 1.0}
            continue

        values_arr = np.array(values, dtype=np.float64)
        if key not in NO_LOG_SCALING_GRAPH_KEYS:
            values_arr = np.log1p(values_arr)

        mean = np.mean(values_arr)
        std = np.std(values_arr)
        if std < 1e-8:
            std = 1.0

        scaling_stats[key] = {'mean': mean, 'std': std}

    return scaling_stats


def extract_base_graphs(benchmark_info_dict: Dict[str, Dict[str, Any]]) -> Dict[str, KernelGraph]:
    from estimators.common.llvm_md_collector import extract_array_and_loop_md
    
    kernel_info_dict = {}
    for bench_name, bench_info in benchmark_info_dict.items():
        sol_dir = bench_info['base_solution_dir']
        top_level_name = bench_info['top_level']
        ir_dir = f"{sol_dir}/.autopilot/db"
        try:
            array_md_dict, loop_md_dict = extract_array_and_loop_md(ir_dir)
            kernel_info_dict[bench_name] = KernelGraph(
                solution_dir=sol_dir, 
                top_level_name=top_level_name, 
                array_md_dict=array_md_dict,
                loop_md_dict=loop_md_dict,
                benchmark_name=bench_name
            )
        except Exception as e:
            print(f"Error processing {bench_name}: {e}")
            continue

    return kernel_info_dict


def update_with_directives(
    base_kernel_graph: KernelGraph, 
    directives_tcl_path: str,
    vitis_log_path: Optional[str] = None
) -> KernelGraph:
    kernel_graph = copy.deepcopy(base_kernel_graph)
    directives = parse_tcl_directives(directives_tcl_path)

    for dct, args in directives:
        if dct not in DIRECTIVES or "off" in args:
            continue

        if dct == "array_partition":
            function_name = args.get("location", "")
            target_name = args.get("variable")
            if target_name is None:
                print("Warning: No variable specified for array partition.")
                continue

            node = find_array_node(kernel_graph, target_name, function_name)
            if node is None:
                print(f"Warning: Variable '{target_name}' "
                      f"(function '{function_name}') not found in nodes.")
                continue

            ap_type = args.get("type", "complete")

            if ap_type == "cyclic":
                node.feature_dict["partition_type"] = [1, 0, 0]
            elif ap_type == "block":
                node.feature_dict["partition_type"] = [0, 1, 0]
            else:
                node.feature_dict["partition_type"] = [0, 0, 1]

            ap_dim = int(args.get("dim", 0))
            if ap_dim > node.num_dims:
                ap_dim = 0
            elif ap_dim > MAX_ARRAY_DIM:
                ap_dim = MAX_ARRAY_DIM

            array_dims = node.feature_dict['original_array_dims']

            if ap_type == "complete":
                if ap_dim == 0:
                    ap_factor = node.array_size
                else:
                    ap_factor = array_dims[ap_dim - 1]

                partition_size = node.array_size // ap_factor
                if partition_size < 1024:
                    node.feature_dict["is_large_array"] = 0
            else:
                ap_factor = int(args.get("factor", 0))
                if ap_dim == 0:
                    ap_dim = node.num_dims

                target_dim_size = array_dims[ap_dim - 1]
                non_target_dim_prod = 1
                for i in range(node.num_dims):
                    if i != ap_dim - 1:
                        non_target_dim_prod *= array_dims[i]

                ceil_partition_dim_size = math.ceil(target_dim_size / float(ap_factor))
                ceil_partition_size = ceil_partition_dim_size * non_target_dim_prod

                last_partition_dim_size = target_dim_size % ap_factor

                is_uneven = last_partition_dim_size != 0
                node.feature_dict["is_unevenly_partitioned"] = int(is_uneven)

                if ceil_partition_size < 1024:
                    node.feature_dict["is_large_array"] = 0
                elif is_uneven:
                    last_partition_size = last_partition_dim_size * non_target_dim_prod
                    if last_partition_size < 1024:
                        if (node.node_type == "internal_mem" or 
                            (node.node_type == "port" and not node.is_top_level_port)):
                            node.feature_dict["has_hybrid_impl"] = 1

            node.feature_dict["array_partition"] = 1
            node.feature_dict["partition_factor"] = ap_factor
            node.feature_dict["partition_dim"][ap_dim] = 1

            ap_feats = [
                "array_partition", "partition_type", "partition_dim", 
                "partition_factor", "is_large_array", 
                "is_unevenly_partitioned", "has_hybrid_impl"
            ]
            matching_ports = node.matching_ports.copy()

            while matching_ports:
                port_id = matching_ports.pop()
                port_node = kernel_graph.nodes[port_id]

                for key in ap_feats:
                    if key == "partition_dim":
                        port_node.feature_dict[key][ap_dim] = 1
                    elif key == "partition_type":
                        port_node.feature_dict[key] = node.feature_dict[key].copy()
                    else:
                        port_node.feature_dict[key] = node.feature_dict[key]

                matching_ports.extend(port_node.matching_ports)
        else:
            location = args["location"]
            if "/" in location:
                function_name, target_name = location.split("/")
            else:
                function_name, target_name = location, ''

            if target_name:
                node = find_region_node(kernel_graph, target_name, function_name)
            else:
                node = find_function_node(kernel_graph, function_name)

            if node is None:
                print(f"Warning: Target location '{location}' not found in graph.")
                continue

            if dct == "pipeline":
                node.feature_dict["pipeline"] = 1
                _unroll_pipelined_subloops(kernel_graph, node)
            elif dct == "unroll":
                if node.feature_dict["unroll"] != 1:
                    trip_count = node.feature_dict.get("trip_count", 0)
                    unroll_factor = int(args.get("factor", 0))
                    if unroll_factor <= 0 or (trip_count > 0 and unroll_factor > trip_count):
                        unroll_factor = trip_count
                    node.feature_dict["unroll_factor"] = unroll_factor
                    node.feature_dict["unroll"] = 1
            else:
                node.feature_dict[dct] = 1

    # Note: The subsequent logic is needed only because our dataset were not
    # generated entirely with all needed directives disabled. For future datasets
    # and for inference during the DSE heuristic, this logic should be skipped
    # since it relies on the Vitis log file, which will not be available.
    
    # if not vitis_log_path:
    #     kernel_graph.graph_attr = kernel_graph.compute_graph_attrs()
    #     return kernel_graph
    
    # if not os.path.exists(vitis_log_path):
    #     print(f"Warning: Vitis log file '{vitis_log_path}' does not exist.")
    #     kernel_graph.graph_attr = kernel_graph.compute_graph_attrs()
    #     return kernel_graph
    
    # auto_dcts = extract_auto_dcts_from_log(vitis_log_path)
    # auto_inline = auto_dcts.get("inline", set())
    # auto_pipeline = auto_dcts.get("pipeline", set())
    # auto_loop_flatten = auto_dcts.get("loop_flatten", set())

    # for function_name in auto_inline:
    #     node = find_function_node(kernel_graph, function_name)
    #     if node is not None:
    #         node.feature_dict["inline"] = 1
    #         continue

    # for loop_name in auto_pipeline:
    #     for node in kernel_graph.nodes.values():
    #         if node.node_type == 'region' and node.name == loop_name:
    #             node.feature_dict["pipeline"] = 1
    #             if node.is_loop:
    #                 _unroll_pipelined_subloops(kernel_graph, node)
    #             break

    # for loop_name, function_name in auto_loop_flatten:
    #     node = find_region_node(kernel_graph, loop_name, function_name)
    #     if node is not None:
    #         node.feature_dict["loop_flatten"] = 1

    kernel_graph.graph_attr = kernel_graph.compute_graph_attrs()

    return kernel_graph


def plot_simplified_kernel_graph(kernel_graph: KernelGraph, output_path: str):
    import matplotlib.pyplot as plt
    import networkx as nx
    from matplotlib.patches import Patch

    # Color palette grouped by function
    ncolor_dict = {
        # Structure (Warm Colors)
        "function": "#ff6347",
        "region": "#ff9f43",
        # Data & Memory (Cool Blues/Greens)
        "op": "#87ceeb",
        "port": "#9370db"
    }
    ecolor_dict = {
        # Data Flow
        "data": "#4169e1",
        # Control Flow
        "control": "#0B9145",
        "call": "#c71585",
        # Hierarchy
        "hier": "#8D8D8D"
    }
    
    G = nx.DiGraph()

    # Process nodes and edges for NetworkX
    for node_id, node in kernel_graph.nodes.items():
        # Prune nodes that are not central to understanding the graph
        # to avoid visual clutter
        ntype = node.node_type
        if ntype not in ncolor_dict:
            continue

        # Ensure compact labels for better visualization
        if ntype == 'op':
            if node.opcode in ['getelementptr', 'zext']:
                continue
            label = node.opcode
        else:
            label = node.label
            if '/' in label:
                label = label.split('/')[-1]
            if ntype in ['region', 'block'] and '_loop' in label:
                label = 'loop' + label.split('_loop')[-1]
            if len(label) > 15:
                label = label[:6] + '...' + label[-6:]

        ncolor = ncolor_dict[ntype]
        G.add_node(node_id, label=label, type=node.node_type, color=ncolor)

    for edge in kernel_graph.edges.values():
        src_type, etype, dst_type = edge.src_type, edge.etype, edge.dst_type
        if etype not in ecolor_dict or edge.src not in G or edge.dst not in G:
            continue
        if ((etype == 'hier' and src_type in ['function', 'region'] and dst_type == 'op') or
            (etype == 'control' and src_type == 'op' or dst_type == 'op')):
            continue  

        ecolor = ecolor_dict[etype]
        G.add_edge(edge.src, edge.dst, color=ecolor, style='solid')

    # Prepare attributes for drawing
    nlabels = {node: data['label'] for node, data in G.nodes(data=True)}
    ncolors = [data['color'] for __, data in G.nodes(data=True)]
    ecolors = [data['color'] for __, __, data in G.edges(data=True)]
    estyles = [data['style'] for __, __, data in G.edges(data=True)]
    
    node_legend_handles = [Patch(color=color, label=ntype) for ntype, color in ncolor_dict.items()]
    edge_legend_handles = [
        Patch(color="#4169e1", label='Data Flow'),
        Patch(color="#0B9145", label='Control Flow'),
        Patch(color="#c71585", label='Call Flow'),
        Patch(color="#8D8D8D", label='Hierarchy'),
    ]

    pos = nx.kamada_kawai_layout(G, scale=5)

    plt.figure(figsize=(10, 8))
    nx.draw_networkx_nodes(G, pos, node_color=ncolors, node_size=200, alpha=0.9)
    nx.draw_networkx_edges(G, pos, edge_color=ecolors, style=estyles, arrowsize=8, width=0.8, alpha=0.9)
    nx.draw_networkx_labels(G, pos, labels=nlabels, font_size=7, font_weight='light')

    plt.legend(
        handles=node_legend_handles + edge_legend_handles,
        loc='lower right',
        bbox_to_anchor=(0.4, 0.0),
        ncol=2,
        fontsize=10,
        frameon=True
    )
    plt.axis('off')
    
    if output_path:
        plt.savefig(
            output_path, format='png', bbox_inches='tight', 
            dpi=400, pad_inches=0.1, transparent=True
        )
        print(f"Kernel graph saved to {output_path}")
    else:
        plt.show()


def plot_kernel_graph(kernel_graph: KernelGraph, output_path: str):
    import matplotlib.pyplot as plt
    import networkx as nx
    from matplotlib.patches import Patch

    # Color palette grouped by function
    ncolor_dict = {
        # Structure (Warm Colors)
        "function": "#ff6347",
        "region": "#ff9f43",
        "block": "#ffd700",
        # Data & Memory (Cool Blues/Greens)
        "op": "#87ceeb",
        "internal_mem": "#4682b4",
        "port": "#9370db",
        # Less Important
        "const": "#d3d3d3",
    }
    ecolor_dict = {
        # Data Flow
        "data": "#4169e1",
        "memory": "#2bc9ae",
        "store": "#41a1e1",
        "alloca": "#00ced1",
        "arg": "#9370db",
        # Control Flow
        "control": "#0B9145",
        "branch": "#2e8b57",
        "call": "#c71585",
        "ret": "#c71585",
        # Hierarchy
        "hier": "#8D8D8D",
        "module_hier": "#8D8D8D",
    }

    G = nx.DiGraph()
    
    # Process nodes and edges for NetworkX
    for node_id, node in kernel_graph.nodes.items():
        ntype = node.node_type
        if ntype not in ncolor_dict:
            continue

        # Ensure compact labels for better visualization
        if ntype == 'op':
            label = node.opcode
            if label == 'getelementptr':
                label = 'gep'
        elif ntype == 'const':
            label = str(node.content)
        else:
            label = node.label
            if '/' in label:
                label = label.split('/')[-1]
            if len(label) > 15:
                label = label[:6] + '...' + label[-6:]

        ncolor = ncolor_dict[ntype]
        G.add_node(node_id, label=label, type=ntype, color=ncolor)

    for edge in kernel_graph.edges.values():
        etype = edge.etype
        if etype in ecolor_dict and edge.src in G and edge.dst in G:
            ecolor = ecolor_dict[etype]
            G.add_edge(edge.src, edge.dst, color=ecolor, style='solid')

    # Prepare attributes for drawing
    nlabels = {node: data['label'] for node, data in G.nodes(data=True)}
    ncolors = [data['color'] for __, data in G.nodes(data=True)]
    
    # Set size and alpha for each node type
    nsizes = []
    nalphas = []
    for __, data in G.nodes(data=True):
        if data['type'] == 'const':
            nsizes.append(80)    # Make const nodes smaller
            nalphas.append(0.6)  # Make const nodes more transparent
        else:
            nsizes.append(180)
            nalphas.append(0.9)

    ecolors = [data['color'] for __, __, data in G.edges(data=True)]
    estyles = [data['style'] for __, __, data in G.edges(data=True)]
    
    node_legend_handles = [Patch(color=color, label=ntype) for ntype, color in ncolor_dict.items()]
    edge_legend_handles = [
        Patch(color="#4169e1", label='Data Flow'),
        Patch(color="#00ced1", label='Memory Allocation'),
        Patch(color="#0B9145", label='Control Flow'),
        Patch(color="#c71585", label='Call Flow'),
        Patch(color="#9370db", label='Argument Passing'),
        Patch(color="#8D8D8D", label='Hierarchy'),
    ]

    pos = nx.kamada_kawai_layout(G, scale=5)

    plt.figure(figsize=(10, 8))
    nx.draw_networkx_nodes(G, pos, node_color=ncolors, node_size=nsizes, alpha=nalphas)
    nx.draw_networkx_edges(G, pos, edge_color=ecolors, style=estyles, arrowsize=8, width=0.8, alpha=0.9)
    nx.draw_networkx_labels(G, pos, labels=nlabels, font_size=7, font_weight='light')

    plt.legend(
        handles=node_legend_handles + edge_legend_handles,
        loc='lower right',
        bbox_to_anchor=(0.4, -0.18),
        ncol=2,
        fontsize=8,
        frameon=True
    )
    plt.axis('off')
    
    if output_path:
        plt.savefig(output_path, format='png', bbox_inches='tight', dpi=400, pad_inches=0.1, transparent=True)
        print(f"Kernel graph saved to {output_path}")
    else:
        plt.show()


def find_array_node(kernel_info, array_name, function_name):
    if function_name:
        for node in kernel_info.nodes.values():
            if (node.node_type in ['internal_mem', 'port']
                and node.name == array_name 
                and node.function_name == function_name):
                return node
                
    # If not found, search for array_name only
    for node in kernel_info.nodes.values():
        if node.node_type in ['internal_mem', 'port'] and node.name == array_name:
            return node

    return None


def find_region_node(kernel_info, region_name, function_name):
    for node in kernel_info.nodes.values():
        if (node.node_type == 'region'
            and node.name == region_name
            and node.function_name == function_name):
            return node
        
    # If not found, search for region_name only
    for node in kernel_info.nodes.values():
        if node.node_type == 'region' and node.name == region_name:
            return node
    
    return None


def find_function_node(kernel_info, function_name):
    for node in kernel_info.nodes.values():
        if (node.node_type == 'function' 
            and (node.original_name == function_name or node.name == function_name)):
            return node
        

def _unroll_pipelined_subloops(graph, loop_node):
    """Completely unroll all subloops of a pipelined loop."""
    for sub_region_id in loop_node.sub_regions:
        node = graph.nodes[sub_region_id]
        if node.is_loop:
            trip_count = node.feature_dict.get("trip_count", 0)
            node.feature_dict["unroll_factor"] = trip_count
            node.feature_dict["unroll"] = 1
        _unroll_pipelined_subloops(graph, node)


if __name__ == "__main__":
    from pathlib import Path
    from estimators.common.llvm_md_collector import extract_array_and_loop_md

    solution_dir = Path('tests/projects/test2/prj/solution0')
    ir_dir = solution_dir / '.autopilot/db'
    array_md, loop_md = extract_array_and_loop_md(ir_dir)
    graph = KernelGraph(
        solution_dir=str(solution_dir),
        top_level_name='top_fn',
        array_md_dict=array_md,
        loop_md_dict=loop_md,
        benchmark_name='test2'
    )
    plot_simplified_kernel_graph(graph, output_path='figures/kernel_graph.png')

    # with open('data/benchmark_info.json', 'r') as f:
    #     bench_info_dict = json.load(f)

    # base_sols_dir = Path('data/base_solutions')
    # output_dir = Path('data/kernel_graphs')

    # for bench_name, bench_info in bench_info_dict.items():
    #     solution_dir = Path(bench_info['base_solution_dir'])
    #     ir_dir = solution_dir / '.autopilot/db'

    #     array_md, loop_md = extract_array_and_loop_md(ir_dir)
        
    #     graph = KernelGraph(
    #         solution_dir=str(solution_dir),
    #         top_level_name=bench_info['top_level'],
    #         array_md_dict=array_md,
    #         loop_md_dict=loop_md,
    #         benchmark_name=bench_name
    #     )
    #     output_path = output_dir / f"{bench_name}_graph.json"
    #     graph.save_as_json(output_path)
    #     print(f"Saved graph for {bench_name} to {output_path}")

    #     # plot_kernel_graph(graph, output_path=None)

    # print("All kernel graphs have been generated and saved.")