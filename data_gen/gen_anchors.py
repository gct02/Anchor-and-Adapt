import json
from pathlib import Path

from data_gen.dataset_gen import DatasetGenerator

ANCHOR_SOLUTIONS_DIR = Path('data/anchor_solutions')
ANCHOR_CONFIGS_DIR = Path('data/anchor_configs')

if __name__ == "__main__":
    with open('data/benchmark_info.json', 'r') as f:
        benchmark_info_dict = json.load(f)

    for benchmark, benchmark_info in benchmark_info_dict.items():
        if benchmark != "HEAT3D": continue
        print(f"Generating Anchor for {benchmark}")

        dataset_gen = DatasetGenerator(
            project_dir=ANCHOR_SOLUTIONS_DIR / benchmark,
            sources=benchmark_info['source_files'],
            top_function=benchmark_info['top_function'],
            directive_config_path=benchmark_info['directive_config_path']
        )
        dataset_gen.gen_anchor_solution(benchmark_info['anchor_config_path'])