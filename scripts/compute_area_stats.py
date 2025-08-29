import os

import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns

from estimators.common.parsers import (
    extract_area_metrics,
    AREA_METRICS,
)

BENCHMARKS = [
    'ADPCM', 'AES', 'BACKPROP', 'GEMM', 'GRAMSCHMIDT', 
    'GSM', 'KNN', 'SHA', 'STENCIL3D', 'TRANS_FFT'
]

dataset_dir = '../dataset-filtered'
base_sols_dir = 'data/base_solutions'

plot_distribution = True

for bench in BENCHMARKS:
    bench_dir = os.path.join(dataset_dir, bench)
    if not os.path.exists(bench_dir):
        print(f"Benchmark directory not found: {bench_dir}")
        continue

    util_dict = {metric: [] for metric in AREA_METRICS}
    for sol in os.listdir(bench_dir):
        sol_dir = os.path.join(bench_dir, sol)
        if (not os.path.isdir(sol_dir) or 
            not sol.startswith('solution') or
            sol == 'solution0'):
            continue

        util = extract_area_metrics(sol_dir, filtered=True)
        if any(util[metric] < 0 for metric in AREA_METRICS):
            continue

        for metric in AREA_METRICS:
            util_dict[metric].append(float(util[metric]))

    sol0_util = None
    # sol0_dir = os.path.join(bench_dir, 'solution0')
    sol0_dir = os.path.join(base_sols_dir, bench, 'solution0')
    if os.path.exists(sol0_dir):
        sol0_util = extract_area_metrics(sol0_dir)
        if any(sol0_util[metric] < 0 for metric in AREA_METRICS):
            sol0_util = None

    for metric in AREA_METRICS:
        metric_util = util_dict.get(metric, [])
        if not metric_util:
            print(f"No data for {metric} in benchmark {bench}.")
            continue

        metric_util = np.array(metric_util, dtype=np.float32)
        mean = np.mean(metric_util)
        std = np.std(metric_util)
        min_val = np.min(metric_util)
        max_val = np.max(metric_util)

        print(f'{bench} - {metric}')
        print(f'Mean: {mean:.3f}, Std: {std:.3f}, Min: {min_val:.3f}, Max: {max_val:.3f}')

        if sol0_util is not None:
            sol0_metric_util = sol0_util.get(metric, -1)
            if sol0_metric_util >= 0:
                print(f'Solution 0 {metric}: {sol0_metric_util}')
            else:
                print(f'Solution 0 {metric}: Not available')

        if plot_distribution:
            plt.figure(figsize=(10, 6))
            sns.histplot(metric_util, bins='auto', kde=True, color='blue', edgecolor='black', alpha=0.7)
            plt.axvline(mean, color='red', linestyle='dashed', linewidth=2, label=f'Mean: {mean:.3f}')
            plt.axvline(mean + std, color='green', linestyle='dashed', linewidth=1, label=f'+1 Std Dev: {mean + std:.3f}')
            plt.axvline(mean - std, color='green', linestyle='dashed', linewidth=1, label=f'-1 Std Dev: {mean - std:.3f}')
            plt.title(f'{bench} - {metric} Distribution', fontsize=14)
            plt.xlabel(f'{metric} Utilization', fontsize=12)
            plt.ylabel('Frequency', fontsize=12)
            plt.legend()
            plt.show()