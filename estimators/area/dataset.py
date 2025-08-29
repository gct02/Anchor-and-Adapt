import os
import torch
import shutil
import json
import pickle
import math
import copy
from collections import defaultdict
from typing import Union, Optional, List, Dict

import numpy as np

from torch_geometric.data import Dataset, HeteroData

from estimators.common.parsers import AREA_METRICS
from estimators.area.graph import (
    NODE_TYPES,
    EDGE_TYPES,
    NODE_DIM_DICT,
    NO_LOG_SCALING_KEYS,
    NO_LOG_SCALING_GRAPH_KEYS,
    KernelGraph,
    compute_scaling_stats,
    compute_graph_attr_scaling_stats
)

NUM_TARGETS = len(AREA_METRICS)

StatsDict = Dict[str, Dict[str, float]]


class HLSDataset(Dataset):
    def __init__(
        self, 
        root: str = "estimators/area/dataset", 
        mode: str = "train",
        benchmarks: Optional[Union[str, List[str]]] = None,
        scaling_stats: Optional[StatsDict] = None,
        graph_attr_scaling_stats: Optional[StatsDict] = None,
        target_scaling_stats: Optional[StatsDict] = None,
        **kwargs
    ):
        self.full_dataset_dir = os.path.join(root, "full")
        self.root = os.path.join(root, mode)

        if not benchmarks:
            benchmarks = sorted(os.listdir(self.full_dataset_dir))
        elif not isinstance(benchmarks, list):
            benchmarks = [benchmarks]

        self.benchmarks = []
        base_graphs = {}

        # Filter out unavailable benchmarks
        for benchmark in benchmarks:
            benchmark_dir = os.path.join(self.full_dataset_dir, benchmark)
            if not os.path.isdir(benchmark_dir):
                print(f"Skipping {benchmark} (directory not found)")
                continue

            metrics_path = os.path.join(benchmark_dir, "base_metrics.json")
            if not os.path.exists(metrics_path):
                print(f"Skipping {benchmark} (base metrics file not found)")
                continue

            graph_path = os.path.join(benchmark_dir, "base_graph.pkl")
            if not os.path.exists(graph_path):
                print(f"Skipping {benchmark} (kernel info file not found)")
                continue

            with open(metrics_path, 'r') as f:
                metrics = json.load(f)

            if any(metrics.get(key, -1) < 0 for key in AREA_METRICS):
                print(f"Skipping {benchmark} (missing metrics in base solution)")
                continue

            with open(graph_path, 'rb') as f:
                base_graphs[benchmark] = pickle.load(f)

            self.benchmarks.append(benchmark)

        if not scaling_stats:
            self.scaling_stats = compute_scaling_stats(
                self.full_dataset_dir, benchmarks=self.benchmarks
            )
        else:
            self.scaling_stats = copy.deepcopy(scaling_stats)

        if not graph_attr_scaling_stats:
            self.graph_attr_scaling_stats = compute_graph_attr_scaling_stats(
                self.full_dataset_dir, benchmarks=self.benchmarks
            )
        else:
            self.graph_attr_scaling_stats = copy.deepcopy(graph_attr_scaling_stats)

        if not target_scaling_stats:
            self.target_scaling_stats = compute_target_scaling_stats(
                self.full_dataset_dir, benchmarks=self.benchmarks
            )
        else:
            self.target_scaling_stats = copy.deepcopy(target_scaling_stats)

        self._raw_file_names = []
        self._processed_file_names = []

        super(HLSDataset, self).__init__(self.root, **kwargs)
    
    @property
    def raw_file_names(self):
        return self._raw_file_names
    
    @property
    def processed_file_names(self):
        return self._processed_file_names
    
    def download(self):
        if not os.path.exists(self.full_dataset_dir):
            raise FileNotFoundError(
                f"Directory {self.full_dataset_dir} does not exist."
            )
        if os.path.exists(self.raw_dir):
            shutil.rmtree(self.raw_dir)
        os.makedirs(self.raw_dir)
            
        for bench in self.benchmarks:
            src = os.path.join(self.full_dataset_dir, bench)
            dst = os.path.join(self.raw_dir, bench)
            shutil.copytree(src, dst)
    
    def process(self):
        if not os.path.exists(self.raw_dir):
            raise FileNotFoundError(
                f"Raw dataset directory {self.raw_dir} does not exist."
            )
        if os.path.exists(self.processed_dir):
            shutil.rmtree(self.processed_dir)
        os.makedirs(self.processed_dir)

        solution_dict = defaultdict(dict)
        for benchmark in self.benchmarks:
            benchmark_dir = os.path.join(self.raw_dir, benchmark)
            for solution in os.listdir(benchmark_dir):
                solution_dir = os.path.join(benchmark_dir, solution)
                if (not os.path.isdir(solution_dir) or 
                    not solution.startswith("solution")):
                    continue
                idx = int(solution.split("solution")[1])
                solution_dict[idx][benchmark] = solution_dir

        for idx in sorted(solution_dict.keys()):
            solution_dirs = solution_dict[idx]
            if len(solution_dirs) == 0:
                print(f"Skipping {idx} (no solution directories found)")
                continue

            for benchmark, solution_dir in solution_dirs.items():
                graph_path = os.path.join(solution_dir, "graph.pkl")
                if not os.path.exists(graph_path):
                    print(f"Skipping {idx} (kernel info file not found)")
                    continue

                metrics_path = os.path.join(solution_dir, "metrics.json")
                if not os.path.exists(metrics_path):
                    print(f"Skipping {idx} (metrics file not found)")
                    continue

                with open(metrics_path, 'r') as f:
                    metrics = json.load(f)

                if any(metrics.get(key, -1) < 0 for key in AREA_METRICS):
                    print(f"Skipping {idx} (missing metrics)")
                    continue

                original_target = []
                target = []
                for key in AREA_METRICS:
                    mean = self.target_scaling_stats[key]['mean']
                    std = self.target_scaling_stats[key]['std']
                    value = float(metrics[key])
                    original_target.append(value)
                    target.append((math.log1p(value) - mean) / std)

                original_target = torch.tensor(original_target, dtype=torch.float32).unsqueeze(0)
                target = torch.tensor(target, dtype=torch.float32).unsqueeze(0)

                with open(graph_path, 'rb') as f:
                    graph = pickle.load(f)

                self._standardize_features(graph)

                graph_attr_dict = graph.graph_attr
                graph_attr = []
                for key, value in graph_attr_dict.items():
                    if key in self.graph_attr_scaling_stats:
                        mean = self.graph_attr_scaling_stats[key]['mean']
                        std = self.graph_attr_scaling_stats[key]['std']
                        if key not in NO_LOG_SCALING_GRAPH_KEYS:
                            value = math.log1p(float(value))
                        graph_attr.append((float(value) - mean) / std)
                    else:
                        graph_attr.append(float(value))

                graph_attr = torch.tensor(graph_attr, dtype=torch.float32).unsqueeze(0)

                connected_nodes = set()
                for edge in graph.edges.values():
                    connected_nodes.add(edge.src)
                    connected_nodes.add(edge.dst)

                node_id_map = {ntype: {} for ntype in NODE_TYPES}
                ncount = {ntype: 0 for ntype in NODE_TYPES}
                for node_id, node in graph.nodes.items():
                    if node_id in connected_nodes:
                        node_id_map[node.node_type][node_id] = ncount[node.node_type]
                        ncount[node.node_type] += 1

                edge_index_dict = {etype: [] for etype in EDGE_TYPES}
                for edge in graph.edges.values():
                    src_idx = node_id_map.get(edge.src_type, {}).get(edge.src)
                    dst_idx = node_id_map.get(edge.dst_type, {}).get(edge.dst)
                    etype = (edge.src_type, edge.etype, edge.dst_type)
                    if src_idx is not None and dst_idx is not None:
                        edge_index_dict[etype].append((src_idx, dst_idx))

                # Add self-loops
                for ntype, id_map in node_id_map.items():
                    for node_id, node_idx in id_map.items():
                        etype = (ntype, 'self', ntype)
                        edge_index_dict[etype].append((node_idx, node_idx))

                x_dict = {ntype: [None] * len(node_id_map[ntype]) for ntype in NODE_TYPES}
                for node_id, node in graph.nodes.items():
                    if node_id in connected_nodes:
                        x_dict[node.node_type][node_id_map[node.node_type][node_id]] = node.get_feature_tensor()
                        
                x_dict = {ntype: [x for x in xs if x is not None] for ntype, xs in x_dict.items()}
                x_dict = {
                    ntype: torch.stack(xs, dim=0) if len(xs) > 0 else torch.empty((0, NODE_DIM_DICT[ntype]))
                    for ntype, xs in x_dict.items()
                }

                data = HeteroData()
                for ntype, x in x_dict.items():
                    data[ntype].x = x

                for et in EDGE_TYPES:
                    edges = edge_index_dict.get(et)
                    if edges:
                        src, dst = zip(*edges)
                        src = torch.tensor(src, dtype=torch.long)
                        dst = torch.tensor(dst, dtype=torch.long)
                        data[et].edge_index = torch.stack([src, dst], dim=0)
                    else:
                        data[et].edge_index = torch.empty((2, 0), dtype=torch.long)
                    
                data.graph_attr = graph_attr
                data.y = target
                data.original_y = original_target
                data.benchmark = benchmark
                data.solution_index = idx

                output_path = os.path.join(self.processed_dir, f"{benchmark}_{idx}.pt")
                torch.save(data, output_path)

                self._processed_file_names.append(f"{benchmark}_{idx}.pt")
                self._raw_file_names.append(
                    (f"{benchmark}/{idx}/graph.pt", f"{benchmark}/{idx}/metrics.txt")
                )

    def len(self):
        return len(self.processed_paths)

    def get(self, ind):
        data = torch.load(self.processed_paths[ind], weights_only=False)
        return data 
    
    def _standardize_features(self, kernel_info: KernelGraph):
        def log_transform(value):
            if isinstance(value, (list, tuple)):
                return [math.log1p(float(v)) for v in value]
            return math.log1p(float(value))
            
        def scale(value, mean, std):
            if isinstance(value, (list, tuple)):
                return [(float(v) - mean) / std for v in value]
            return (float(value) - mean) / std
            
        for node in kernel_info.nodes.values():
            for key, value in node.feature_dict.items():
                if key in self.scaling_stats:
                    mean = self.scaling_stats[key]['mean']
                    std = self.scaling_stats[key]['std']
                    if key not in NO_LOG_SCALING_KEYS:
                        value = log_transform(value)
                    node.feature_dict[key] = scale(value, mean, std)


def compute_target_scaling_stats(
    dataset_dir: str,
    benchmarks: Optional[Union[str, List[str]]] = None,
    log_transform: bool = True
) -> StatsDict:
    targets = {key: [] for key in AREA_METRICS}

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

            metrics_path = os.path.join(sol_dir, "metrics.json")
            if not os.path.exists(metrics_path):
                print(f"Skipping {sol} (metrics file not found)")
                continue

            with open(metrics_path, 'r') as f:
                metrics = json.load(f)

            if any(metrics.get(key, -1) < 0 for key in AREA_METRICS):
                print(f"Skipping {sol} (missing metrics in solution)")
                continue

            for key in AREA_METRICS:
                targets[key].append(float(metrics[key]))

    scaling_stats = {}
    for key in AREA_METRICS:
        if key not in targets or not targets[key]:
            scaling_stats[key] = {'mean': 0.0, 'std': 1.0}
        else:
            values = np.array(targets[key], dtype=np.float64)
            if log_transform:
                values = np.log1p(values)
            mean = np.mean(values)
            std = np.std(values)
            if std < 1e-8:
                std = 1.0
            scaling_stats[key] = {'mean': mean, 'std': std}

    return scaling_stats
