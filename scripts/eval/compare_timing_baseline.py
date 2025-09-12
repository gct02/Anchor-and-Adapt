import json
from pathlib import Path
from typing import List, Optional, Dict

import numpy as np

FINISHED_EXPORT_STR = 'INFO: [HLS 200-111] Finished Command export_design'
FINISHED_CSYNTH_STR = 'INFO: [HLS 200-111] Finished Command csynth_design'
FINISHED_OPT_STR = 'INFO: [HLS 200-111] Finished Compiling Optimization and Transform'
FINISHED_ARCH_SYN_STR = 'INFO: [HLS 200-111] Finished Architecture Synthesis'
FINISHED_RTL_GEN_STR = 'INFO: [HLS 200-111] Finished Generating all RTL models'
GENERATING_RTL_STR = 'INFO: [HLS 200-10] -- Generating RTL'

INFERENCE_TIME = 0.032  # seconds
INFERENCE_TIME_HGBO = 0.028

FINE_TUNING_TIME = 5.25

def find_lines_containing(lines: List[str], search_str: str) -> List[str]:
    return [line for line in lines if search_str in line]


def find_line_containing(
    lines: List[str], 
    search_str: str, 
    start_index: int = 0, 
    get_first: bool = False,
) -> Optional[int]:
    num_lines = len(lines)
    if start_index < 0 or start_index >= num_lines:
        return None

    if not get_first:
        for i in range(num_lines - 1, start_index - 1, -1):
            if search_str in lines[i]:
                return i
        return None
    
    for i in range(start_index, num_lines):
        if search_str in lines[i]:
            return i
    return None


def get_elapsed_time_from_line_hls(line: str) -> float:
    if 'Elapsed time: ' in line:
        time_str = line.split('Elapsed time: ')[1].split(' ')[0]
        try:
            return float(time_str)
        except ValueError:
            print(f"Could not parse elapsed time from line: {line.strip()}")
            return -1.0
    return -1.0


def get_elapsed_time_from_line_impl(line: str) -> float:
    if 'elapsed = ' in line:
        time_str = line.split('elapsed = ')[1].split(' ')[0]
        hours, minutes, seconds = time_str.split(':')
        try:
            total_seconds = int(hours) * 3600 + int(minutes) * 60 + float(seconds)
            return total_seconds
        except ValueError:
            print(f"Could not parse elapsed time from line: {line.strip()}")
            return -1.0
    return -1.0


def find_elapsed_time_in_lines_hls(lines: List[str]) -> List[float]:
    elapsed_times = []
    for line in lines:
        elapsed_time = get_elapsed_time_from_line_hls(line)
        if elapsed_time >= 0:
            elapsed_times.append(elapsed_time)
    return elapsed_times


def find_elapsed_time_in_lines_impl(lines: List[str]) -> List[float]:
    elapsed_times = []
    for line in lines:
        elapsed_time = get_elapsed_time_from_line_impl(line)
        if elapsed_time >= 0:
            elapsed_times.append(elapsed_time)
    return elapsed_times


def extract_timing_from_anchors() -> Dict[str, float]:
    bench_info_path = Path("data/benchmark_info.json")
    if not bench_info_path.exists():
        print(f"Benchmark info file {bench_info_path} does not exist.")
        return {}

    with open(bench_info_path, "r") as f:
        bench_info_dict = json.load(f)

    timing_info = {}
    for bench_name, info in bench_info_dict.items():
        base_solution_dir = info.get("base_solution_dir")
        if not base_solution_dir:
            print(f"No base solution directory for benchmark {bench_name}.")
            continue
        
        solution_dir = Path(base_solution_dir)
        log_file = solution_dir / f"{solution_dir.name}.log"
        if not solution_dir.is_dir() or not log_file.exists():
            print(f"Log file {log_file} does not exist for benchmark {bench_name}.")
            continue

        with open(log_file, "r") as f:
            lines = f.readlines()

        # Some logs have been appended to the log of a failed run.
        start_idx = find_line_containing(lines, 'INFO: [HLS 200-1505]')
        if start_idx is None:
            print(f"Could not find the start of synthesis in {log_file}.")
            continue

        lines = lines[start_idx:]

        finished_export_idx = find_line_containing(lines, FINISHED_EXPORT_STR)
        if finished_export_idx is None:
            print(f"Could not find '{FINISHED_EXPORT_STR}' in {log_file}.")
            continue

        elapsed_time = get_elapsed_time_from_line_hls(lines[finished_export_idx])
        if elapsed_time < 0:
            print(f"Could not parse elapsed time from line: {lines[finished_export_idx]}")
            continue

        timing_info[bench_name] = elapsed_time

    return timing_info


def extract_hls_elapsed_time(solution_dir: Path) -> float:
    log_file = solution_dir / f"{solution_dir.name}.log"
    if not log_file.exists():
        print(f"Log file {log_file} does not exist for {solution_dir.name}.")
        return -1.0

    with open(log_file, "r") as f:
        lines = f.readlines()

    finished_csynth_idx = find_line_containing(lines, FINISHED_CSYNTH_STR)
    if finished_csynth_idx is not None:
        elapsed_time = get_elapsed_time_from_line_hls(lines[finished_csynth_idx])
        if elapsed_time >= 0:
            return elapsed_time
    
    # Some logs have been appended to the log of a failed run.
    start_idx = find_line_containing(lines, 'INFO: [HLS 200-1505]')
    if start_idx is None:
        print(f"Could not find the start of synthesis in {log_file}.")
        return -1.0

    lines = lines[start_idx:]
    csynth_time = 0.0

    finished_opt_idx = find_line_containing(lines, FINISHED_OPT_STR)
    if finished_opt_idx is not None:
        elapsed_time = get_elapsed_time_from_line_hls(lines[finished_opt_idx])
        if elapsed_time >= 0:
            csynth_time += elapsed_time
        else:
            elapsed_times = find_elapsed_time_in_lines_hls(lines[:finished_opt_idx])
            csynth_time += sum(elapsed_times)
        lines = lines[finished_opt_idx + 1:]

    finished_arch_syn_idx = find_line_containing(lines, FINISHED_ARCH_SYN_STR)
    if finished_arch_syn_idx is not None:
        elapsed_time = get_elapsed_time_from_line_hls(lines[finished_arch_syn_idx])
        if elapsed_time >= 0:
            csynth_time += elapsed_time
        else:
            elapsed_times = find_elapsed_time_in_lines_hls(lines[:finished_arch_syn_idx])
            csynth_time += sum(elapsed_times)
        lines = lines[finished_arch_syn_idx + 1:]

    finished_rtl_gen_idx = find_line_containing(
        lines, FINISHED_RTL_GEN_STR, get_first=True
    )
    if finished_rtl_gen_idx is not None:
        elapsed_time = get_elapsed_time_from_line_hls(lines[finished_rtl_gen_idx])
        if elapsed_time >= 0:
            csynth_time += elapsed_time
        else:
            rtl_start_idx = find_line_containing(
                lines, GENERATING_RTL_STR, get_first=True
            )
            if rtl_start_idx is None:
                return csynth_time if csynth_time > 0 else -1.0
            
            rtl_gen_lines = lines[rtl_start_idx:finished_rtl_gen_idx]
            elapsed_times = find_elapsed_time_in_lines_hls(rtl_gen_lines)
            csynth_time += sum(elapsed_times)
    else:
        rtl_start_idx = find_line_containing(
            lines, GENERATING_RTL_STR, get_first=True
        )
        if rtl_start_idx is None:
            return csynth_time if csynth_time > 0 else -1.0
            
        lines = lines[rtl_start_idx:]
        elapsed_time_lines = find_lines_containing(lines, 'Elapsed time: ')
        for line in elapsed_time_lines:
            if FINISHED_CSYNTH_STR in line or FINISHED_EXPORT_STR in line:
                break
            elapsed_time = get_elapsed_time_from_line_hls(line)
            if elapsed_time >= 0:
                csynth_time += elapsed_time

    return csynth_time if csynth_time > 0 else -1.0


def extract_synth_elapsed_time(solution_dir: Path) -> float:
    log_file = solution_dir / "reports/synth_runme.log"
    if not log_file.exists():
        print(f"Log file {log_file} does not exist for {solution_dir.name}.")
        return -1.0
    
    with open(log_file, "r") as f:
        lines = f.readlines()

    finished_synth_idx = find_line_containing(lines, 'synth_design: ')
    if finished_synth_idx is None:
        print(f"Could not find 'synth_design' in {log_file}.")
        return -1.0
    
    finished_synth_line = lines[finished_synth_idx]
    elapsed_time = get_elapsed_time_from_line_impl(finished_synth_line)
    if elapsed_time < 0:
        print(f"Could not parse elapsed time from line: {finished_synth_line.strip()}")
        return -1.0
    
    return elapsed_time


def extract_impl_elapsed_time(solution_dir: Path) -> float:            
    log_file = solution_dir / "reports/impl_runme.log"
    if not log_file.exists():
        print(f"Log file {log_file} does not exist for {solution_dir.name}.")
        return -1.0

    with open(log_file, "r") as f:
        lines = f.readlines()

    place_completed_idx = find_line_containing(lines, 'place_design: ')
    if place_completed_idx is None:
        print(f"Could not find 'place_design' in {log_file}.")
        return -1.0

    route_completed_idx = find_line_containing(lines, 'route_design: ')
    if route_completed_idx is None:
        print(f"Could not find 'route_design' in {log_file}.")
        return -1.0
    
    place_completed_line = lines[place_completed_idx]
    route_completed_line = lines[route_completed_idx]

    place_elapsed_time = get_elapsed_time_from_line_impl(place_completed_line)
    if place_elapsed_time < 0:
        print(f"Could not parse elapsed time from line: {place_completed_line.strip()}")
        return -1.0
    
    route_elapsed_time = get_elapsed_time_from_line_impl(route_completed_line)
    if route_elapsed_time < 0:
        print(f"Could not parse elapsed time from line: {route_completed_line.strip()}")
        return -1.0
    
    return place_elapsed_time + route_elapsed_time


def summarize_timing_info(dataset_dir: Path):
    benchmark_info_path = Path("data/benchmark_info.json")
    with open(benchmark_info_path, "r") as f:
        bench_info_dict = json.load(f)

    elapsed_times_base_hls = []
    elapsed_times_base_impl = []
    elapsed_times_non_base_hls = []
    elapsed_times_non_base_impl = []

    for bench_dir in dataset_dir.iterdir():
        if not bench_dir.is_dir():
            continue

        bench_name = bench_dir.name
        print(f"Processing benchmark: {bench_name}")

        benchmark_info = bench_info_dict[bench_name]
        last_base_index = benchmark_info["last_base_index"]

        for solution_dir in bench_dir.iterdir():
            if (not solution_dir.is_dir() 
                or not solution_dir.name.startswith("solution")
                or solution_dir.name == "solution0"):
                continue

            log_file = solution_dir / f"{solution_dir.name}.log"
            if not log_file.exists():
                print(f"Log file {log_file} does not exist for {solution_dir.name}.")
                continue

            hls_elapsed_time = extract_hls_elapsed_time(solution_dir)
            if hls_elapsed_time < 0:
                print(f"Skipping {solution_dir.name} due to missing HLS time.")
                continue
            elif hls_elapsed_time > 5000:
                print(f"Skipping {solution_dir.name} due to excessive HLS time: {hls_elapsed_time:.2f} seconds. "
                      "This may indicate an error in the HLS process.")
                continue
            
            total_elapsed_time = 0

            with open(log_file, "r") as f:
                lines = f.readlines()

            finished_export_idx = find_line_containing(lines, FINISHED_EXPORT_STR)
            if finished_export_idx is not None:
                export_elapsed_time = get_elapsed_time_from_line_hls(lines[finished_export_idx])
                if export_elapsed_time >= 0:
                    total_elapsed_time = export_elapsed_time + hls_elapsed_time

            if total_elapsed_time == 0:
                synth_elaped_time = extract_synth_elapsed_time(solution_dir)
                if synth_elaped_time < 0:
                    print(f"Skipping {solution_dir.name} due to missing synthesis time.")
                    continue
                
                impl_elapsed_time = extract_impl_elapsed_time(solution_dir)
                if impl_elapsed_time < 0:
                    print(f"Skipping {solution_dir.name} due to missing implementation time.")
                    continue

                total_elapsed_time = hls_elapsed_time + synth_elaped_time + impl_elapsed_time
            
            solution_idx = int(solution_dir.name.split("solution")[-1])
            if solution_idx <= last_base_index:
                elapsed_times_base_hls.append(hls_elapsed_time)
                elapsed_times_base_impl.append(total_elapsed_time)
            else:
                elapsed_times_non_base_hls.append(hls_elapsed_time)
                elapsed_times_non_base_impl.append(total_elapsed_time)

    elapsed_times_base_hls = np.array(elapsed_times_base_hls)
    elapsed_times_base_impl = np.array(elapsed_times_base_impl)
    elapsed_times_non_base_hls = np.array(elapsed_times_non_base_hls)
    elapsed_times_non_base_impl = np.array(elapsed_times_non_base_impl)

    stats = {
        "base_hls": {
            "mean": np.mean(elapsed_times_base_hls),
            "std": np.std(elapsed_times_base_hls),
            "max": np.max(elapsed_times_base_hls),
            "min": np.min(elapsed_times_base_hls)
        },
        "base_impl": {
            "mean": np.mean(elapsed_times_base_impl),
            "std": np.std(elapsed_times_base_impl),
            "max": np.max(elapsed_times_base_impl),
            "min": np.min(elapsed_times_base_impl)
        },
        "non_base_hls": {
            "mean": np.mean(elapsed_times_non_base_hls),
            "std": np.std(elapsed_times_non_base_hls),
            "max": np.max(elapsed_times_non_base_hls),
            "min": np.min(elapsed_times_non_base_hls)
        },
        "non_base_impl": {
            "mean": np.mean(elapsed_times_non_base_impl),
            "std": np.std(elapsed_times_non_base_impl),
            "max": np.max(elapsed_times_non_base_impl),
            "min": np.min(elapsed_times_non_base_impl)
        }
    }

    print("\nTiming Statistics:")
    for key, value in stats.items():
        print(f"{key} - Mean: {value['mean']:.4f}, Std: {value['std']:.4f}, "
              f"Max: {value['max']:.4f}, Min: {value['min']:.4f}")
        
    return stats


if __name__ == "__main__":
    r"""Plot the graph comparing the speed of our approach 
    versus the approach presented in HGBO-DSE."""
    import sys
    import matplotlib.pyplot as plt

    plt.rcParams.update({'font.size': 14})

    dataset_dir = Path(sys.argv[1]) if len(sys.argv) > 1 else Path("../dataset-filtered")
    if not dataset_dir.exists():
        print(f"Dataset directory {dataset_dir} does not exist.")
        sys.exit(1)

    stats = summarize_timing_info(dataset_dir)
    base_impl_mean = stats["base_impl"]["mean"]
    non_base_hls_mean = stats["non_base_hls"]["mean"]
    non_base_impl_mean = stats["non_base_impl"]["mean"]

    x = np.arange(1, 1001)

    t_calibration = 5 * INFERENCE_TIME
    upfront_cost_calibration = base_impl_mean + t_calibration
    our_approach = upfront_cost_calibration + x * INFERENCE_TIME

    t_anchor = base_impl_mean
    t_constrained_points = 5 * base_impl_mean
    t_complex_points = 4 * non_base_impl_mean
    upfront_cost_ft = t_anchor + t_constrained_points + t_complex_points + FINE_TUNING_TIME
    our_approach_fine_tuning = upfront_cost_ft + x * INFERENCE_TIME

    hgbo_dse_approach = x * (non_base_hls_mean + INFERENCE_TIME_HGBO)

    # Find where our zero-cost approach becomes faster than the baseline
    if non_base_hls_mean > 0:
        x_break_even = upfront_cost_calibration / non_base_hls_mean
        y_break_even = x_break_even * (non_base_hls_mean + INFERENCE_TIME_HGBO)
    else:
        x_break_even = -1

    # Find where our fine-tuning becomes faster than the baseline
    if non_base_hls_mean > 0:
        x_ft_break_even = upfront_cost_ft / non_base_hls_mean
        y_ft_break_even = x_ft_break_even * (non_base_hls_mean + INFERENCE_TIME_HGBO)
    else:
        x_ft_break_even = -1

    fig, ax = plt.subplots(figsize=(10, 6), dpi=200)
    ax.plot(x, hgbo_dse_approach, label="HGBO-DSE", color='orange', linewidth=2)
    ax.plot(x, our_approach, label="Our (Zero-cost)", color='blue', linewidth=2)
    ax.plot(x, our_approach_fine_tuning, label="Our (Fine-tuned)", color='green', linewidth=2)

    if 0 < x_break_even < max(x):
        ax.axvline(
            x=x_break_even, color='red', linestyle='--', alpha=0.9,
            label=f'Zero-cost Break-Even ({x_break_even:.1f} solutions)'
        )
    if 0 < x_ft_break_even < max(x):
        ax.axvline(
            x=x_ft_break_even, color='purple', linestyle=':', alpha=0.9,
            label=f'Fine-tuned Break-Even ({x_ft_break_even:.1f} solutions)'
        )

    ax.set_xlabel("Number of Solutions Evaluated (N)")
    ax.set_ylabel("Total DSE Time (seconds)")
    ax.set_title("DSE Time Comparison")
    ax.legend()
    ax.grid(True)
    ax.set_xlim(0, max(x))
    ax.set_ylim(0)
    
    output_file = "figures/dse_timing_comparison.png"
    plt.tight_layout()
    plt.savefig(output_file, bbox_inches='tight', dpi=300, transparent=True)
    print(f"Plot saved to {output_file}")
    plt.show()