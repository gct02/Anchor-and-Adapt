import os
import json
from argparse import ArgumentParser
from typing import Optional, Union

import numpy as np
import pandas as pd
import sklearn
import matplotlib.pyplot as plt
from numpy.typing import NDArray

from estimators.common.analysis_utils import (
    cluster_by_directive,
    collate_data_for_analysis
)


def generate_metrics_plot(
    metrics: pd.DataFrame,
    benchmark: str,
    x_metric: str,
    y_metric: str, 
    directives: Optional[NDArray[np.int_]] = None,
    output_dir: Optional[str] = None,
    n_clusters: int = 8,
    cluster_method: str = 'kmeans',
    n_components: Union[int, float] = 0.85
):
    plt.figure(figsize=(10, 6), dpi=150)

    metrics = metrics.copy()
    metrics[x_metric] = metrics[x_metric].astype(float)
    metrics[y_metric] = metrics[y_metric].astype(float)
    metrics = metrics.dropna(subset=[x_metric, y_metric])
    metrics = metrics[(metrics[x_metric] >= 0) & (metrics[y_metric] >= 0)]

    if directives is not None:
        if len(directives) != len(metrics):
            raise ValueError("Number of directives must match number of metric entries.")
        
        design_metrics = metrics[x_metric].to_numpy()
        design_metrics = np.append(
            design_metrics.reshape(-1, 1), 
            metrics[y_metric].to_numpy().reshape(-1, 1), axis=1
        )
        
        clusters = cluster_by_directive(
            directives, n_clusters, 
            cluster_method=cluster_method, 
            n_components=n_components
        )
        n_clusters = len(np.unique(clusters))

        output_file = f'{output_dir}/{benchmark}_{x_metric}_{y_metric}_clusters.json'
        output_data = {}

        for i in range(n_clusters):
            cluster_solutions = metrics[clusters == i]["solution"].tolist()
            solution_indices = []
            for solution in cluster_solutions:
                solution_indices.append(int(solution.split("solution")[1].strip()))
            output_data[f"Cluster {i}"] = solution_indices
            
        with open(output_file, 'w') as f:
            json.dump(output_data, f, indent=2)

        cmap = plt.get_cmap('viridis')
        colors = cmap(np.linspace(0, 1, n_clusters))
        for i in range(n_clusters):
            cluster_data = metrics.loc[clusters == i]
            plt.scatter(
                cluster_data[x_metric], cluster_data[y_metric],
                color=colors[i], label=f'Cluster {i}',
                edgecolors="white", linewidth=0.7, alpha=0.6, s=60
            )
        
        plt.legend()
    else:
        plt.scatter(
            metrics[x_metric], metrics[y_metric], 
            c='blue', alpha=0.6, edgecolors='black', s=60
        )
        
    plt.xlabel(x_metric.replace('_', ' ').title(), fontsize=14)
    plt.ylabel(y_metric.replace('_', ' ').title(), fontsize=14)
    plt.title(f'{benchmark}: {x_metric} vs {y_metric}\n', fontsize=16, pad=20)
    plt.grid(True, linestyle="--", linewidth=0.5, alpha=0.5)
    plt.tight_layout()

    if output_dir:
        output_file = f'{output_dir}/{benchmark}_{x_metric}_{y_metric}.png'
        plt.savefig(output_file, bbox_inches='tight', dpi=150, transparent=True)
    else:
        plt.show()
    
    plt.close()


def parse_args():
    parser = ArgumentParser()
    parser.add_argument('-d', '--dataset-dir', required=True,
                        help='Path to the dataset directory')
    parser.add_argument('-b', '--benchmark-name', required=True,
                        help='The name of the benchmark to analyze')
    parser.add_argument('-o', '--output-dir', required=False, default=None, 
                        help='Path to the output directory')
    parser.add_argument('-dc', '--directive-config', required=False, default=None,
                        help='Path to the file containing the available directive configurations')
    parser.add_argument('-x', '--x-data', required=False, default='lut',
                        help='X axis data (default: "lut")')
    parser.add_argument('-y', '--y-data', required=False, default='time',
                        help='Y axis data (default: "time")')
    parser.add_argument('-s', '--seed', required=False, default=42,
                        help='Random seed for clustering (default: 42)')
    parser.add_argument('-c', '--num-clusters', required=False, default=8,
                        help='Number of clusters to group solutions (default: 8)')
    parser.add_argument('-cm', '--cluster-method', choices=['kmeans', 'aggl'], default='kmeans',
                        help='Clustering method (default: kmeans)')
    parser.add_argument('-f', '--filtered', required=False, action='store_true', default=False,
                        help='Sinalize if the dataset is filtered (default: False)')
    parser.add_argument('-pc', '--principal-components', required=False, default=0.85,
                        help='Number of principal components for PCA (default: 0.85)')
    return parser.parse_args()


def main(args):
    dataset_dir = args.dataset_dir
    benchmark = args.benchmark_name
    directive_config_path = args.directive_config
    x_data = args.x_data
    y_data = args.y_data
    output_dir = args.output_dir
    filtered = args.filtered
    cluster_method = args.cluster_method
    n_clusters = int(args.num_clusters)
    seed = int(args.seed)
    principal_components = float(args.principal_components)

    if principal_components >= 1.0:
        principal_components = int(principal_components)

    benchmark_path = f'{dataset_dir}/{benchmark}'
    if not os.path.exists(benchmark_path):
        raise FileNotFoundError(f"Benchmark path {benchmark_path} does not exist.")

    np.random.seed(seed)
    sklearn.random.seed(seed)

    if directive_config_path is not None:
        if not os.path.exists(directive_config_path):
            raise FileNotFoundError(
                f"Directive config file {directive_config_path} does not exist."
            )

    if output_dir is not None:
        if not os.path.exists(output_dir):
            os.makedirs(output_dir)

    metrics, directives = collate_data_for_analysis(
        dataset_dir, benchmark, filtered=filtered,
        dct_config_path=directive_config_path
    )
    generate_metrics_plot(
        metrics, benchmark, x_data, y_data, directives=directives,
        output_dir=output_dir, n_clusters=n_clusters, 
        cluster_method=cluster_method, n_components=principal_components
    )


if __name__ == '__main__':
    args = parse_args()
    main(args)