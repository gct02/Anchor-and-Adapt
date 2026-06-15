import os
import json
import math
import re
import xml.etree.ElementTree as ET
import subprocess
from abc import ABC, abstractmethod
from typing import Optional, Dict, Any, List, Tuple

import torch
from torch import Tensor

from estimator.common.parsers import (
    extract_metrics, 
    extract_per_module_area, 
    extract_array_impl_info, 
    extract_early_auto_pipelines,
    findint, 
    findfloat
)
from estimator.common.graph_config import GraphConfig
from estimator.common.constants import *


class Node:
    def __init__(
        self,
        config: GraphConfig,
        node_type: str,
        element: ET.Element,
        module_name: str,
        source_function_name: str
    ):
        self.config = config

        if node_type not in config.node_type_set:
            raise ValueError(f"Unknown node type: {node_type}")
        
        self.type = node_type
        self.module_name = module_name
        self.source_function_name = source_function_name

        if node_type == "region":
            node_id = findint(element, 'mId')
            if node_id is None:
                raise ValueError("Element does not contain 'mId' tag")
            
            self.is_loop = findint(element, "mType", 0) == 1
            self.is_function = not self.is_loop and node_id == 1

            if self.is_function:
                self.id = f"{module_name}.function"
                self.tag = source_function_name
            else:
                self.id = f"{module_name}.loop.{node_id}"
                self.tag = element.findtext("mNormTag", "")
                if not self.tag: 
                    self.tag = element.findtext("mTag", "")
        else:
            value = element.find("Value")
            obj = value.find("Obj") if value is not None else element.find("Obj")
            if obj is None:
                raise ValueError("Element does not contain 'Obj' or 'Value/Obj' tag")
            
            node_id = findint(obj, "id")
            if node_id is None:
                raise ValueError("Element does not contain 'id' tag")
            
            self.is_loop = False
            self.is_function = False

            self.id = f"{module_name}.{node_id}"
            self.tag = obj.findtext("name", "")

        # Updated in child classes
        self.features = {k: 0 for k in config.node_features[node_type]}
        self.is_array = False

    def get_feature_tensor(self) -> Tensor:
        feats = []
        for k in self.config.node_features[self.type]:
            v = self.features.get(k, 0)
            if k in self.config.features_to_log_scale: 
                v = math.log1p(v)
            feats.append(v)
        return torch.tensor(feats, dtype=torch.float32)

    def as_dict(self):
        return {
            "type": self.type,
            "module": self.module_name,
            "tag": self.tag,
            "features": self.features
        }

    def __str__(self):
        return json.dumps(self.as_dict(), indent=2)
    
    def __repr__(self):
        return self.__str__()
    

class MemBufNode(Node):
    def __init__(
        self,
        config: GraphConfig,
        element: ET.Element,
        module_name: str,
        source_function_name: str,
        is_port: bool = False,
        is_interface: bool = False
    ):
        super().__init__(
            config=config,
            node_type="mem_buf",
            element=element,
            module_name=module_name,
            source_function_name=source_function_name
        )
        self.bitwidth = max(0, findint(element, "Value/bitwidth", 0))
        self.is_port = is_port
        self.is_interface = is_port and is_interface
        self.features["bitwidth"] = self.bitwidth
        self.features["is_port"] = int(is_port)
        self.features["is_interface"] = int(self.is_interface)

        if is_port:
            self.array_size = max(0, findint(element, "array_size", 0))
            self.core_type = ""
            self.rtl_name = ""
            self.is_global = False
            self.direction = findint(element, 'direction', 2)
        else:
            self.array_size = max(0, findint(element, "Value/Obj/storageDepth", 0))
            self.core_type = element.findtext("Value/Obj/coreName", "").lower()
            self.rtl_name = element.findtext("Value/Obj/rtlName", "")
            self.is_global = element.findtext("opcode", "") == "GlobalMem"
            self.direction = None
            if self.is_global:
                self.features["is_global"] = 1
            else:
                self.features["is_local"] = 1

        if self.array_size > 1:
            self.is_array = True
            self.array_dims = [self.array_size]
            self.array_num_dims = 1
            self.features["array_size"] = self.array_size
            self.features["part_size"] = self.array_size
            self.features["part_factor"] = 1
            self.features["part_bitsize"] = self.array_size * self.bitwidth
            self.rtl_name = self.tag + "_U"
            if not is_port:
                if self.core_type.startswith("ram"):
                    self.features["is_ram"] = 1
                elif self.core_type.startswith("rom"):
                    self.features["is_rom"] = 1
        else:
            self.is_array = False
            self.array_dims = []
            self.array_num_dims = 0

        self.parent_block = None  # To update

    def as_dict(self):
        node_as_dict = super().as_dict()
        if self.rtl_name:
            node_as_dict["rtl_name"] = self.rtl_name
        if self.core_type:
            node_as_dict["core_type"] = self.core_type
        if self.array_num_dims > 1:
            node_as_dict["array_dims"] = self.array_dims.copy()
        return node_as_dict
    

class OpNode(Node):
    def __init__(
        self,
        config: GraphConfig,
        element: ET.Element,
        module_name: str,
        source_function_name: str
    ):
        super().__init__(
            config=config,
            node_type="op",
            element=element,
            module_name=module_name,
            source_function_name=source_function_name
        )
        self.bitwidth = findint(element, "Value/bitwidth", 0)
        self.delay = max(0.0, findfloat(element, "m_delay", 0.0))
        self.opcode = element.findtext("opcode", "")
        self.optype = config.optype_map.get(self.opcode, "optype_other")
        self.core_type = element.findtext("Value/Obj/coreName", "").lower()
        self.rtl_name = element.findtext("Value/Obj/rtlName", "")

        self.features[self.optype] = 1
        self.features["bitwidth"] = self.bitwidth
        self.features["delay"] = self.delay
        self.features["is_float"] = int(self.opcode in FLOAT_OPS)

        # To update
        self.parent_block = None
        self.operands = []

    def as_dict(self):
        node_as_dict = super().as_dict()
        node_as_dict["opcode"] = self.opcode
        node_as_dict["operands"] = self.operands
        if self.rtl_name:
            node_as_dict["rtl_name"] = self.rtl_name
        if self.core_type:
            node_as_dict["core_type"] = self.core_type
        return node_as_dict


class BlockNode(Node):
    def __init__(
        self, 
        config: GraphConfig,
        element: ET.Element,
        module_name: str,
        source_function_name: str
    ):
        super().__init__(
            config=config,
            node_type="block",
            element=element,
            module_name=module_name,
            source_function_name=source_function_name
        )
        self.ops = [
            f"{module_name}.{op}" 
            for op in self._extract_items(element, "node_objs")
        ]
        if self.tag == "entry" or self.tag == module_name:
            self.features["is_entry"] = 1
        self.parent = None  # To update

    def _extract_items(self, element, tag):
        parent_tag = element.find(tag)
        if parent_tag is None: return []
        return [int(item.text) for item in parent_tag.findall("item")]
    
    def as_dict(self):
        node_as_dict = super().as_dict()
        node_as_dict["ops"] = self.ops.copy()
        return node_as_dict
    

class RegionNode(Node):
    def __init__(
        self,
        config: GraphConfig,
        element: ET.Element,
        module_name: str,
        source_function_name: str,
        is_top_function: bool = False
    ):
        super().__init__(
            config=config,
            node_type="region",
            element=element,
            module_name=module_name,
            source_function_name=source_function_name
        )
        latency = findint(element, "mMaxLatency", 0)
        if latency < 0: 
            # If latency is negative, there was an overflow
            latency = latency + (1 << 32) 
        self.latency = max(1, latency)
        self.features["region_latency"] = self.latency

        if self.is_loop:
            self.trip_count = max(1, findint(element, "mMaxTripCount", 0))
            self.features["trip_count"] = self.trip_count
            self.features["unroll_factor"] = 1
            self.depth = 1  # To update
            self.is_top_function = False
        else:
            self.is_top_function = is_top_function
            self.features["is_top_function"] = int(is_top_function)
            self.trip_count = 0
            self.depth = 0

        self.sub_regions = [
            f"{module_name}.loop.{r}" 
            for r in self._extract_items(element, "sub_regions")
        ]
        self.blocks = [
            f"{module_name}.{b}"
            for b in self._extract_items(element, "basic_blocks")
        ]
        # To update
        self.alt_names = []
        self.sub_regions_closure = []
        self.blocks_closure = []
        self.parent = None

    def _extract_items(self, element, tag):
        parent_tag = element.find(tag)
        if parent_tag is None: return []
        return [int(item.text) for item in parent_tag.findall("item")]

    def as_dict(self):
        node_as_dict = super().as_dict()
        node_as_dict["sub_regions"] = self.sub_regions.copy()
        node_as_dict["blocks"] = self.blocks.copy()
        return node_as_dict
    

class Edge:
    def __init__(
        self, 
        edge_type: Tuple[str, str, str], 
        src: str, 
        dst: str,
        id_suffix: str = ""
    ):
        self.type = edge_type
        self.src, self.dst = src, dst
        self.id = src + "__".join(edge_type) + dst + id_suffix

    def __str__(self):
        return f"{self.src} -> {self.dst} ({','.join(self.type)})"
    
    def __repr__(self):
        return self.__str__()
    

class CDFG:
    def __init__(
        self, 
        config: GraphConfig,
        root: ET.Element, 
        top_function: Optional[str] = None
    ):
        self.config = config

        cdfg = root.find("syndb/cdfg")
        if cdfg is None:
            raise ValueError("'cdfg' not found in ADB")
        
        cdfg_regions = root.find("syndb/cdfg_regions")
        if cdfg_regions is None:
            raise ValueError("'cdfg_regions' not found in ADB")
        
        region_elems = cdfg_regions.findall("item")
        if len(region_elems) == 0:
            raise ValueError("Invalid ADB: 'cdfg_regions' has no region")

        function_elem = region_elems[0]
        self.module_name = function_elem.findtext("mNormTag", "")

        self.name = function_elem.findtext("mTag", "")
        if "&lt;" in self.name:
            self.name = self.name.replace("&lt;", "<").replace("&gt;", ">")

        self.source_name = self.name
        if re.search(r"\.[1-9]\d*$", self.source_name):
            self.source_name = self.source_name[:self.source_name.rfind(".")]

        self.alt_names = [self.module_name, self.source_name, self.name]
        self.top_function = top_function or ""
        self.is_top_function = (self.module_name == top_function)
        
        self.nodes: Dict[str, Node] = {}
        self.edges: Dict[str, Edge] = {}

        self.op_region_map: Dict[str, str] = {}
        self.function_calls: Dict[str, str] = {}
        self.nodes_to_bypass = set()
        self.gep_nodes = set()
        self.ports = []

        self._const_gep_nodes = set()
        self._const_callee_map = {}

        self._parse_nodes(cdfg, cdfg_regions)
        self._create_port_mem_adj(root)
        self._parse_edges(cdfg)

    def _parse_nodes(self, cdfg, cdfg_regions):
        self._parse_op_mem_nodes(cdfg.find("nodes"))
        self._parse_port_nodes(cdfg.find("ports"))
        self._parse_const_nodes(cdfg.find("consts"))
        self._parse_block_nodes(cdfg.find("blocks"))
        self._parse_region_nodes(cdfg_regions)

    def _parse_op_mem_nodes(self, element):
        if element is None: return
        self._operand_edges = {}

        for elem in element.findall("item"):
            opcode = elem.findtext("opcode", "")
            if opcode in ["alloca", "GlobalMem"]:
                node = MemBufNode(self.config, elem, self.module_name, self.source_name)
            else:
                node = OpNode(self.config, elem, self.module_name, self.source_name)
                self._operand_edges[node.id] = []
                op_edges = elem.find("oprand_edges")
                if op_edges is not None:
                    for item in op_edges.findall("item"):
                        self._operand_edges[node.id].append(int(item.text))

                if node.opcode == "getelementptr":
                    self.gep_nodes.add(node.id)
                if node.opcode in self.config.ops_to_trim:
                    self.nodes_to_bypass.add(node.id)

            self.nodes[node.id] = node

    def _parse_port_nodes(self, element):
        if element is None: return
        for elem in element.findall("item"):
            node = MemBufNode(
                self.config, elem, self.module_name, self.source_name, 
                is_port=True, is_interface=self.is_top_function
            )
            self.nodes[node.id] = node
            self.ports.append(node.id)

    def _parse_const_nodes(self, element):
        if element is None: return
        for elem in element.findall("item"):
            obj = elem.find("Value").find("Obj")
            const_type = str(elem.findtext("const_type", "other"))
            node_id = f"{self.module_name}.{findint(obj, 'id')}"
            if const_type == "6":
                # This represents the called function on a call site
                self._const_callee_map[node_id] = obj.findtext("name", "")
            elif const_type == "4":
                # This represents the constant pointer returned by a ConstantExpr GEP
                # We will bypass these nodes
                self._const_gep_nodes.add(node_id)

    def _parse_block_nodes(self, element):
        self.entry_block = None
        if element is None: return
        for elem in element.findall("item"):
            node = BlockNode(self.config, elem, self.module_name, self.source_name)
            node.ops = [op for op in node.ops if op in self.nodes]
            for op in node.ops:
                self.nodes[op].parent_block = node.id
                if self.nodes[op].type == "op":
                    if self.nodes[op].opcode == "ret":
                        node.features["is_exit"] = 1
            self.nodes[node.id] = node

            if node.features.get("is_entry", 0) == 1:
                self.entry_block = node.id
        
        if self.entry_block is None:
            blocks = [n for n, node in self.nodes.items() if node.type == "block"]
            self.entry_block = sorted(blocks)[0]

    def _parse_region_nodes(self, element):
        elems = element.findall("item")
        function_elem = elems[0]
        region_elems = elems[1:]
        region_blocks_map = {}
        for elem in region_elems:
            is_loop = findint(elem, "mType", 0) == 1
            if not is_loop:
                mid = findint(elem, "mId")
                region_id = f"{self.module_name}.loop.{mid}"
                region_blocks_map[region_id] = []
                blocks_tag = elem.find("basic_blocks")
                if blocks_tag is not None:
                    for item in blocks_tag.findall("item"):
                        block_id = f"{self.module_name}.{int(item.text)}"
                        region_blocks_map[region_id].append(block_id)

        name_pfx = f'{self.top_function}_'
        loop_nodes: Dict[str, RegionNode] = {}
        for elem in region_elems:
            mid = findint(elem, "mId")
            region_id = f"{self.module_name}.loop.{mid}"
            if region_id in region_blocks_map: continue

            node = RegionNode(self.config, elem, self.module_name, self.source_name)
            sub_loops = set()
            blocks = set(node.blocks)
            for sub in node.sub_regions:
                if sub in region_blocks_map: 
                    blocks.update(region_blocks_map[sub])
                else: 
                    sub_loops.add(sub)
            node.sub_regions = list(sub_loops)
            node.blocks = [b for b in blocks if b in self.nodes]

            for b in node.blocks:
                self.nodes[b].parent = node.id
                for op in self.nodes[b].ops:
                    self.op_region_map[op] = node.id

            tags = [elem.findtext("mNormTag", ""), elem.findtext("mTag", "")]
            node.alt_names = tags + [name_pfx + t for t in tags]
            loop_nodes[node.id] = node

        for n, node in loop_nodes.items():
            loop_nodes[n].sub_regions = [
                s for s in node.sub_regions if s in loop_nodes
            ]
            for s in node.sub_regions: 
                loop_nodes[s].parent = n

            sub_regions_closure = set()
            blocks_closure = set(node.blocks)
            queue = node.sub_regions.copy()
            while queue:
                sub = queue.pop()
                sub_regions_closure.add(sub)
                blocks_closure.update(loop_nodes[sub].blocks)
                queue.extend(loop_nodes[sub].sub_regions.copy())
            loop_nodes[n].sub_regions_closure = list(sub_regions_closure)
            loop_nodes[n].blocks_closure = list(blocks_closure)

        top_level_loops = []
        for n, node in loop_nodes.items():
            if node.parent is None:
                loop_nodes[n].features["is_top_loop"] = 1
                top_level_loops.append(n)
            if len(node.sub_regions) == 0:
                loop_nodes[n].features["is_innermost"] = 1
            for b in node.blocks_closure:
                for op in self.nodes[b].ops:
                    if self.nodes[op].type == "op":
                        if self.nodes[op].opcode == "phi":
                            loop_nodes[n].features["num_phi_nodes"] += 1

        queue = [(n, 1) for n in top_level_loops]
        visited = set()
        while queue:
            n, d = queue.pop()
            if n in visited: continue
            visited.add(n)
            loop_nodes[n].depth = d
            for s in loop_nodes[n].sub_regions:
                queue.append((s, d + 1))

        self.nodes.update(loop_nodes)

        # The first CDFG region represents the function itself
        function_node = RegionNode(
            config=self.config,
            element=function_elem,
            module_name=self.module_name,
            source_function_name=self.source_name, 
            is_top_function=self.is_top_function
        )
        sub_region_set = set([
            s for s in function_node.sub_regions if s in loop_nodes
        ])
        block_set = set([
            b for b in function_node.blocks if b in self.nodes
        ])
        for n, node in loop_nodes.items():
            function_node.sub_regions_closure.append(n)
            if node.parent is None and n not in sub_region_set:
                sub_region_set.add(n)

        for n, node in self.nodes.items():
            if node.type == "block":
                function_node.blocks_closure.append(n)
                if node.parent is None and n not in block_set:
                    block_set.add(n)

        function_node.sub_regions = list(sub_region_set)
        function_node.blocks = list(block_set)

        for b in function_node.blocks:
            for op in self.nodes[b].ops:
                if op not in self.op_region_map:
                    self.op_region_map[op] = function_node.id

        tags = self.alt_names.copy() 
        function_node.alt_names = tags + [name_pfx + t for t in tags]
        self.nodes[function_node.id] = function_node
        self.function_id = function_node.id

    def _create_port_mem_adj(self, root):
        self._port_mem_adj: Dict[str, List[str]] = {}
        mem_port_nodes = root.find("syndb/dp_mem_port_nodes")
        if mem_port_nodes is None: return

        for item in mem_port_nodes.findall("item"):
            name = item.findtext("first/first")
            node_ids = item.find("second")
            if name is None or node_ids is None: continue

            array_id = None
            for node_id, node in self.nodes.items():
                if node.tag == name and node.type == "mem_buf":
                    array_id = node_id
                    break
            if array_id is None: continue

            if array_id not in self._port_mem_adj: 
                self._port_mem_adj[array_id] = []

            for id_item in node_ids.findall("item"):
                node_id = f"{self.module_name}.{int(id_item.text)}" 
                if (node_id in self.nodes 
                    and self.nodes[node_id].type == "op"):
                    self._port_mem_adj[array_id].append(node_id)

    def _parse_edges(self, cdfg):
        self._edge_counter = 0
        const_gep_src, const_gep_dsts = {}, {}
        data_edge_map = {}
        control_edges = set()
        
        # --- Basic Edges ---
        for elem in cdfg.find("edges").findall("item"):
            src = findint(elem, "source_obj")
            dst = findint(elem, "sink_obj")
            if src is None or dst is None: continue

            src = f"{self.module_name}.{src}"
            dst = f"{self.module_name}.{dst}"
            
            type_id = elem.findtext("edge_type", "")
            if type_id == "1":
                rel_type = "data"
            elif type_id == "2":
                rel_type = "control"
            else:
                continue

            if elem.findtext("is_back_edge", "") == "1":
                rel_type += "_rec"  # "Recurrence" edge
            elif rel_type == "data":
                edge_id = findint(elem, "id")
                if edge_id is not None:
                    data_edge_map[edge_id] = (src, dst)

            if src in self._const_callee_map:
                if dst in self.nodes:
                    callee = self._const_callee_map[src]
                    self.function_calls[dst] = callee

            elif dst in self._const_gep_nodes:
                if rel_type == "data" and src in self.nodes:
                    src_node = self.nodes[src]
                    if src_node.type == "mem_buf":
                        const_gep_src[dst] = src
                    elif src_node.type == "op":
                        if src_node.type == "getelementptr":
                            const_gep_src[dst] = src

            elif src in self._const_gep_nodes:
                if rel_type == "data" and dst in self.nodes:
                    if self.nodes[dst].type == "op":
                        if src not in const_gep_dsts: 
                            const_gep_dsts[src] = set()
                        const_gep_dsts[src].add(dst)

            elif src in self.nodes and dst in self.nodes: 
                if rel_type.startswith("control"):
                    src_node = self.nodes[src]
                    dst_node = self.nodes[dst]
                    
                    if src_node.type != "block":
                        if src_node.parent_block is None: continue
                        src = src_node.parent_block

                    if dst_node.type != "block":
                        if dst_node.parent_block is None: continue
                        if (rel_type == "control" 
                            and dst_node.type == "op"
                            and dst_node.opcode in ["br", "switch"]):
                            dst = src
                            src = dst_node.parent_block
                        else:
                            dst = dst_node.parent_block
                    
                    if (src, dst) in control_edges: continue
                    control_edges.add((src, dst))

                self.add_edge(rel_type, src, dst)

        for node_id, edges in self._operand_edges.items():
            for edge_id in edges:
                if edge_id in data_edge_map:
                    src, dst = data_edge_map[edge_id]
                    if dst != node_id: continue
                    if src in self._const_callee_map: continue
                    if src in const_gep_src: 
                        src = const_gep_src[src]
                    self.nodes[node_id].operands.append(src)

        # --- Bypass trimmed const GEPs ---
        for gep_id, src in const_gep_src.items():
            if gep_id in const_gep_dsts:
                for dst in const_gep_dsts[gep_id]:
                    self.add_edge("data", src, dst)

        # --- Additional Array -> Data edges ---
        data_flow_edges = set(
            (edge.src, edge.dst) for edge in self.edges.values() 
            if edge.type[1] == "data"
        )
        for array_id, array_node in self.nodes.items():
            if array_node.is_array: 
                array_name = array_node.tag
                for node_id, node in self.nodes.items():
                    if (node.type == "op" 
                        and is_array_user(array_name, node.tag)):
                        if (array_id, node_id) not in data_flow_edges:
                            self.add_edge("data", array_id, node_id)
                            data_flow_edges.add((array_id, node_id))

        for array_id, node_ids in self._port_mem_adj.items():
            for node_id in node_ids:
                if (array_id, node_id) not in data_flow_edges:
                    self.add_edge("data", array_id, node_id)
                    data_flow_edges.add((array_id, node_id))

        # --- Hierarchy Edges ---
        for node_id, node in self.nodes.items():
            if node.type == "block":  
                for op in node.ops:
                    self.add_edge("hier", op, node_id)
            elif node.type == "region":
                for sub in node.sub_regions:
                    self.add_edge("hier", sub, node_id)
                    self.add_edge("hier_rev", node_id, sub)
                for b in node.blocks:
                    self.add_edge("hier", b, node_id)

    def add_edge(self, relation: str, src: str, dst: str) -> Edge:
        src_type = self.nodes[src].type
        dst_type = self.nodes[dst].type
        edge_type = (src_type, relation, dst_type)
        edge = Edge(edge_type, src, dst, id_suffix=str(self._edge_counter))
        self.edges[edge.id] = edge
        self._edge_counter += 1
        return edge
    
    def as_dict(self):
        return {
            "name": self.module_name,
            "nodes": {n: node.as_dict() for n, node in self.nodes.items()},
            "edges": [str(edge) for edge in self.edges.values()],
            "calls": self.function_calls
        }

    def __str__(self):
        return json.dumps(self.as_dict(), indent=2)
    
    def __repr__(self):
        return self.__str__()
    

class BaseKernelGraph(ABC):
    def __init__(self, benchmark: str):
        self.config = self.get_config()

        with open(BENCHMARK_INFO_PATH, 'r') as f:
            bench_info_dict = json.load(f)

        if benchmark not in bench_info_dict:
            raise KeyError(
                f"Unknown benchmark: {benchmark}. "
                f"Please, update the benchmark info in {BENCHMARK_INFO_PATH}."
            )
        bench_info = bench_info_dict[benchmark]
        for k in ["anchor_dir", "top_function", "ir_path"]:
            if k not in bench_info:
                raise KeyError(f"Missing key in benchmark info: {k}")

        self.benchmark = benchmark
        self.anchor_dir = bench_info["anchor_dir"]
        self.top_function = bench_info["top_function"]
        self.ir_path = bench_info["ir_path"]
        
        # --- Graph Construction ---
        self.nodes: Dict[str, Node] = {}
        self.edges: Dict[str, Edge] = {}
        
        self._edge_counter = 0

        self._process_adb_files()
        self._map_directive_targets_to_ids()

        self._data_flow_edges = set([
            (edge.src, edge.dst) for edge in self.edges.values() 
            if edge.type[1] == "data"
        ])

        # --- Graph Annotation ---
        array_param_dims = bench_info.get("array_param_dims", {})
        self._annotate_array_dims(array_param_dims)
        self._define_perfect_nests()
        self._annotate_op_latencies()
        self._annotate_with_anchor()
        self._create_array_access_edges()
        self._estimate_loop_iis()

        # --- Additional Flows and Simplification ---
        self._trim_irrelevant_ops()
        self._define_call_flow()
        self._clear_unwanted_edges()
        self._add_self_loops()

        # --- Sorting and Indexing ---
        self.sorted_node_ids = sorted(list(self.nodes.keys()))

        self.node_index_map = {nt: {} for nt in self.config.node_type_set}
        ncount = {nt: 0 for nt in self.config.node_type_set}
        for n in self.sorted_node_ids:
            nt = self.nodes[n].type
            self.node_index_map[nt][n] = ncount[nt]
            ncount[nt] += 1

    @abstractmethod
    def get_config(self) -> GraphConfig:
        pass

    def get_directive_features(
        self,
        directives: List[Dict[str, Any]],
        log_path: Optional[str] = None,
    ) -> Dict[str, Dict[str, float]]:
        dct_feats = {}

        def flatten_perfect_nest(n):
            if n not in self.top_loop_map: return
            top = self.top_loop_map[n]
            if top not in self.perfect_nests: return
            perfect_nest = self.perfect_nests[top]
            if len(perfect_nest) <= 1: return
            depth = self.nodes[n].depth
            for outer in perfect_nest:
                if self.nodes[outer].depth <= depth:
                    if outer not in dct_feats:
                        dct_feats[outer] = {}
                    dct_feats[outer]["loop_flatten"] = 1

        def unroll_sub_loops(n):
            for s in self.nodes[n].sub_regions_closure:
                if s not in dct_feats: dct_feats[s] = {}
                dct_feats[s]["pipelined_parent"] = 1
                trip_count = max(1, self.nodes[s].trip_count)
                dct_feats[s]["unroll_factor"] = trip_count

        for dct_info in directives:
            dct = dct_info.get("directive", "UNK")
            if dct not in DIRECTIVES: continue

            if dct == "array_partition":
                if "variable" not in dct_info: continue
                variable = dct_info["variable"]
                for n in self.array_id_map.get(variable, []):
                    node = self.nodes[n]
                    ap_type = dct_info.get("type", "complete")
                    factor = int(dct_info.get("factor", 0))
                    dim = int(dct_info.get("dim", 0))

                    if dim == 0:
                        if factor == 0 or factor >= node.array_size:
                            factor = node.array_size
                            part_size = 1
                        else:
                            part_size = math.ceil(node.array_size / factor)
                    else:
                        dim_size = node.array_dims[dim - 1]
                        if factor == 0 or factor >= dim_size:
                            factor = dim_size
                            part_size = math.ceil(node.array_size / factor)
                        else:
                            part_dim_size = math.ceil(dim_size / factor)
                            rem_size = node.array_size / dim_size
                            part_size = part_dim_size * rem_size

                    if n not in dct_feats: dct_feats[n] = {}
                    dct_feats[n]["part_factor"] = factor
                    dct_feats[n]["part_size"] = part_size
                    dct_feats[n]["part_type"] = int(ap_type == "cyclic")

                    part_bitsize = part_size * node.bitwidth
                    dct_feats[n]["part_bitsize"] = part_bitsize

                    if node.features.get("theoretical_bram", 0) > 0:
                        if part_bitsize >= LUTRAM_THRESHOLD:
                            part_bram = math.ceil(part_bitsize / BRAM_18K_BITS)
                            dct_feats[n]["theoretical_bram"] = part_bram * factor
                        else:
                            dct_feats[n]["theoretical_bram"] = 0
            else:
                if "location" not in dct_info: continue
                location = dct_info["location"]
                if "/" not in location:
                    # Function directive
                    n = self.function_id_map.get(location)
                    if n is None or dct != "loop_merge": continue
                    if n not in dct_feats: dct_feats[n] = {}
                    dct_feats[n][dct] = 1
                else:
                    # Loop directive
                    loop = location.split("/")[-1]
                    n = self.loop_id_map.get(loop)
                    if n is None: continue
                    if n not in dct_feats: dct_feats[n] = {}

                    if bool(dct_info.get("off", False)):
                        if dct == "pipeline":
                            dct_feats[n]["pipeline_off"] = 1
                        continue
                    dct_feats[n][dct] = 1

                    if dct == "unroll":
                        factor = int(dct_info.get("factor", 0))
                        trip_count = self.nodes[n].trip_count
                        if factor == 0 or factor >= trip_count:
                            dct_feats[n]["unroll_factor"] = trip_count
                        else:
                            curr_factor = dct_feats[n].get("unroll_factor", 0)
                            if factor > curr_factor:
                                dct_feats[n]["unroll_factor"] = factor
                    elif dct == "loop_flatten":
                        flatten_perfect_nest(n)
                    elif dct == "pipeline":
                        # If the pipelined loop is inside a perfect nest,
                        # flatten all outer loops inside this nest
                        flatten_perfect_nest(n)
                        # All sub-loops are fully unrolled
                        unroll_sub_loops(n)

        if log_path is not None and os.path.exists(log_path):
            with open(log_path, "r") as f:
                log_lines = f.readlines()
            auto_pipelines = extract_early_auto_pipelines(log_lines)
            for loop in auto_pipelines:
                n = self.loop_id_map.get(loop)
                if n is not None:
                    if n in dct_feats:
                        if dct_feats[n].get("pipeline", 0) == 1: 
                            continue
                    else:
                        dct_feats[n] = {}
                    dct_feats[n]["pipeline"] = 1
                    flatten_perfect_nest(n)
                    unroll_sub_loops(n)

        return dct_feats
    
    def _process_adb_files(self):
        adb_file_list = collect_adb_files(self.anchor_dir)
        if not adb_file_list:
            raise FileNotFoundError("No ADB files found")
        
        self.cdfgs: Dict[str, CDFG] = {}
        self.gep_nodes = set()
        top_id, top_entry_block = None, None
        for path in adb_file_list:
            print(f"Processing file: {path}")
            try:
                tree = ET.parse(path)
                root = tree.getroot()
                cdfg = CDFG(self.config, root, self.top_function)
            except Exception as e:
                print(e)
                continue

            self.nodes.update(cdfg.nodes.copy())
            self.edges.update(cdfg.edges.copy())
            self.cdfgs[cdfg.module_name] = cdfg
            if cdfg.is_top_function:
                top_id = cdfg.function_id
                top_entry_block = cdfg.entry_block

            self.gep_nodes.update(cdfg.gep_nodes)

        if top_id is None:
            raise ValueError("Top-level function node not found in ADB files.")
        self.top_level_id = top_id

        if self.config.connect_global_mem:
            for node_id, node in self.nodes.items():
                if node.type == "mem_buf" and node.is_global:
                    self.add_edge("hier", node_id, top_entry_block)
    
    def _annotate_array_dims(self, array_param_dims: Dict[str, List[int]]):
        def get_array_name(array_label):
            if "/" in array_label: return array_label.split("/")[-1]
            return array_label
        
        updated_arrays = set()
        for array_label, array_dims in array_param_dims.items():
            array_name = get_array_name(array_label)
            updated_arrays.add(array_name)
            for array_id in self.array_id_map.get(array_name, []):
                self.nodes[array_id].array_dims = array_dims.copy()
                self.nodes[array_id].array_num_dims = len(array_dims)
        
        out_dir = os.path.join(self.anchor_dir, ".autopilot", "db")
        if not os.path.isdir(out_dir):
            out_dir = os.path.join(self.anchor_dir, "IRs")
            if not os.path.isdir(out_dir):
                out_dir = os.path.join(self.anchor_dir, "llvm_analysis")
                os.makedirs(out_dir, exist_ok=True)

        out_path = os.path.join(out_dir, "array_profile.json")
        try:
            subprocess.check_output(
                f"opt -load {ARRAY_PROFILER_PASS_PATH} "
                f"-load-pass-plugin={ARRAY_PROFILER_PASS_PATH} "
                f"-passes=\"array-profiler\" "
                f"-array-profile-out={out_path} < {self.ir_path} > /dev/null",
                shell=True, stderr=subprocess.STDOUT
            )
        except subprocess.CalledProcessError as e:
            print(f"Error executing array profiler pass: {e}")
            raise

        with open(out_path, "r") as f:
            profiled_arrays = json.load(f)

        for array_label, array_info in profiled_arrays.items():
            array_name = get_array_name(array_label)
            if array_name in updated_arrays: continue
            updated_arrays.add(array_name)
            array_dims = array_info["Dimensions"]
            for array_id in self.array_id_map.get(array_name, []):
                self.nodes[array_id].array_dims = array_dims.copy()
                self.nodes[array_id].array_num_dims = len(array_dims)

    def _define_perfect_nests(self):
        def get_loop_id(loop_label):
            if "/" in loop_label:
                return self.loop_id_map.get(loop_label.split("/")[-1])
            return self.loop_id_map.get(loop_label)
        
        out_dir = os.path.join(self.anchor_dir, ".autopilot", "db")
        if not os.path.isdir(out_dir):
            out_dir = os.path.join(self.anchor_dir, "IRs")
            if not os.path.isdir(out_dir):
                out_dir = os.path.join(self.anchor_dir, "llvm_analysis")
                os.makedirs(out_dir, exist_ok=True)

        out_path = os.path.join(out_dir, "perfect_nests.json")
        try:
            subprocess.check_output(
                f"opt -load {PERFECT_NESTS_PASS_PATH} "
                f"-load-pass-plugin={PERFECT_NESTS_PASS_PATH} "
                f"-passes=\"extract-perfect-nests\" "
                f"-nests-out={out_path} < {self.ir_path} > /dev/null",
                shell=True, stderr=subprocess.STDOUT
            )
        except subprocess.CalledProcessError as e:
            print(f"Error executing loop nest analysis pass: {e}")
            raise

        with open(out_path, 'r') as f:
            perfect_nests = json.load(f)

        self.perfect_nests: Dict[str, List[str]] = {}
        self.top_loop_map: Dict[str, str] = {}
        for top_loop, nested_loops in perfect_nests.items():
            top = get_loop_id(top_loop)
            if top is None: continue
            self.perfect_nests[top] = []
            for nested_loop in nested_loops:
                nested = get_loop_id(nested_loop)
                if nested is None: continue
                self.perfect_nests[top].append(nested)
                self.top_loop_map[nested] = top

        for n, node in self.nodes.items():
            if not node.is_loop: continue
            if n in self.top_loop_map:
                top = self.top_loop_map[n]
                if top in self.perfect_nests:
                    if len(self.perfect_nests[top]) > 1:
                        node.features["is_part_of_perfect_nest"] = 1

    def _map_directive_targets_to_ids(self):
        self.array_id_map: Dict[str, List[str]] = {}
        self.loop_id_map: Dict[str, str] = {}
        self.function_id_map: Dict[str, str] = {}
        for node_id, node in self.nodes.items():
            if node.is_array:
                if node.tag not in self.array_id_map: 
                    self.array_id_map[node.tag] = []
                self.array_id_map[node.tag].append(node_id)
            elif node.is_loop:
                self.loop_id_map[node.tag] = node_id
            elif node.is_function:
                self.function_id_map[node.tag] = node_id

    def _create_array_access_edges(self):
        gep_mem_map = {}
        for n in self.gep_nodes:
            node = self.nodes[n]
            if len(node.operands) == 0: continue
            mem = node.operands[0]
            while mem in self.gep_nodes:
                if mem not in self.nodes: break
                if len(self.nodes[mem].operands) == 0: break
                mem = self.nodes[mem].operands[0]
            if mem not in self.gep_nodes and mem in self.nodes:
                gep_mem_map[n] = mem
        
        self._array_access_map = {}
        for n, node in self.nodes.items():
            if node.type != "op": continue
            mem = None
            if node.opcode in MEM_RW_OPS:
                if node.optype == "optype_read":
                    if len(node.operands) == 0: continue
                    ptr = node.operands[0]
                else:
                    if len(node.operands) <= 1: continue
                    ptr = node.operands[1]
                
                if ptr in self.nodes:
                    if self.nodes[ptr].type == "mem_buf":
                        self._array_access_map[n] = ptr
                    elif ptr in gep_mem_map:
                        self._array_access_map[n] = gep_mem_map[ptr]

        for node_id, node in self.nodes.items():
            if node.type != "region": continue
            for b in node.blocks:
                for op in self.nodes[b].ops:
                    if op in self._array_access_map:
                        array_id = self._array_access_map[op]
                        self.add_edge("access", array_id, node_id)
                        self.add_edge("access_rev", node_id, array_id)

    def _annotate_with_anchor(self):
        # Extract global anchor ground-truth QoR
        self.anchor_metrics = extract_metrics(self.anchor_dir)
        if any(v < 0 for v in self.anchor_metrics.values()):
            raise ValueError("Anchor instance contains invalid reports.")

        # Annotate nodes with anchor ground-truth area
        module_area_rpt = extract_per_module_area(self.anchor_dir)
        for node in self.nodes.values():
            area_dict = None
            if hasattr(node, "rtl_name"):
                if node.rtl_name and node.rtl_name in module_area_rpt:
                    area_dict = module_area_rpt[node.rtl_name]
            elif node.type == "region":
                for name in node.alt_names:
                    if name in module_area_rpt:
                        area_dict = module_area_rpt[name]
                        break
            if area_dict is not None:
                for k, v in area_dict.items():
                    if f"anchor_{k}" in node.features and v > 0:
                        node.features[f"anchor_{k}"] = v

        # Annotate with array impl info
        array_impl_rpt = extract_array_impl_info(self.anchor_dir)
        self._wr_ports_map = {}
        self._rd_ports_map = {}

        for n, node in self.nodes.items():
            if not node.is_array: continue

            if node.rtl_name in array_impl_rpt:
                impl = array_impl_rpt[node.rtl_name].lower()
                if hasattr(node, "core_type"):
                    node.core_type = impl
            else:
                if node.is_port or not node.core_type:
                    # Placeholders (true impl not found)
                    self._rd_ports_map[n] = 2
                    self._wr_ports_map[n] = 1
                    continue
                impl = node.core_type

            if impl.startswith("ram"):
                if impl.endswith("2p"):
                    node.features["2p_read"] = 1
                    rd_ports = 2
                    if impl.endswith("t2p"):
                        node.features["2p_write"] = 1
                        wr_ports = 2
                    else:
                        wr_ports = 1
                else:
                    wr_ports = 1
                    if impl.endswith("1wnr"):
                        node.features["2p_read"] = 1
                        rd_ports = 2
                    else:
                        rd_ports = 1
                node.features["is_ram"] = 1
                node.features["is_rom"] = 0

            elif "rom" in impl:
                wr_ports = 0
                if impl.endswith(("2p", "np")):
                    node.features["2p_read"] = 1
                    rd_ports = 2
                else:
                    rd_ports = 1
                node.features["is_rom"] = 1
                node.features["is_ram"] = 0

            else:  # Default fallback
                rd_ports, wr_ports = 2, 1

            self._rd_ports_map[n] = rd_ports
            self._wr_ports_map[n] = wr_ports

            if node.features["is_ram"] == 1:
                part_bitsize = node.array_size * node.bitwidth
                if part_bitsize >= LUTRAM_THRESHOLD:
                    theoretical_bram = math.ceil(part_bitsize / BRAM_18K_BITS)
                    node.features["theoretical_bram"] = theoretical_bram

    def _estimate_loop_iis(self):
        for n, node in self.nodes.items():
            if node.is_loop:
                node.features["recmii"] = self._compute_loop_recmii(n)
                node.features["resmii"] = self._compute_loop_resmii(n)

    def _compute_loop_resmii(self, loop_id):
        """
        Computes ResMII (Resource-Constrained II) by finding the maximum number
        of non-parallelizable memory accesses within an iteration of the loop.
        """
        loop_node: RegionNode = self.nodes[loop_id]

        block_counts = {b: 1 for b in loop_node.blocks_closure}
        for sub in loop_node.sub_regions_closure:
            trip_count = max(1, self.nodes[sub].trip_count)
            for b in self.nodes[sub].blocks:
                if b not in block_counts: block_counts[b] = 1
                block_counts[b] *= trip_count

        array_num_rds, array_num_wrs = {}, {}
        for b in loop_node.blocks_closure:
            count = block_counts[b]
            for op in self.nodes[b].ops:
                if op in self._array_access_map:
                    array = self._array_access_map[op]
                    if self.nodes[op].optype == "optype_write":
                        if array not in array_num_wrs:
                            array_num_wrs[array] = 0
                        array_num_wrs[array] += count
                    else:
                        if array not in array_num_rds:
                            array_num_rds[array] = 0
                        array_num_rds[array] += count

        max_resmii = 0
        for array, num_rds in array_num_rds.items():
            node = self.nodes[array]
            curr_rds = node.features.get("max_reads_in_iter", 0)
            max_rds = max(curr_rds, num_rds)
            node.features["max_reads_in_iter"] = max_rds
            ports = self._rd_ports_map.get(array, 2)
            if ports > 0:
                cycles = math.ceil(float(num_rds) / ports)
                max_resmii = max(max_resmii, cycles)

        for array, num_wrs in array_num_wrs.items():
            node = self.nodes[array]
            curr_wrs = node.features.get("max_writes_in_iter", 0)
            max_wrs = max(curr_wrs, num_wrs)
            node.features["max_writes_in_iter"] = max_wrs
            ports = self._wr_ports_map.get(array, 1)
            if ports > 0:
                cycles = math.ceil(float(num_wrs) / ports)
                max_resmii = max(max_resmii, cycles)

        return max_resmii
    
    def _compute_loop_recmii(self, loop_id):
        """
        Computes RecMII (Recurrence-Constrained II) by finding the longest 
        dependency cycle involving 'rec' edges.
        """
        loop_node: RegionNode = self.nodes[loop_id]

        # Build Adjacency and Latencies
        adj = {}
        node_latencies = {}
        for b in loop_node.blocks_closure:
            for op in self.nodes[b].ops:
                node = self.nodes[op]
                latency = node.features.get("latency", 0)
                node_latencies[op] = latency
                if op not in adj: adj[op] = []
                
        for edge in self.edges.values():
            if (edge.type[1] == "data" 
                and edge.src in adj and edge.dst in adj):
                adj[edge.src].append(edge.dst)

        # Topological sort of the loop body
        in_deg = {n: 0 for n in node_latencies}
        for u, neighbors in adj.items():
            for v in neighbors:
                if v in in_deg:
                    in_deg[v] += 1
                    
        queue = [n for n, d in in_deg.items() if d == 0]
        topo_order = []
        head = 0
        while head < len(queue):
            curr = queue[head]
            head += 1
            topo_order.append(curr)
            for nxt in adj.get(curr, []):
                if nxt in in_deg:
                    in_deg[nxt] -= 1
                    if in_deg[nxt] == 0:
                        queue.append(nxt)

        topo_index = {n: i for i, n in enumerate(topo_order)}

        # DP longest path
        def get_longest_path(start_node, target_node):
            if (start_node not in topo_index 
                or target_node not in topo_index):
                return -1
                
            start_idx = topo_index[start_node]
            target_idx = topo_index[target_node]
            if target_idx < start_idx:
                return -1
                
            dist = {n: -1 for n in node_latencies}
            dist[start_node] = node_latencies[start_node]
            for i in range(start_idx, target_idx + 1):
                curr = topo_order[i]
                if dist[curr] != -1:
                    for nxt in adj.get(curr, []):
                        lat = node_latencies.get(nxt, 0)
                        new_dist = dist[curr] + lat
                        if new_dist > dist.get(nxt, -1):
                            dist[nxt] = new_dist
            return dist.get(target_node, -1)

        max_recmii = 1
        for edge in self.edges.values():
            if edge.type[1] == "data_rec":
                u = edge.src # End of cycle (Destination of forward path)
                v = edge.dst # Start of cycle (Source of forward path)
                cycle_latency = get_longest_path(v, u)
                if cycle_latency > 0:
                    max_recmii = max(max_recmii, cycle_latency)

        return max_recmii
    

    def _annotate_op_latencies(self):
        for path in collect_bind_files(self.anchor_dir):
            module_name = path.split("/")[-1].replace(".bind.adb.xml", "")
            tree = ET.parse(path)
            root = tree.getroot()
            state_list = root.find("state_list")
            if state_list is None: continue
            for state in state_list.findall("state"):
                for operation in state.findall("operation"):
                    node = operation.find("Node")
                    lat = operation.get("lat", "")
                    if node is None or not lat.isnumeric(): continue
                    node_id = f"{module_name}.{node.get('id', '')}"
                    if node_id in self.nodes:
                        node = self.nodes[node_id]
                        if node.type == "op":
                            node.features["latency"] = max(0.0, float(lat))

        for node in self.nodes.values():
            if node.type == "block":
                max_lat = 0
                for op in node.ops:
                    if op not in self.nodes: continue
                    lat = self.nodes[op].features.get("latency", 0)
                    if lat > max_lat: max_lat = lat
                node.features["latency_max"] = max_lat

    def _define_call_flow(self):
        for caller_cdfg in self.cdfgs.values():
            for call_id, callee in caller_cdfg.function_calls.items():
                if callee in self.cdfgs and call_id in self.nodes:
                    callee_cdfg = self.cdfgs[callee]
                    callee_id = callee_cdfg.function_id
                    if call_id in caller_cdfg.op_region_map:
                        parent_id = caller_cdfg.op_region_map[call_id]
                    else:
                        parent_id = caller_cdfg.function_id
                    self.add_edge("inst", callee_id, parent_id)
                    self.add_edge("inst_rev", parent_id, callee_id)
                    self.add_edge("call", call_id, callee_id)

                    args = caller_cdfg.nodes[call_id].operands
                    ports = callee_cdfg.ports
                    n_ports = min(len(args), len(ports))
                    for i in range(n_ports):
                        arg = args[i]
                        while arg in self._trimmed_src_map:
                            arg = self._trimmed_src_map[arg]
                        if arg in self.nodes:
                            self.add_edge("arg", arg, ports[i])

                    for node_id, node in callee_cdfg.nodes.items():
                        if node.type == "op" and node.opcode == "ret":
                            self.add_edge("ret", node_id, call_id)

    def _create_bypassing_edges(self, cdfg, sources_map, targets_map):
        for bypass, targets_temp in targets_map.items():
            if bypass not in sources_map or not targets_temp: 
                continue
            queue = list(sources_map[bypass])
            visited, sources = set(), []
            while queue:
                src = queue.pop()
                if src in visited: continue
                visited.add(src)
                if src in sources_map:
                    queue.extend(list(sources_map[src]))
                else:
                    sources.append(src)

            queue = list(targets_temp)
            visited, targets = set(), []
            while queue:
                dst = queue.pop()
                if dst in visited: continue
                visited.add(dst)
                if dst in targets_map: 
                    queue.extend(list(targets_map[dst]))
                else: 
                    targets.append(dst)

            for src in sources:
                for dst in targets:
                    if (src, dst) not in self._data_flow_edges:
                        edge = cdfg.add_edge("data", src, dst)
                        self.edges[edge.id] = edge
                        self._data_flow_edges.add((src, dst))

    def _remove_trimmed_ops_subgraph(self, cdfg, trimmed_ops):
        edges_to_remove = []
        for e, edge in cdfg.edges.items():
            if edge.src in trimmed_ops or edge.dst in trimmed_ops:
                edges_to_remove.append(e)
        for n in trimmed_ops: 
            del cdfg.nodes[n]
            del self.nodes[n]
        for e in edges_to_remove:
            del cdfg.edges[e]
            del self.edges[e]

    def _trim_irrelevant_ops(self):
        self._trimmed_src_map = {}

        for cdfg in self.cdfgs.values():
            bypass_sources = {}
            for n in cdfg.nodes_to_bypass:
                node = self.nodes[n]
                if len(node.operands) == 0: continue
                bypass_sources[n] = set()
                first_op = node.operands[0]
                if first_op in cdfg.nodes:
                    bypass_sources[n].add(first_op)
                    self._trimmed_src_map[n] = first_op

            bypass_targets = {n: set() for n in bypass_sources.keys()}
            for edge in cdfg.edges.values():
                if edge.src in bypass_targets:
                    bypass_targets[edge.src].add(edge.dst)

            self._create_bypassing_edges(cdfg, bypass_sources, bypass_targets)
            self._remove_trimmed_ops_subgraph(cdfg, cdfg.nodes_to_bypass)

    def _clear_unwanted_edges(self):
        edges_to_remove = [
            e for e, edge in self.edges.items()
            if edge.type not in self.config.edge_type_set
            or edge.src not in self.nodes or edge.dst not in self.nodes
        ]
        for e in edges_to_remove: 
            del self.edges[e]

    def _add_self_loops(self):
        for n in self.nodes.keys():
            self.add_edge("self", n, n)

    def add_edge(self, relation: str, src: str, dst: str) -> Edge:
        src_type = self.nodes[src].type
        dst_type = self.nodes[dst].type
        edge_type = (src_type, relation, dst_type)
        edge = Edge(edge_type, src, dst, id_suffix=str(self._edge_counter))
        self.edges[edge.id] = edge
        self._edge_counter += 1
        return edge

    def as_dict(self):
        return {
            "benchmark_name": self.benchmark,
            "top_function": self.top_function,
            "nodes": {n: node.as_dict() for n, node in self.nodes.items()},
            "edges": [str(edge) for edge in self.edges.values()]
        }

    def save_as_json(self, filepath):
        with open(filepath, "w") as f:
            json.dump(self.as_dict(), f, indent=2)
    
    def __str__(self):
        return json.dumps(self.as_dict(), indent=2)
    
    def __repr__(self):
        return self.__str__()


# --- Helper Functions ---

def collect_adb_files(solution_dir):
    ir_dir = os.path.join(solution_dir, ".autopilot/db")
    if not os.path.exists(ir_dir):
        ir_dir = os.path.join(solution_dir, "IRs")
        if not os.path.exists(ir_dir):
            raise FileNotFoundError(f"IR directory not found in {solution_dir}")
    file_paths = []
    for file_name in os.listdir(ir_dir):
        if file_name.endswith(".adb"):
            if ".bind" in file_name or ".sched" in file_name: continue
            file_paths.append(os.path.join(ir_dir, file_name))

    return file_paths


def collect_bind_files(solution_dir):
    ir_dir = os.path.join(solution_dir, ".autopilot/db")
    if not os.path.exists(ir_dir):
        ir_dir = os.path.join(solution_dir, "IRs")
        if not os.path.exists(ir_dir):
            raise FileNotFoundError(f"IR directory not found in {solution_dir}")
    file_paths = []
    for file_name in os.listdir(ir_dir):
        if file_name.endswith(".bind.adb.xml"):
            file_paths.append(os.path.join(ir_dir, file_name))

    return file_paths


def is_array_user(array: str, op: str):
    if op.startswith(array):
        for sfx in ["_load", "_write", "_addr", "_ptr"]:
            if op.startswith(array + sfx):
                return True
    return False