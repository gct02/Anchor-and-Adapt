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
    prj_path, src_files, top_fn, 
    solution_name='solution0', 
    directives_tcl=None, 
    output_path='hls_utils/script.tcl', 
    device='xcu50-fsvh2104-2-e', 
    clock_period='8'
):
    if isinstance(src_files, list):
        src_files = ' '.join(src_files)

    substitutions = {
        'PRJ_NAME': prj_path,
        'SRC_FILES': src_files,
        'TOP_FN': top_fn,
        'SOL_NAME': solution_name,
        'SOURCE_DIRECTIVES': f'source {directives_tcl}' if directives_tcl else '',
        'DEVICE': device,
        'CLOCK_PERIOD': str(clock_period)
    }
    template = Template(TEMPLATE)
    script = template.substitute(substitutions)

    with open(output_path, 'w') as f:
        f.write(script)


if __name__ == '__main__':
    import argparse

    parser = argparse.ArgumentParser()

    parser.add_argument('-p', '--prj-path', required=True, type=str)
    parser.add_argument('-c', '--sources', nargs='+', type=str)
    parser.add_argument('-t', '--top-fn', required=True, type=str)
    parser.add_argument('-s', '--solution-name', required=False, default='solution0')
    parser.add_argument('-o', '--output-path', required=False, default='hls_utils/script.tcl')
    parser.add_argument('-d', '--directives-path', required=False, default=None)

    args = parser.parse_args()

    gen_script(
        args.prj_path, args.sources, args.top_fn, 
        solution_name=args.solution_name, 
        directives_tcl=args.directives_path,
        output_path=args.output_path
    )
