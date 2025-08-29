import json
from pathlib import Path
from typing import Optional, Union, Dict, Any

import torch

from estimators.common.analysis_utils import parse_predictions
from estimators.common.losses import mape_loss


def evaluate_results_on_benchmark(
    predictions_path: Union[str, Path],
    solution_type: Optional[str] = None,
    last_base_index: Optional[int] = None
) -> float:
    indices, targets, preds = parse_predictions(predictions_path)

    if solution_type is not None:
        if last_base_index is None:
            raise ValueError("last_base_index must be provided when solution_type is specified.")
        
        last_base_solution_index = indices.index(last_base_index) if last_base_index in indices else -1

        if solution_type == "base":
            targets = targets[:last_base_solution_index + 1]
            preds = preds[:last_base_solution_index + 1]
        elif solution_type == "non_base":
            targets = targets[last_base_solution_index + 1:]
            preds = preds[last_base_solution_index + 1:]
        elif solution_type not in ["all", "total"]:
            raise ValueError("Invalid solution_type. Must be 'base', 'non_base', or 'all'.")
        
    preds = torch.tensor(preds, dtype=torch.float32)
    targets = torch.tensor(targets, dtype=torch.float32)
    
    return mape_loss(preds, targets).mean().item()


def evaluate_results(
    models_dir: Union[str, Path],
    benchmark_info_dict: Dict[str, Any]
):
    # Compute MAPE for the results in the specified models directory
    # The directory should be structured as following:
    # models_dir/
    #   benchmark_name/
    #     predictions.csv
    #     ... (other files)
    mape_results = {}

    for benchmark, info in benchmark_info_dict.items():
        benchmark_dir = Path(models_dir) / benchmark
        predictions_path = benchmark_dir / "predictions.csv"

        if not predictions_path.exists():
            print(f"Predictions file not found for benchmark: {benchmark}")
            continue

        last_base_index = info.get("last_base_index", 0)

        mape_base = evaluate_results_on_benchmark(
            predictions_path,
            solution_type="base",
            last_base_index=last_base_index
        )
        mape_non_base = evaluate_results_on_benchmark(
            predictions_path,
            solution_type="non_base",
            last_base_index=last_base_index
        )
        mape_total = evaluate_results_on_benchmark(
            predictions_path,
            solution_type=None,
            last_base_index=last_base_index
        )
        mape_results[benchmark] = {
            "base": mape_base,
            "non_base": mape_non_base,
            "total": mape_total
        }

    return mape_results


def main(args: Dict[str, Any]):
    models_dir = Path(args['models_dir'])
    benchmark_info_path = Path(args['benchmark_info'])
    output_path = args.get('output_path')

    if not models_dir.exists():
        raise FileNotFoundError(f"Models directory does not exist: {models_dir}")
    
    if not benchmark_info_path.exists():
        raise FileNotFoundError(f"Benchmark info file does not exist: {benchmark_info_path}")
    
    with open(benchmark_info_path, 'r') as f:
        benchmark_info_dict = json.load(f)

    mape_results = evaluate_results(
        models_dir=models_dir,
        benchmark_info_dict=benchmark_info_dict
    )

    if output_path is not None:
        with open(output_path, 'w') as f:
            f.write("benchmark,mape_base,mape_non_base,mape_total\n")
            for benchmark, mape in mape_results.items():
                f.write(f"{benchmark},{mape['base']},{mape['non_base']},{mape['total']}\n")
    else:
        print("MAPE Results:")
        for benchmark, mape in mape_results.items():
            print(f"{benchmark}: Base MAPE = {mape['base']}, Non-Base MAPE = {mape['non_base']}, Total MAPE = {mape['total']}")

    
if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Evaluate results on benchmarks.")
    parser.add_argument("models_dir", type=str, help="Path to the models directory.")
    parser.add_argument("-b", "--benchmark_info", type=str, default="data/benchmarks/benchmark_info.json",
                        help="Path to the benchmark info JSON file.")
    parser.add_argument("-o", "--output_path", type=str, default=None,
                        help="Path to save the MAPE results CSV file.")

    args = parser.parse_args()
    main(vars(args))