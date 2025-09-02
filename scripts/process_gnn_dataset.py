import argparse
import json
import pickle
from pathlib import Path
from typing import Dict, Any

from estimators.common.parsers import (
    AREA_METRICS,
    extract_area_metrics,
    export_directives_as_tcl
)

from estimators.area.graph import (
    extract_base_graphs, 
    update_with_directives
)

def main(args: Dict[str, Any]):
    dataset_dir = Path(args['dataset_dir'])
    output_dir = Path(args['output_dir'])
    bench_info_path = Path(args['benchmark_info_path'])
    max_instances = args.get('max_instances', 1000)

    if not dataset_dir.exists() or not dataset_dir.is_dir():
        raise FileNotFoundError(f"Dataset directory not found: {dataset_dir}")
    
    if not bench_info_path.exists() or not bench_info_path.is_file():
        raise FileNotFoundError(f"Benchmark info file not found: {bench_info_path}")

    if not output_dir.exists():
        output_dir.mkdir(parents=True, exist_ok=True)

    with open(bench_info_path, "r") as f:
        bench_info_dict = json.load(f)

    base_graph_dict = extract_base_graphs(bench_info_dict)

    for bench, base_graph in base_graph_dict.items():
        bench_dir = dataset_dir / bench
        bench_out_dir = output_dir / bench
        bench_out_dir.mkdir(parents=True, exist_ok=True)

        base_graph.save_as_json(bench_out_dir / "base_graph.json")

        with open(bench_out_dir / "base_graph.pkl", "wb") as f:
            pickle.dump(base_graph, f)

        base_metrics = base_graph.base_ground_truth
        with open(bench_out_dir / "base_metrics.json", "w") as f:
            json.dump(base_metrics, f, indent=2)

        instance_count = 0
        for sol in bench_dir.iterdir():
            if (not sol.is_dir() or 
                not sol.name.startswith("solution") or
                sol.name == "solution0"):
                continue

            hls_log_path = sol / f"{sol.stem}.log"
            if not hls_log_path.exists():
                print(f"Solution log file not found for {sol}")
                continue

            hls_data_json_path = sol / f"{sol.stem}_data.json"
            dct_tcl_path = sol / f"directives.tcl"

            if not hls_data_json_path.exists():
                if not dct_tcl_path.exists():
                    print(f"Directives JSON file not found for {sol}")
                    continue
            elif not dct_tcl_path.exists():
                export_directives_as_tcl(hls_data_json_path, dct_tcl_path)

            sol_out_dir = bench_out_dir / sol.stem
            sol_out_dir.mkdir(parents=True, exist_ok=True)

            metrics = extract_area_metrics(sol)
            if any(metrics.get(key, -1) < 0 for key in AREA_METRICS):
                print(f"Skipping {sol} due to missing metrics")
                continue

            with open(sol_out_dir / "metrics.json", "w") as f:
                json.dump(metrics, f, indent=2)

            graph = update_with_directives(base_graph, dct_tcl_path, hls_log_path)

            with open(sol_out_dir / "graph.pkl", "wb") as f:
                pickle.dump(graph, f)

            instance_count += 1
            if instance_count >= max_instances:
                break

        print(f"Processed {bench_dir.name}: {instance_count} instances")

def parse_args():
    parser = argparse.ArgumentParser(
        description="Process dataset to extract metrics and build graphs"
    )
    parser.add_argument("-d", "--dataset-dir", required=True,
                        help="Path to the dataset directory")
    parser.add_argument("-o", "--output-dir", default="estimators/area/dataset/full",
                        help="Path to the output directory")
    parser.add_argument("-b", "--benchmark-info-path", default="data/benchmark_info.json",
                        help="Path to the benchmark info JSON file")
    parser.add_argument("-mi", "--max-instances", type=int, default=1000,
                        help="Maximum number of instances to process per benchmark")
    return vars(parser.parse_args())


if __name__ == "__main__":
    args = parse_args()
    main(args)

