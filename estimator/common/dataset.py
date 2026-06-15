import json
import math
import shutil
import pickle
from abc import ABC, abstractmethod
from pathlib import Path
from typing import Optional, List, Dict, Iterable, Union, Tuple, Set, Any

import torch
from torch_geometric.data import Dataset, HeteroData

from estimator.common.constants import BENCHMARK_INDEX_MAP
from estimator.common.graph import BaseKernelGraph


class BaseDataset(Dataset, ABC):
    def __init__(
        self,
        root: Optional[str] = None,
        benchmarks: Optional[Union[str, Iterable[str]]] = None,
        valid_indices: Optional[Iterable[int]] = None,
        **kwargs
    ):
        self.root = root or self.default_root

        if benchmarks:
            if isinstance(benchmarks, str):
                benchmarks = [benchmarks]
            self.benchmarks = set(benchmarks)
        else:
            self.benchmarks = None

        super().__init__(self.root, **kwargs)

        manifest_path = Path(self.processed_dir) / 'manifest.json'
        if not manifest_path.exists():
            raise RuntimeError("Dataset manifest not found.")
        
        with open(manifest_path, 'r') as f:
            self.manifest = json.load(f)

        if valid_indices is not None:
            self.valid_indices = list(valid_indices)
        else:
            self.valid_indices = [
                int(idx) for idx, info in self.manifest.items()
                if self.benchmarks is None or info['benchmark'] in self.benchmarks
            ]

    @property 
    @abstractmethod
    def default_root(self) -> str: 
        pass

    @property
    @abstractmethod
    def target_metrics(self) -> List[str]:
        pass

    @property
    @abstractmethod
    def node_types(self) -> List[str]:
        pass

    @property
    @abstractmethod
    def edge_types(self) -> List[Tuple[str, str, str]]:
        pass

    @property
    @abstractmethod
    def node_dim_dict(self) -> Dict[str, int]:
        pass

    @property
    @abstractmethod
    def features_to_log_scale(self) -> Set[str]:
        pass

    @property
    @abstractmethod
    def directive_feature_index_map(self) -> Dict[str, Dict[str, int]]:
        pass

    @property
    @abstractmethod
    def use_log1p(self) -> bool:
        pass

    @property
    def raw_file_names(self):
        return []
    
    @property
    def processed_file_names(self):
        return ['manifest.json']

    def len(self):
        return len(self.valid_indices)

    def get(self, idx):
        real_idx = self.valid_indices[idx]
        return torch.load(
            Path(self.processed_dir) / f'data_{real_idx}.pt',
            weights_only=False
        )
    
    def process(self):
        raw_dir = Path(self.raw_dir)
        if not raw_dir.is_dir():
            raise FileNotFoundError("Raw dataset directory not found.")
        
        processed_dir = Path(self.processed_dir)
        if processed_dir.is_dir():
            shutil.rmtree(processed_dir)
        processed_dir.mkdir()

        idx = 0
        manifest = {}

        for bench_dir in raw_dir.iterdir():
            bench = bench_dir.name
            anchor_path = bench_dir / 'anchor_graph.pkl'
            if (not bench_dir.is_dir() or bench not in BENCHMARK_INDEX_MAP
                or not anchor_path.exists()):
                continue

            with open(anchor_path, 'rb') as f:
                graph: BaseKernelGraph = pickle.load(f)

            if any(graph.anchor_metrics.get(m, -1) < 0 for m in self.target_metrics):
                continue

            data = self.initialize_data(graph)

            for sol_dir in bench_dir.iterdir():
                sol_name = sol_dir.name
                if not sol_dir.is_dir() or not sol_name.startswith('solution'):
                    continue

                dct_path = sol_dir / 'directive_features.json'
                metrics_path = sol_dir / 'metrics.json'
                if not dct_path.exists() or not metrics_path.exists():
                    continue

                with open(metrics_path, 'r') as f:
                    target_dict = json.load(f)

                target_dict = {m: target_dict.get(m, -1) for m in self.target_metrics}
                if any(v < 0 for v in target_dict.values()):
                    continue

                with open(dct_path, 'r') as f:
                    dct_feats = json.load(f)

                sol_idx = int(sol_name.split('solution')[-1])
                data_path = processed_dir / f'data_{idx}.pt'

                self.update_data(data, graph, dct_feats, target_dict, sol_idx, data_path)

                manifest[idx] = {'benchmark': bench, 'sol_idx': sol_idx}
                idx += 1

        with open(processed_dir / 'manifest.json', 'w') as f:
            json.dump(manifest, f)
                
        print(f"Processing complete. Saved {idx} samples.")

    def initialize_data(self, graph: BaseKernelGraph) -> HeteroData:
        x_dict = {nt: [] for nt in self.node_types}
        for n in graph.sorted_node_ids:
            node = graph.nodes[n]
            x_dict[node.type].append(node.get_feature_tensor())

        edge_index_dict = {et: [] for et in self.edge_types}
        for edge in graph.edges.values():
            src = graph.node_index_map.get(edge.type[0], {}).get(edge.src)
            dst = graph.node_index_map.get(edge.type[2], {}).get(edge.dst)
            if src is not None and dst is not None:
                edge_index_dict[edge.type].append((src, dst))

        data = HeteroData()
        for nt, x in x_dict.items():
            if len(x) > 0:
                data[nt].x = torch.stack(x, dim=0)
            else:
                data[nt].x = torch.empty((0, self.node_dim_dict[nt]))

        for et, edge_index in edge_index_dict.items():
            if len(edge_index) > 0:
                src, dst = zip(*edge_index)
                src = torch.tensor(src, dtype=torch.long)
                dst = torch.tensor(dst, dtype=torch.long)
                data[et].edge_index = torch.stack([src, dst], dim=0)
            else:
                data[et].edge_index = torch.empty((2, 0), dtype=torch.long)

        log_anchor = []
        for m in self.target_metrics:
            v = float(graph.anchor_metrics[m])
            v = math.log1p(v) if self.use_log1p else math.log(v)
            log_anchor.append(v)

        data.y_anchor = torch.tensor(log_anchor, dtype=torch.float32).unsqueeze(0)

        data.benchmark = graph.benchmark
        data.benchmark_index = torch.tensor(
            BENCHMARK_INDEX_MAP[graph.benchmark], 
            dtype=torch.long
        ).unsqueeze(0)

        return data

    def update_data(
        self,
        data: HeteroData,
        graph: Any,
        directive_features: Dict[str, Dict[str, float]],
        target_dict: Dict[str, float],
        solution: int,
        output_path: Optional[str] = None
    ) -> HeteroData:
        new_data = data.clone()
        for n, feats in directive_features.items():
            if n not in graph.nodes: continue
            nt = graph.nodes[n].type
            feat_index_map = self.directive_feature_index_map[nt]
            i = graph.node_index_map[nt][n]
            for k, v in feats.items():
                if k not in feat_index_map: continue
                j = feat_index_map[k]
                v = float(v)
                if k in self.features_to_log_scale: 
                    v = math.log1p(v)
                new_data[nt].x[i, j] = v

        y_list, y_abs_list = [], []
        for i, m in enumerate(self.target_metrics):
            target = float(target_dict[m])
            log_target = math.log1p(target) if self.use_log1p else math.log(target)
            log_delta_target = log_target - new_data.y_anchor[0, i].item()
            y_list.append(log_delta_target)
            y_abs_list.append(target)

        new_data.y = torch.tensor(y_list, dtype=torch.float32).unsqueeze(0)
        new_data.y_abs = torch.tensor(y_abs_list, dtype=torch.float32).unsqueeze(0)
        new_data.solution = solution

        if output_path is not None:
            torch.save(new_data, output_path)

        return new_data

    def preprocess_data(
        self,
        graph: BaseKernelGraph,
        target_dict: Dict[str, float],
        solution: int
    ) -> HeteroData:
        data = self.initialize_data(graph)

        y_list, y_abs_list = [], []
        for i, m in enumerate(self.target_metrics):
            target = float(target_dict[m])
            log_target = math.log1p(target) if self.use_log1p else math.log(target)
            log_delta_target = log_target - data.y_anchor[0, i].item()
            y_list.append(log_delta_target)
            y_abs_list.append(target)

        data.y = torch.tensor(y_list, dtype=torch.float32).unsqueeze(0)
        data.y_abs = torch.tensor(y_abs_list, dtype=torch.float32).unsqueeze(0)
        data.solution = solution
        return data