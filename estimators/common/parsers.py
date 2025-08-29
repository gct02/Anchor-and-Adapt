import re
import os
import json
import xml.etree.ElementTree as ET
from pathlib import Path
from typing import List, Tuple, Union, Dict

from estimators.common.xml_utils import findint, findfloat

# Total number of resources available on the target device
# (xcu50-fsvh2104-2-e)
AVAILABLE_RESOURCES = {
    "lut": 871680,
    "ff": 1743360,
    "dsp": 5952,
    "bram": 2688
}
TARGET_CLOCK_PERIOD = 8.0  # Default target clock period in ns

AREA_METRICS = ['lut', 'ff', 'dsp', 'bram']
TIMING_METRICS = ['wns', 'tns', 'achieved_clk', 'cc']
POWER_METRICS = ['total_power', 'dynamic_power', 'static_power']


def extract_timing_metrics(solution_dir) -> Dict[str, Union[float, int]]:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        raise ValueError(f"Solution directory does not exist: {solution_dir}")
    
    report = None

    if Path(solution_dir / 'reports').is_dir():
        # Filtered solution directory
        xml_path = solution_dir / 'reports/export_impl.xml'
        if xml_path.is_file():
            report = parse_timing_xml(xml_path)
        else:
            rpt_path = solution_dir / 'reports/impl_timing_summary.rpt'
            if rpt_path.is_file():
                report = parse_timing_rpt(rpt_path)
    else:
        # Non-filtered solution directory
        impl_dir = solution_dir / 'impl'
        if not impl_dir.is_dir():
            raise ValueError(f"Impl directory does not exist: {impl_dir}")
        
        xml_path = impl_dir / 'report/verilog/export_impl.xml'
        if not xml_path.is_file():
            xml_path = impl_dir / 'verilog/report/vivado_impl.xml'

        if xml_path.is_file():
            report = parse_timing_xml(xml_path)
        else:
            rpt_path = impl_dir / 'verilog/project.runs/impl_1/bd_0_wrapper_timing_summary_routed.rpt'
            if rpt_path.is_file():
                report = parse_timing_rpt(rpt_path)
        
    # If no reports found, return default values
    if report is None:
        return {
            'wns': -1.0,
            'tns': -1.0,
            'target_clk': TARGET_CLOCK_PERIOD,
            'achieved_clk': -1.0,
            'cc': -1
        }
    
    report['cc'] = extract_hls_cc_report(solution_dir)
    return report


def extract_area_metrics(solution_dir) -> Dict[str, int]:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        raise ValueError(f"Solution directory does not exist: {solution_dir}")
    
    if Path(solution_dir / 'reports').is_dir():
        # Filtered solution directory
        xml_path = solution_dir / 'reports/export_impl.xml'
        if xml_path.is_file():
            return parse_area_xml(xml_path)
        
        rpt_path = solution_dir / 'reports/impl_utilization_placed.rpt'
        if rpt_path.is_file():
            return parse_area_rpt(rpt_path)
    else:
        # Non-filtered solution directory
        impl_dir = solution_dir / 'impl'
        if not impl_dir.is_dir():
            raise ValueError(f"Impl directory does not exist: {impl_dir}")
        
        xml_path = impl_dir / 'report/verilog/export_impl.xml'
        if not xml_path.is_file():
            xml_path = impl_dir / 'verilog/report/vivado_impl.xml'
        if xml_path.is_file():
            return parse_area_xml(xml_path)

        rpt_path = impl_dir / 'verilog/project.runs/impl_1/bd_0_wrapper_utilization_placed.rpt'
        if rpt_path.is_file():
            return parse_area_rpt(rpt_path)
        
    # If no reports found, return default values
    return {m: -1 for m in AREA_METRICS}


def extract_hls_cc_report(solution_dir) -> Dict[str, int]:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        raise ValueError(f"Solution directory does not exist: {solution_dir}")
    
    if Path(solution_dir / 'reports').is_dir():
        xml_path = Path(solution_dir) / 'reports/csynth.xml'
    else:
        xml_path = Path(solution_dir) / 'syn/report/csynth.xml'

    if not xml_path.is_file():
        print(f'CC report not found in {solution_dir}')
        return -1

    tree = ET.parse(xml_path)
    root = tree.getroot()
    cc = root.findtext('PerformanceEstimates/SummaryOfOverallLatency/Average-caseLatency')

    if cc is None or cc == 'undef' or not cc.isdigit():
        print(f'CC value not found or invalid in {xml_path}')
        return -1

    return int(cc)


def extract_hls_area_estimates(solution_dir) -> Dict[str, int]:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        raise ValueError(f"Solution directory does not exist: {solution_dir}")
    
    if Path(solution_dir / 'reports').is_dir():
        xml_path = Path(solution_dir) / 'reports/csynth.xml'
        if not xml_path.is_file():
            xml_path = Path(solution_dir) / 'reports/synth.xml'
    else:
        xml_path = Path(solution_dir) / 'syn/report/csynth.xml'

    if not xml_path.is_file():
        print(f'Area estimates report not found in {solution_dir}')
        return {m: -1 for m in AREA_METRICS}

    tree = ET.parse(xml_path)
    root = tree.getroot()

    area_estimates = root.find('AreaEstimates/Resources')
    if area_estimates is None:
        print(f'Area estimates not found in {xml_path}')
        return {m: -1 for m in AREA_METRICS}
    
    return {
        'lut': findint(area_estimates, 'LUT', -1),
        'ff': findint(area_estimates, 'FF', -1),
        'dsp': findint(area_estimates, 'DSP', -1),
        'bram': findint(area_estimates, 'BRAM_18K', -1)
    }


def extract_power_report(solution_dir) -> Dict[str, float]:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        raise ValueError(f"Solution directory does not exist: {solution_dir}")
    
    if Path(solution_dir / 'reports').is_dir():
        rpt_path = solution_dir / 'reports/impl_power.rpt'
    else:
        rpt_path = solution_dir / 'impl/verilog/project.runs/impl_1/bd_0_wrapper_power_routed.rpt'

    if not rpt_path.is_file():
        print(f'Power report not found in {solution_dir}')
        return {m: -1.0 for m in POWER_METRICS}
    
    with open(rpt_path, "r") as rpt:
        lines = rpt.readlines()

    numeric_pattern = '[-+]? (?: (?: \d* \. \d+ ) | (?: \d+ \.? ) )(?: [Ee] [+-]? \d+ ) ?'
    rx = re.compile(numeric_pattern, re.VERBOSE)

    total_power = dynamic_power = static_power = -1.0
    for line in lines:
        if line.find('Total On-Chip Power (W)') != -1:
            total_power = float((rx.findall(line))[0])
        if line.find('Dynamic (W)') != -1:
            dynamic_power = float((rx.findall(line))[0])
        if line.find('Device Static (W)') != -1:
            static_power = float((rx.findall(line))[0])

    return {
        'total_power': total_power, 
        'dynamic_power': dynamic_power, 
        'static_power': static_power
    }


def extract_metrics(solution_dir) -> Dict[str, Union[float, int]]:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        raise ValueError(f"Solution directory does not exist: {solution_dir}")
    
    area_metrics = extract_area_metrics(solution_dir)
    timing_metrics = extract_timing_metrics(solution_dir)
    power_metrics = extract_power_report(solution_dir)
    
    metrics = {}
    metrics.update(area_metrics)
    metrics.update(timing_metrics)
    metrics.update(power_metrics)

    metrics['snru'] = compute_snru(area_metrics)

    achieved_clk = timing_metrics.get('achieved_clk', -1.0)
    cc = timing_metrics.get('cc', -1)
    time = achieved_clk * cc if achieved_clk > 0.0 and cc > 0 else -1.0
    metrics['time'] = time

    return metrics


def extract_per_module_area(solution_dir):
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        raise ValueError(f"Solution directory does not exist: {solution_dir}")
    
    if Path(solution_dir / 'reports').is_dir():
        # Filtered solution directory
        xml_path = Path(solution_dir) / 'reports/export_impl.xml'
    else:
        # Non-filtered solution directory
        xml_path = Path(solution_dir) / 'impl/report/verilog/export_impl.xml'
        if not xml_path.is_file():
            xml_path = Path(solution_dir) / 'impl/verilog/report/vivado_impl.xml'

    if not xml_path.is_file():
        print(f'Utilization XML report not found in {solution_dir}')
        return {}
    
    tree = ET.parse(xml_path)
    root = tree.getroot()

    module_area_map = {}
    for module in root.findall('RtlModules/RtlModule'):
        resources = module.find('Resources')
        if resources is None:
            continue

        module_type = module.get('TYPE', '')

        if module_type == 'function':
            module_name = module.get('MODULENAME')
        elif module_type == 'resource':
            module_name = module.get('DISPNAME')
        else:
            depth = int(module.get('DEPTH', 0))
            if depth > 1:
                module_name = module.get('DISPNAME')
            else:
                module_name = module.get('MODULENAME')

        if not module_name:
            continue

        module_area_map[module_name] = {
            metric: int(resources.get(metric.upper(), 0))
            for metric in AREA_METRICS
        }

    return module_area_map


def compute_snru(area_util: Dict[str, int]) -> float:
    snru = 0
    for res, avail in AVAILABLE_RESOURCES.items():
        util = area_util.get(res, -1)
        if util < 0:
            print(f"Resource {res} utilization is missing or negative.")
            return -1.0
        snru += (float(util) * 100.0) / avail
    return snru


def parse_area_xml(filepath):
    tree = ET.parse(filepath)
    root = tree.getroot()
    return {
        'lut': findint(root, 'AreaReport/Resources/LUT', -1),
        'bram': findint(root, 'AreaReport/Resources/BRAM', -1),
        'ff': findint(root, 'AreaReport/Resources/FF', -1),
        'dsp': findint(root, 'AreaReport/Resources/DSP', -1),
    }


def parse_timing_xml(filepath):
    tree = ET.parse(filepath)
    root = tree.getroot()
    return {
        'wns': findfloat(root, 'TimingReport/WNS_FINAL', -1.0),
        'tns': findfloat(root, 'TimingReport/TNS_FINAL', -1.0),
        'achieved_clk': findfloat(root, 'TimingReport/AchievedClockPeriod', -1.0)
    }


def parse_area_rpt(filepath):
    integer_pattern = '[+-]?\d+'
    decimal_pattern = '[+-]?\d*\.?\d+'
    rx_int = re.compile(integer_pattern, re.VERBOSE)
    rx_dec = re.compile(decimal_pattern, re.VERBOSE)
        
    with open(filepath, "r") as rpt:
        lines = rpt.readlines()

    lut_line = find_line_containing(lines, 'CLB LUTs')
    ff_line = find_line_containing(lines, 'Register as Flip Flop')
    dsp_line = find_line_containing(lines, 'DSPs')
    bram_line = find_line_containing(lines, 'Block RAM Tile')

    lut = bram = ff = dsp = -1

    if lut_line != -1:
        rpts = rx_int.findall(lines[lut_line])
        if rpts:
            lut = int(rpts[0])
    if ff_line != -1:
        rpts = rx_int.findall(lines[ff_line])
        if rpts:
            ff = int(rpts[0])
    if dsp_line != -1:
        rpts = rx_int.findall(lines[dsp_line])
        if rpts:
            dsp = int(rpts[0])
    if bram_line != -1:
        rpts = rx_dec.findall(lines[bram_line])
        if rpts: 
            # This value is multiplied by 2 in the XML reports but not in the '.rpt', 
            # so we multiply it here
            bram = int(float(rpts[0]) * 2) 
        
    return {'lut': lut, 'ff': ff, 'dsp': dsp, 'bram': bram}


def parse_timing_rpt(filepath):
    with open(filepath, "r") as rpt:
        lines = rpt.readlines()

    report = {
        'wns': -1.0,
        'tns': -1.0,
        'achieved_clk': -1.0
    }
    start_idx = find_line_containing(lines, 'WNS(ns)', 'TNS(ns)')
    if start_idx == -1 or start_idx + 2 >= len(lines):
        return report
    
    rx = re.compile('[+-]?\d*\.?\d+', re.VERBOSE)
    
    rpt_line = lines[start_idx + 2]
    rpts = rx.findall(rpt_line)
    if len(rpts) < 2:
        return report
    
    report['wns'] = float(rpts[0])
    report['tns'] = float(rpts[1])
    report['achieved_clk'] = TARGET_CLOCK_PERIOD - report['wns']
    return report


def find_line_containing(lines: List[str], *search_string) -> int:
    for i, line in enumerate(lines):
        if all(s in line for s in search_string):
            return i
    return -1


def extract_auto_dcts_from_log(hls_log_path):
    AUTO_INLINE_CODE = '[HLS 214-178]'
    AUTO_PIPE_CODE = '[HLS 214-376]'
    AUTO_LF_CODE = '[XFORM 203-541]'
    FINISHED_OPT_MESSAGE = '[HLS 200-111] Finished Compiling Optimization and Transform'

    with open(hls_log_path, "r") as f:
        lines = f.readlines()

    auto_dcts = {
        "inline": set(),
        "pipeline": set(),
        "loop_flatten": set()
    }

    for line in lines:
        if FINISHED_OPT_MESSAGE in line:
            break

        if AUTO_INLINE_CODE in line:
            if 'Inlining function \'' not in line:
                continue
            function = line.split('Inlining function \'')[1].split('\'')[0].strip()
            auto_dcts['inline'].add(function)

        elif AUTO_PIPE_CODE in line:
            if 'automatically set the pipeline for Loop<' not in line:
                continue
            loop = line.split('automatically set the pipeline for Loop<')[1].split('>')[0].strip()
            auto_dcts['pipeline'].add(loop)

        elif AUTO_LF_CODE in line:
            if 'Flattening a loop nest \'' not in line or 'in function \'' not in line:
                continue
            loop = line.split('Flattening a loop nest \'')[1].split('\'')[0].strip()
            function = line.split('in function \'')[1].split('\'')[0].strip()
            auto_dcts['loop_flatten'].add((loop, function))

    return auto_dcts 


def export_directives_as_tcl(
    solution_data_json_path: Union[str, Path],
    output_path: Union[str, Path]
):
    with open(solution_data_json_path, "r") as f:
        data = json.load(f)
    directives = data["HlsSolution"]["DirectiveTcl"]
    with open(output_path, "w") as f:
        directives = "\n".join(directives)
        f.write(directives)


def parse_tcl_directives(dct_tcl_path) -> List[Tuple[str, Dict[str, str]]]:
    if not os.path.exists(dct_tcl_path):
        raise ValueError(f"Directives file not found: {dct_tcl_path}")
    with open(dct_tcl_path, "r") as f:
        lines = f.readlines()
    directives = []
    for line in lines:
        if line.startswith('set_directive_') and not line.startswith('set_directive_top'):
            directives.append(parse_directive_cmd(line))
    return directives


def parse_directive_cmd(directive_cmd) -> Tuple[str, Dict[str, str]]:
    cmd = directive_cmd.split(' ')[0].split('set_directive_')[1]
    args = directive_cmd.split(' ')[1:]
    parsed_args = parse_directive_options(args)
    return cmd, parsed_args


def parse_directive_options(dct_args: List[str]) -> Dict[str, str]:
    parsed_args = {}

    i = 0
    while i < len(dct_args):
        if not dct_args[i]:
            i += 1
            continue
        if dct_args[i].startswith('-'):
            if dct_args[i].find('=') != -1:
                key, value = dct_args[i].split('=')
                parsed_args[key[1:]] = value
            elif dct_args[i] == '-off':
                parsed_args['off'] = "true"
            else:
                parsed_args[dct_args[i][1:]] = dct_args[i+1]
                i += 1
        elif 'location' not in parsed_args:
            parsed_args['location'] = dct_args[i]
        else:
            parsed_args['variable'] = dct_args[i]
        i += 1

    for key, args in parsed_args.items():
        parsed_args[key] = args.strip('" \n')

    return parsed_args
