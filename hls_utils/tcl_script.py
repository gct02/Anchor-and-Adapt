from string import Template

TEMPLATE = """open_project $PRJ_NAME
add_files { $SRC_FILES }
set_top $TOP_FN
open_solution -reset $SOL_NAME
config_array_partition -throughput_driven off
set_part $DEVICE
create_clock -period $CLOCK_PERIOD -name default
$SOURCE_DIRECTIVES
csynth_design
export_design -flow impl -format syn_dcp -rtl verilog
exit
"""


def gen_script(
    prj_path, src_files, top_fn, solution_name, directives_tcl, output_path,
    device='xcu50-fsvh2104-2-e', clock_period='8'
):
    if isinstance(src_files, list):
        src_files = ' '.join(src_files)

    substitutions = {
        'PRJ_NAME': prj_path,
        'SRC_FILES': src_files,
        'TOP_FN': top_fn,
        'SOL_NAME': solution_name,
        'SOURCE_DIRECTIVES': f'source {directives_tcl}',
        'DEVICE': device,
        'CLOCK_PERIOD': str(clock_period)
    }
    template = Template(TEMPLATE)
    script = template.substitute(substitutions)

    with open(output_path, 'w') as f:
        f.write(script)

