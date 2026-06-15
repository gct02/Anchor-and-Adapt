import textwrap
from pathlib import Path
from typing import List, Union, Optional


def generate_project_tcl_script(
    project_path: Union[str, Path],
    source_files: List[Union[str, Path]],
    top_function: str,
    solution_name: str,
    output_script_path: Union[str, Path],
    directive_tcl_path: Optional[Union[str, Path]] = None,
    part: str = 'xcu50-fsvh2104-2-e',
    clock_period: Union[int, float] = 8
):
    """
    Generates a Tcl script for a Vivado/Vitis HLS project.

    Args:
        project_path (Union[str, Path]): Path to the project directory.
        source_files (List[Union[str, Path]]): A list of source file paths.
        top_function (str): The name of the top-level function for synthesis.
        solution_name (str): The name of the solution to create.
        output_script_path (Union[str, Path]): The path to save the generated Tcl script.
        directive_tcl_path (Optional[Union[str, Path]], optional): Path to a Tcl script 
            with directives. Defaults to None.
        part (str, optional): The target FPGA part number. Defaults to 'xcu50-fsvh2104-2-e'.
        clock_period (Union[int, float], optional): The target clock period (in ns). Defaults to 8.
    """
    project_path = Path(project_path)
    output_script_path = Path(output_script_path)
    processed_sources = ' '.join([Path(f).as_posix() for f in source_files])

    source_directives_cmd = ''
    if directive_tcl_path:
        source_directives_cmd = f"source {Path(directive_tcl_path).as_posix()}"

    tcl_script = textwrap.dedent(f"""
        open_project "{project_path.as_posix()}"
        set_top "{top_function}"
        add_files {{{processed_sources}}}
        open_solution -reset "{solution_name}"
        set_part {{{part}}}
        create_clock -period {clock_period} -name default
        config_array_partition -throughput_driven off
        {source_directives_cmd}
        csynth_design
        export_design -flow impl -format syn_dcp -rtl verilog
        exit
    """)

    output_script_path.parent.mkdir(parents=True, exist_ok=True)
    output_script_path.write_text(tcl_script)