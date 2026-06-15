import shutil
from pathlib import Path

IMPL_RPT_DIR = "impl/verilog/project.runs/impl_1"
IR_DIR = ".autopilot/db"

RPT_PATH_MAP = {
    f"{IMPL_RPT_DIR}/bd_0_wrapper_power_routed.rpt": "reports/impl_power.rpt",
    f"{IMPL_RPT_DIR}/bd_0_wrapper_utilization_placed.rpt": "reports/impl_utilization_placed.rpt",
    f"{IMPL_RPT_DIR}/bd_0_wrapper_timing_summary_routed.rpt": "reports/impl_timing_summary.rpt",
    f"{IMPL_RPT_DIR}/runme.log": "reports/impl_runme.log",
    "impl/reports/verilog/export_impl.xml": "reports/export_impl.xml",
    "impl/reports/verilog/export_impl.rpt": "reports/export_impl.rpt",
    "impl/reports/verilog/export_syn.xml": "reports/export_syn.xml",
    "impl/reports/verilog/export_syn.rpt": "reports/export_syn.rpt",
    "impl/verilog/report/vivado_impl.xml": "reports/vivado_impl.xml",
    "impl/verilog/report/vivado_syn.xml": "reports/vivado_syn.xml",
    "impl/verilog/project.runs/synth_1/runme.log": "reports/synth_runme.log",
    "impl/export.dcp": "export.dcp",
    "syn/report/csynth.rpt": "reports/synth.rpt",
    "syn/report/csynth.xml": "reports/synth.xml"
}


def create_filtered_dataset(src_dir: Path, dst_dir: Path):
    """
    Create a "filtered" version of the dataset, containing only files that are essential 
    for training the estimator.
    
    Args:
        src_path (Path): Path to the source (complete) dataset.
        dst_path (Path): Path where the filtered dataset will be created.
    """
    src_dir, dst_dir = Path(src_dir), Path(dst_dir)

    if not src_dir.is_dir():
        raise FileNotFoundError(f"Directory not found: {src_dir}.")
    
    dst_dir.mkdir(parents=True, exist_ok=True)
    
    for sol_dir in src_dir.iterdir():
        if not sol_dir.is_dir(): continue 
        if not sol_dir.name.startswith("solution"): continue

        sol = sol_dir.name
        dst_sol_dir = dst_dir / sol
        dst_sol_dir.mkdir(parents=True, exist_ok=True)

        ir_dir = sol_dir / IR_DIR
        if not ir_dir.is_dir():
            print(f"Warning: IR directory {ir_dir} not found.")
            continue

        impl_dir = sol_dir / IMPL_RPT_DIR
        if not impl_dir.is_dir():
            print(f"Warning: Implementation report directory {impl_dir} not found.")
            continue

        path_map = {
            **RPT_PATH_MAP,
            f"{sol}_data.json": f"{sol}_data.json",
            f"{sol}.log": f"{sol}.log",
            f"{sol}.directive": f"{sol}.directive",
            "directives.tcl": "directives.tcl"
        }
        for file in ir_dir.glob("*.bc"):
            path_map[f"{IR_DIR}/{file.name}"] = f"IRs/{file.name}"
        for file in ir_dir.glob("*.adb"):
            path_map[f"{IR_DIR}/{file.name}"] = f"IRs/{file.name}"

        for src, dest in path_map.items():
            src_path = sol_dir / src
            if src_path.exists():
                dest_path = dst_sol_dir / dest
                dest_path.parent.mkdir(parents=True, exist_ok=True)
                shutil.copy(src_path, dest_path)
            else:
                print(f"Warning: {src_path} not found on source directory.")


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Create a filtered version of the source dataset.")
    parser.add_argument("src_dir", type=str, help="Path to the complete dataset.")
    parser.add_argument("dst_dir", type=str, help="Path where the filtered dataset will be created.")
    args = parser.parse_args()
    
    create_filtered_dataset(args.src_dir, args.dst_dir)