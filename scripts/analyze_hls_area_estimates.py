from typing import List, Union, Optional
from pathlib import Path

import torch
import numpy as np

from estimators.common.parsers import (
    AREA_METRICS,
    AVAILABLE_RESOURCES,
    extract_area_metrics,
    extract_hls_area_estimates
)
from estimators.common.metrics import compute_snru
from estimators.common.losses import mape_loss


def compute_baseline_error(
    dataset_dir: Union[str, Path],
    metrics: Optional[List[str]] = None,
    benchmarks: Optional[List[str]] = None,
    verbose: bool = False
) -> float:
    metrics = metrics or AREA_METRICS

    def validate_report(report) -> bool:
        if report is None or not isinstance(report, dict):
            return False
        for metric in metrics:
            if metric not in report or report[metric] < 0:
                return False
        return True
    
    avail_resources = torch.tensor(
        [AVAILABLE_RESOURCES[r] for r in metrics],
        dtype=torch.float32
    )
    mape_list = []

    for benchmark_dir in Path(dataset_dir).iterdir():
        if (not benchmark_dir.is_dir() 
            or (benchmarks is not None and benchmark_dir.name not in benchmarks)):
            continue

        preds = []
        targets = []
        for solution_dir in Path(benchmark_dir).iterdir():
            if (not solution_dir.is_dir() or 
                not solution_dir.name.startswith("solution") or
                solution_dir.name == "solution0"):
                continue

            impl_util_rpt = extract_area_metrics(solution_dir)
            if not validate_report(impl_util_rpt):
                if verbose:
                    print(f"Invalid implementation report for {solution_dir.name}")
                continue

            hls_util_rpt = extract_hls_area_estimates(solution_dir)
            if not validate_report(hls_util_rpt):
                if verbose:
                    print(f"Invalid HLS area estimates for {solution_dir.name}")
                continue

            ground_truth = torch.tensor(
                [impl_util_rpt[key] for key in metrics],
                dtype=torch.float32
            )
            estimates = torch.tensor(
                [hls_util_rpt[key] for key in metrics],
                dtype=torch.float32
            )
            ground_truth = compute_snru(ground_truth, avail_resources)
            estimates = compute_snru(estimates, avail_resources)

            targets.append(ground_truth)
            preds.append(estimates)

        if not preds or not targets:
            if verbose:
                print(f"No valid solutions found for benchmark {benchmark_dir.name}")
            continue

        preds = torch.cat(preds, dim=0).unsqueeze(0)
        targets = torch.cat(targets, dim=0).unsqueeze(0)
        mape = mape_loss(preds, targets).item()
        mape_list.append(mape)
        print(f"Benchmark {benchmark_dir.name} MAPE: {mape:.4f}")

    if not mape_list:
        return -1.0  # No valid reports found
    
    return np.mean(mape_list)  # Return the average MAPE across all benchmarks


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(
        description="Compute baseline (Vitis HLS) MAPE on area estimates for a dataset."
    )
    parser.add_argument("dataset_dir", type=str, help="Path to the dataset directory.")
    parser.add_argument("-m", "--metrics", nargs='*', default=["lut", "ff", "bram", "dsp"], 
                        help="Metrics to compute baseline error for.")
    parser.add_argument("-b", "--benchmarks", nargs='*', default=None,
                        help="List of benchmarks to compute baseline error for. "
                             "If not provided, all benchmarks will be considered.")
    parser.add_argument("-v", "--verbose", action="store_true",
                        help="Enable verbose output for debugging.")

    args = parser.parse_args()

    error = compute_baseline_error(
        dataset_dir=args.dataset_dir, 
        metrics=args.metrics, 
        benchmarks=args.benchmarks,
        verbose=args.verbose
    )
    if error < 0:
        print("No valid reports found.")
    else:
        print(f"Baseline MAPE: {error:.4f}")