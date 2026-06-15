import json
import shutil
from pathlib import Path
from typing import Dict, Any

import numpy as np
import torch
from sklearn.decomposition import PCA
from sklearn.cluster import KMeans

from estimator.mtl.models import MultiTaskModel
from estimator.mtl.train import prepare_loader, set_random_seeds

DEVICE = torch.device('cuda:0' if torch.cuda.is_available() else 'cpu')


def cluster_solutions(model, loader, last_base_idx, n_base, n_complex, seed=42):
    emb_list_base, emb_list_complex = [], []
    idx_list_base, idx_list_complex = [], []

    model.eval()
    with torch.no_grad():
        for data in loader:
            data = data.to(DEVICE)
            _, emb = model(
                x_dict=data.x_dict, 
                edge_index_dict=data.edge_index_dict, 
                y_anchor=data.y_anchor,
                batch_dict=data.batch_dict,
                batch_size=data.num_graphs,
                return_embedding=True
            )
            for i in range(data.solution.size(0)):
                sol_idx = data.solution[i].item()
                if sol_idx > last_base_idx:
                    emb_list_complex.append(emb[i].view(1, -1).detach().cpu().numpy())
                    idx_list_complex.append(sol_idx)
                else:
                    emb_list_base.append(emb[i].view(1, -1).detach().cpu().numpy())
                    idx_list_base.append(sol_idx)

    X_emb_base = np.concatenate(emb_list_base, axis=0)
    X_emb_complex = np.concatenate(emb_list_complex, axis=0)

    pca_base = PCA(n_components=0.9)
    pca_complex = PCA(n_components=0.9)

    X_pca_base = pca_base.fit_transform(X_emb_base)
    X_pca_complex = pca_complex.fit_transform(X_emb_complex)

    model_base = KMeans(n_clusters=max(1, n_base), random_state=seed, n_init=10)
    model_complex = KMeans(n_clusters=max(1, n_complex), random_state=seed, n_init=10)

    clusters_base = model_base.fit_predict(X_pca_base)
    clusters_complex = model_complex.fit_predict(X_pca_complex)

    closest_indices_base = {}
    for cluster_id in range(model_base.n_clusters):
        indices = np.where(clusters_base == cluster_id)[0]
        center = model_base.cluster_centers_[cluster_id]
        closest = np.argmin(
            np.linalg.norm(X_pca_base[indices] - center, axis=1)
        )
        closest_indices_base[cluster_id] = idx_list_base[indices[closest]]

    closest_indices_complex = {}
    for cluster_id in range(model_complex.n_clusters):
        indices = np.where(clusters_complex == cluster_id)[0]
        center = model_complex.cluster_centers_[cluster_id]
        closest = np.argmin(
            np.linalg.norm(X_pca_complex[indices] - center, axis=1)
        )
        closest_indices_complex[cluster_id] = idx_list_complex[indices[closest]]

    return (
        list(closest_indices_base.values())[:n_base], 
        list(closest_indices_complex.values())[:n_complex]
    )


if __name__ == '__main__':
    import argparse

    def parse_arguments() -> Dict[str, Any]:
        parser = argparse.ArgumentParser(description='Sample solutions for fine-tuning.')
        parser.add_argument('benchmark', type=str,
                            help='Name of the target benchmark.')
        parser.add_argument('-t', '--target-metric', type=str, required=True,
                            help='The metric to specialize with fine-tuning.')
        parser.add_argument('-b', '--batch-size', type=int, default=32, 
                            help='The batch size for inference. Default: 32.')
        parser.add_argument('--num-base', type=int, default=5,
                            help='Number of base (single directive) solutions to sample. Default: 5.')
        parser.add_argument('--num-complex', type=int, default=4,
                            help='Number of complex (multiple directives) solutions to sample. Default: 4.')
        return vars(parser.parse_args())
    
    args = parse_arguments()
    benchmark = args['benchmark']
    target_metric = args['target_metric']
    n_base = args['num_base']
    n_complex = args['num_complex']
    batch_size = args['batch_size']

    output_dir_base = Path("estimator/common/fine_tuning/samples") / target_metric
    output_dir = (output_dir_base / "dataset/raw") / benchmark
    output_dir.mkdir(parents=True, exist_ok=True) 

    model_dir = Path('estimator/mtl/models') / benchmark

    with open(model_dir / 'training_args.json', 'r') as f:
        train_args = json.load(f)

    dataset_dir = Path(train_args['dataset_dir'])
    seed = train_args['seed']

    set_random_seeds(seed)

    model_path = model_dir / 'model_1.pt'

    model = MultiTaskModel(
        hidden_dim=train_args['hidden_dim'],
        num_layers_micro=train_args['num_layers_micro'],
        num_layers_macro=train_args['num_layers_macro'],
        heads=train_args['heads'],
        dropout=train_args['dropout']
    )
    model.load_state_dict(torch.load(
        model_path, map_location=DEVICE, weights_only=False
    ))
    model.to(DEVICE)

    loader = prepare_loader(
        dataset_dir, benchmark, balanced=False,
        batch_size=batch_size, shuffle=False, drop_last=False
    )

    with open('data/benchmark_info.json', 'r') as f:
        bench_info_dict = json.load(f)

    last_base = bench_info_dict[benchmark]['last_base_index']

    indices_base, indices_complex = cluster_solutions(
        model, loader, last_base, n_base, n_complex, seed=seed
    )
    selected_solutions = indices_base + indices_complex

    source_dataset_dir = Path(f"estimator/{target_metric}/dataset/raw/{benchmark}")
    selected_solutions_final = []

    # Copy selected solutions to output directory
    for sol_idx in selected_solutions:
        source_dir = source_dataset_dir / f'solution{sol_idx}'
        if source_dir.is_dir():
            target_dir = output_dir / f'solution{sol_idx}'
            if target_dir.exists(): 
                shutil.rmtree(target_dir)
            shutil.copytree(source_dir, target_dir)
            selected_solutions_final.append(sol_idx)

    solutions_txt = ",".join(list(map(str, selected_solutions_final)))
    with open(output_dir_base / "solutions.txt", "w") as f:
        f.write(solutions_txt)

    shutil.copy2(source_dataset_dir / 'anchor_graph.pkl', output_dir / 'anchor_graph.pkl')
    shutil.copy2(source_dataset_dir / 'anchor_metrics.json', output_dir / 'anchor_metrics.json')
