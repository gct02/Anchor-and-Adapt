import argparse
import json
import pickle
import random
from pathlib import Path
from typing import Dict, Any

from estimator.common.parsers import (
    extract_metrics, 
    export_directives_as_tcl, 
    parse_tcl_directives
)
from estimator.common.constants import (
    METRICS, 
    BENCHMARKS, 
    BENCHMARK_INFO_PATH
)
from estimator.area.graph import AreaKernelGraph


def main(args: Dict[str, Any]):
    dataset_dir = Path(args['dataset_dir'])
    output_dir = Path(args['output_dir'])
    max_instances = args.get('max_instances', 1000)
    skip_base = args.get('skip_base', False)
    shuffle = args.get('shuffle', False)

    if not dataset_dir.exists() or not dataset_dir.is_dir():
        raise FileNotFoundError(f"Dataset directory not found: {dataset_dir}")

    if not output_dir.exists():
        output_dir.mkdir(parents=True, exist_ok=True)

    with open(BENCHMARK_INFO_PATH, "r") as f:
        bench_info_dict = json.load(f)

    anchor_dict = {bench: AreaKernelGraph(bench) for bench in BENCHMARKS}

    for bench, graph in anchor_dict.items():
        bench_dir = dataset_dir / bench
        bench_out_dir = output_dir / bench
        bench_out_dir.mkdir(parents=True, exist_ok=True)

        with open(bench_out_dir / "anchor_graph.pkl", "wb") as f:
            pickle.dump(graph, f)

        with open(bench_out_dir / "anchor_metrics.json", "w") as f:
            json.dump(graph.anchor_metrics, f, indent=2)

        graph.save_as_json(bench_out_dir / "anchor_graph.json")

        last_base_index = bench_info_dict[bench].get("last_base_index", 0)
        solution_info_list = []

        for sol_dir in bench_dir.iterdir():
            if not sol_dir.is_dir() or not sol_dir.name.startswith('solution'): 
                continue

            sol_index = int(sol_dir.name.split("solution")[-1])
            is_base = (sol_index <= last_base_index)
            if sol_index == 0 or (skip_base and is_base): 
                continue

            metrics = extract_metrics(sol_dir)
            if any([metrics.get(key, -1) < 0 for key in METRICS]): 
                continue

            data_json_path = sol_dir / f"{sol_dir.stem}_data.json"
            dct_tcl_path = sol_dir / f"directives.tcl"
            if not dct_tcl_path.exists():
                if not data_json_path.exists(): continue
                export_directives_as_tcl(data_json_path, dct_tcl_path)

            directives = parse_tcl_directives(dct_tcl_path)

            # Skip solutions with "dataflow" directives as they
            # are very rare in our dataset and might be outliers
            if any([dct.get('directive', '') == "dataflow" for dct in directives]): 
                continue

            sol_log_path = sol_dir / f"{sol_dir.name}.log"
            solution_info_list.append((sol_dir.name, sol_log_path, directives, metrics))

        if shuffle:
            random.shuffle(solution_info_list)
        solution_info_list = solution_info_list[:max_instances]

        for sol, sol_log_path, directives, metrics in solution_info_list:
            sol_out_dir = bench_out_dir / sol
            sol_out_dir.mkdir(parents=True, exist_ok=True)

            with open(sol_out_dir / "metrics.json", "w") as f:
                json.dump(metrics, f, indent=2)

            directive_feats = graph.get_directive_features(directives, log_path=sol_log_path)
            
            with open(sol_out_dir / "directive_features.json", "w") as f:
               json.dump(directive_feats, f, indent=2)

        print(f"Processed {bench_dir.name}")

def parse_args():
    parser = argparse.ArgumentParser(
        description="Process dataset to extract metrics and build graphs"
    )
    parser.add_argument("-d", "--dataset-dir", required=True,
                        help="Path to the dataset directory")
    parser.add_argument("-o", "--output-dir", default="estimator/area/dataset/raw",
                        help="Path to the output directory")
    parser.add_argument("-s", "--shuffle", action='store_true',
                        help="Shuffle the solutions before processing.")
    parser.add_argument("--max-instances", type=int, default=1000,
                        help="Maximum number of instances to process per benchmark")
    parser.add_argument( "--skip-base", action='store_true',
                        help="Skip 'base' solutions")
    return vars(parser.parse_args())


if __name__ == "__main__":
    args = parse_args()
    main(args)

