import shutil
from pathlib import Path
from typing import Union


def collect_adb(
    dataset_dir: Union[str, Path], 
    output_dir: Union[str, Path],
    verbose: bool = False
):
    dataset_dir = Path(dataset_dir)
    output_dir = Path(output_dir)

    if not dataset_dir.is_dir():
        raise FileNotFoundError(f"Directory not found: {dataset_dir}")
    
    output_dir.mkdir(parents=True, exist_ok=True)

    for solution_dir in dataset_dir.iterdir():
        if not solution_dir.is_dir() or not solution_dir.name.startswith("solution"):
            continue

        ir_dir = solution_dir / ".autopilot/db"
        if not ir_dir.exists():
            if verbose:
                print(f"Skipping {solution_dir.name}: .autopilot/db directory does not exist.")
            continue

        adb_files = list(ir_dir.glob("*.adb"))
        if not adb_files:
            if verbose:
                print(f"No .adb files found in {solution_dir.name}.")
            continue

        output_solution_dir = output_dir / solution_dir.name
        output_ir_dir = output_solution_dir / "IRs"
        output_ir_dir.mkdir(parents=True, exist_ok=True)

        for adb_file in adb_files:
            if '.bind' in adb_file.name or '.sched' in adb_file.name:
                continue
            output_file = output_ir_dir / adb_file.name
            shutil.copy(adb_file, output_file)

        if verbose:
            print(f"Collected {len(adb_files)} .adb files from "
                  f"{solution_dir.name} to {output_ir_dir}.")


if __name__ == "__main__":
    import argparse
    parser = argparse.ArgumentParser(description="Collect HLS .adb files from a dataset.")
    parser.add_argument("dataset_dir", type=str, help="Path to the dataset directory containing .adb files.")
    parser.add_argument("output_dir", type=str, help="Path to save the collected .adb files.")
    parser.add_argument("-v", "--verbose", action="store_true", help="Enable verbose output.")
    args = parser.parse_args()
    collect_adb(args.dataset_dir, args.output_dir, args.verbose)