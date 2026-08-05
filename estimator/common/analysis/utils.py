import os
import json
from typing import Optional, Union, Tuple

import numpy as np
import pandas as pd
from numpy.typing import NDArray
from sklearn.decomposition import PCA
from sklearn.cluster import KMeans, AgglomerativeClustering
from sklearn.metrics import silhouette_score, davies_bouldin_score, calinski_harabasz_score

from estimator.common.parsers import parse_directive_command, extract_metrics


def cluster_by_directive(
    encoded_directives: NDArray[np.int_],
    n_clusters: int = 8,
    max_iter: int = 1000,
    cluster_method: str = 'kmeans',
    n_components: Union[int, float] = 0.9,
    hardware_targets: Optional[NDArray[np.float_]] = None,
    log_scale: bool = True
) -> NDArray[np.int_]:
    if encoded_directives.ndim > 2:
        encoded_directives = encoded_directives.reshape(encoded_directives.shape[0], -1)

    if hardware_targets is not None:
        if log_scale:
            hardware_targets = np.log1p(hardware_targets)
        encoded_directives = np.append(encoded_directives, hardware_targets, axis=1)

    pca = PCA(n_components=n_components)
    encoded_directives = pca.fit_transform(encoded_directives)

    if cluster_method == 'kmeans':
        model = KMeans(
            n_clusters=n_clusters, 
            max_iter=max_iter, 
            n_init=20, 
            tol=1e-8
        )
    elif cluster_method == 'aggl':
        model = AgglomerativeClustering(n_clusters=n_clusters)
    else:
        raise ValueError(f"Unknown clustering method: {cluster_method}")
    
    clusters = model.fit_predict(encoded_directives)
    
    if len(np.unique(clusters)) > 1:
        sil_score = silhouette_score(encoded_directives, clusters)
        db_score = davies_bouldin_score(encoded_directives, clusters)
        ch_score = calinski_harabasz_score(encoded_directives, clusters)
        print(f'Silhouette score: {sil_score:.2f}')
        print(f'Davies-Bouldin score: {db_score:.2f}')
        print(f'Calinski-Harabasz score: {ch_score:.2f}')

    return clusters


def collate_data_for_analysis(
    dataset_dir: str, 
    benchmark: str, 
    directives_config_path: Optional[str] = None,
    include_anchor_solution: bool = False
) -> Tuple[pd.DataFrame, Optional[NDArray[np.int_]]]:
    reports = []
    directives = [] if directives_config_path else None

    bench_dir = f"{dataset_dir}/{benchmark}"
    solutions = [d for d in os.listdir(bench_dir) if d.startswith('solution')]
    solutions = sorted(solutions, key=lambda s: int(s.split("solution")[1]))

    for sol in solutions:
        if not include_anchor_solution and sol == 'solution0':
            continue

        sol_dir = os.path.join(bench_dir, sol)
        report = extract_metrics(sol_dir)
        if report is None or any(v < 0 for v in report.values()):
            continue

        report['benchmark'] = benchmark
        report['solution'] = int(sol.split("solution")[1].strip())
        reports.append(report)

        if directives_config_path is not None:
            tcl_path = f'{sol_dir}/directives.tcl'
            directives.append(encode_directives_for_clustering(directives_config_path, tcl_path))
            
    if directives is not None:
        directives = np.stack(directives)

    return pd.DataFrame(reports), directives


def encode_directives_for_clustering(dct_config_path: str, dct_tcl_path: str) -> NDArray[np.int_]:
    if not os.path.exists(dct_tcl_path):
        raise ValueError(f"Directives file not found: {dct_tcl_path}")
    if not os.path.exists(dct_config_path):
        raise ValueError(f"Directive configuration file not found: {dct_config_path}")
    
    def dct_to_key(dct_type, dct_args):
        if dct_type == "array_partition":
            ap_type = dct_args.get("type", "")
            ap_dim = dct_args.get("dim", "")
            factor = dct_args.get("factor", "")
            return (ap_type, ap_dim, factor)
        elif dct_type == "unroll":
            factor = dct_args.get("factor", "")
            return (factor,)
        else:
            return (1,)

    with open(dct_config_path, "r") as f:
        dct_json = json.load(f)
    
    dct_dict = dct_json.get("directives")
    if dct_dict is None:
        raise ValueError(f"Directives not found in {dct_config_path}")

    dct_group_map = {}
    dct_config_map = {}
    group_size_map = {}
    n_groups = 0
    for group in dct_dict.values():
        possible_dcts = group.get("possible_directives")
        if possible_dcts is None or len(possible_dcts) == 0:
            continue
        
        dct_type = group.get("directive_type")
        if dct_type == "array_partition":
            label = group.get("variable")
        else:
            label = group.get("label")
            if not label:
                label = group.get("function")

        dct_group_map[(dct_type, label)] = n_groups
        group_size_map[n_groups] = len(possible_dcts)
        group_dct_config_map = {}

        for i, dct_cmd in enumerate(possible_dcts):
            if not dct_cmd or '-off' in dct_cmd:
                continue
            _, dct_args = parse_directive_command(dct_cmd)
            key = dct_to_key(dct_type, dct_args)
            group_dct_config_map[key] = i  # Store index of directive in config

        dct_config_map[n_groups] = group_dct_config_map
        n_groups += 1

    with open(dct_tcl_path, "r") as f:
        dct_lines = f.readlines()

    encoded_dcts = [[0] * size for size in group_size_map.values()]
    for line in dct_lines:
        if line.startswith('set_directive_') and not line.startswith('set_directive_top'):
            dct_type, dct_args = parse_directive_command(line)
            if dct_type == "array_partition":
                label = dct_args.get("variable", "")
            else:
                label = dct_args.get("location", "")
            if (dct_type, label) not in dct_group_map:
                continue
            group_id = dct_group_map[(dct_type, label)]
            key = dct_to_key(dct_type, dct_args)
            config_map = dct_config_map[group_id]
            if "-off" in line:
                encoded_dcts[group_id][0] = 1
            elif key in config_map:
                index = config_map[key]
                encoded_dcts[group_id][index] = 1

    encoded_dcts = np.concatenate(encoded_dcts).astype(np.int_)
    return encoded_dcts