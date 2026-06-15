from pathlib import Path

import matplotlib.pyplot as plt
import torch

from estimator.common.metrics import mape_loss

plt.rcParams.update({'font.size': 12})

our_model_dir = "estimators/area/models"
harp_model_dir = "baselines/HARP/models"
hgp_model_dir = "baselines/HGBO-DSE/new_model"

our_zero_cost_mapes = []
our_ft_mapes = []
harp_mapes = []
hgp_mapes = []

# Computed from our dataset (with analyze_hls_estimates.py)
vitis_hls_mape = 1.3781 


def compute_test_mape(file_path):
    with open(file_path, 'r') as f:
        lines = f.readlines()
    
    lines = lines[1:]  # Skip header
    targets, preds = [], []

    for line in lines:
        _, target, pred = line.strip().split(',')
        targets.append(float(target))
        preds.append(float(pred))

    targets = torch.tensor(targets, dtype=torch.float32)
    preds = torch.tensor(preds, dtype=torch.float32)
    mape = mape_loss(preds, targets).item()
    return mape


if __name__ == "__main__":
    for bench_dir in Path(our_model_dir).iterdir():
        bench_dir = bench_dir / "run_1"
        if not bench_dir.is_dir():
            continue
        ensemble_preds = bench_dir / "anchor_calibration/run_1/predictions.csv"
        ft_preds = bench_dir / "fine_tuning/run_1/predictions.csv"
        if ensemble_preds.exists():
            our_zero_cost_mapes.append(compute_test_mape(ensemble_preds))
        if ft_preds.exists():
            our_ft_mapes.append(compute_test_mape(ft_preds))

    for bench_dir in Path(harp_model_dir).iterdir():
        bench_dir = bench_dir / "run_1"
        if not bench_dir.is_dir():
            continue
        preds = bench_dir / "predictions.csv"
        if preds.exists():
            harp_mapes.append(compute_test_mape(preds))

    for file in Path(hgp_model_dir).iterdir():
        if file.name.endswith("_predictions.csv"):
            hgp_mapes.append(compute_test_mape(file))

    our_zero_cost_mape = sum(our_zero_cost_mapes) / len(our_zero_cost_mapes) if our_zero_cost_mapes else float('nan')
    our_ft_avg_mape = sum(our_ft_mapes) / len(our_ft_mapes) if our_ft_mapes else float('nan')
    harp_avg_mape = sum(harp_mapes) / len(harp_mapes) if harp_mapes else float('nan')
    hgp_avg_mape = sum(hgp_mapes) / len(hgp_mapes) if hgp_mapes else float('nan')

    # Normalize with vitis_hls_mape
    our_zero_cost_mape /= vitis_hls_mape
    our_ft_avg_mape /= vitis_hls_mape
    harp_avg_mape /= vitis_hls_mape
    hgp_avg_mape /= vitis_hls_mape
    vitis_hls_mape = 1.0  # Normalized

    labels = ['Vitis HLS', 'HARP', 'HGBO-DSE', 'Our (Zero-cost)', 'Our (Fine-tuned)']

    plt.figure(figsize=(10, 6), dpi=200)
    avg_mapes = [
        vitis_hls_mape,
        harp_avg_mape,
        hgp_avg_mape,
        our_zero_cost_mape,
        our_ft_avg_mape
    ]
    colors = ["#c1c1c1", "#94e0bd", "#a28ec9", "#82b3d4", "#3472a1"]
    bars = plt.bar(
        labels, 
        avg_mapes, 
        color=colors,
        edgecolor='black', # Add a black edge to the bars
        linewidth=0.8,     # Set edge width
        width=0.6          # Make bars slightly narrower
    )
    plt.ylabel('Average MAPE')
    plt.title('Model Performance Comparison')
    plt.ylim(0, max(avg_mapes) * 1.2)

    for bar, avg_mape in zip(bars, avg_mapes):
        plt.text(
            bar.get_x() + bar.get_width() / 2, bar.get_height() + 0.01, f'{avg_mape:.4f}', 
            ha='center', va='bottom'
        )

    plt.grid(axis='y')
    plt.savefig('figures/model_perf_comparison.png', bbox_inches='tight', dpi=300, transparent=True)
    plt.show()