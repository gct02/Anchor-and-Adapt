import re
import os
import json
import xml.etree.ElementTree as ET
from dataclasses import dataclass
from pathlib import Path
from typing import List, Union, Dict, Any, Optional

import numpy as np
from torch import Tensor

from estimator.common.constants import *


@dataclass
class EvalReport:
    indices: List[int]
    preds: Union[Tensor, List[float]]
    targets: Union[Tensor, List[float]]
    errors: Union[Tensor, List[float]]
    smape: float


def extract_achieved_clk(solution_dir) -> float:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        raise -1.0

    if Path(solution_dir / 'reports').is_dir():
        # Filtered solution directory
        xml_path = solution_dir / 'reports/export_impl.xml'
        if xml_path.is_file():
            return parse_timing_xml(xml_path)

        rpt_path = solution_dir / 'reports/impl_timing_summary.rpt'
        if rpt_path.is_file():
            return parse_timing_rpt(rpt_path)
    else:
        # Non-filtered solution directory
        impl_dir = solution_dir / 'impl'
        if not impl_dir.is_dir():
            return -1.0
        
        xml_path = impl_dir / 'report/verilog/export_impl.xml'
        if not xml_path.is_file():
            xml_path = impl_dir / 'verilog/report/vivado_impl.xml'

        if xml_path.is_file():
            return parse_timing_xml(xml_path)

        rpt_path = impl_dir / 'verilog/project.runs/impl_1/bd_0_wrapper_timing_summary_routed.rpt'
        if rpt_path.is_file():
            return parse_timing_rpt(rpt_path)

    return -1.0


def extract_area(solution_dir) -> Dict[str, int]:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        return {key: -1 for key in AREA_METRICS}
    
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
            return {key: -1 for key in AREA_METRICS}
        
        xml_path = impl_dir / 'report/verilog/export_impl.xml'
        if not xml_path.is_file():
            xml_path = impl_dir / 'verilog/report/vivado_impl.xml'

        if xml_path.is_file():
            return parse_area_xml(xml_path)

        rpt_path = impl_dir / 'verilog/project.runs/impl_1/bd_0_wrapper_utilization_placed.rpt'
        if rpt_path.is_file():
            return parse_area_rpt(rpt_path)
        
    return {key: -1 for key in AREA_METRICS}


def extract_dynamic_power(solution_dir) -> float:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        return -1.0
    
    if Path(solution_dir / 'reports').is_dir():
        rpt_path = solution_dir / 'reports/impl_power.rpt'
    else:
        rpt_path = solution_dir / 'impl/verilog/project.runs/impl_1/bd_0_wrapper_power_routed.rpt'

    if not rpt_path.is_file():
        print(f'Power report not found in {solution_dir}')
        return -1.0
    
    with open(rpt_path, "r") as rpt:
        lines = rpt.readlines()

    numeric_pattern = '[-+]? (?: (?: \d* \. \d+ ) | (?: \d+ \.? ) )(?: [Ee] [+-]? \d+ ) ?'
    rx = re.compile(numeric_pattern, re.VERBOSE)

    dynamic_power = -1.0
    for line in lines:
        if line.find('Dynamic (W)') != -1:
            dynamic_power = float((rx.findall(line))[0])
            break

    return dynamic_power


def extract_total_power(solution_dir) -> float:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        return -1.0
    
    if Path(solution_dir / 'reports').is_dir():
        rpt_path = solution_dir / 'reports/impl_power.rpt'
    else:
        rpt_path = solution_dir / 'impl/verilog/project.runs/impl_1/bd_0_wrapper_power_routed.rpt'

    if not rpt_path.is_file():
        print(f'Power report not found in {solution_dir}')
        return -1.0
    
    with open(rpt_path, "r") as rpt:
        lines = rpt.readlines()

    numeric_pattern = '[-+]? (?: (?: \d* \. \d+ ) | (?: \d+ \.? ) )(?: [Ee] [+-]? \d+ ) ?'
    rx = re.compile(numeric_pattern, re.VERBOSE)

    total_power = -1.0
    for line in lines:
        if line.find('Total On-Chip Power (W)') != -1:
            total_power = float((rx.findall(line))[0])
            break

    return total_power


def extract_latency_in_cycles(solution_dir) -> int:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        return -1
    
    if Path(solution_dir / 'reports').is_dir():
        report_dir = Path(solution_dir / 'reports')
    else:
        report_dir = Path(solution_dir / 'syn/report')

    rpt_path = report_dir / 'csynth2.rpt'
    if not rpt_path.is_file(): rpt_path = report_dir / 'csynth.rpt'

    if rpt_path.is_file():
        return parse_cycles_rpt(rpt_path)
    
    xml_path = report_dir / 'csynth.xml'
    if not xml_path.is_file(): xml_path = report_dir / 'synth.xml'

    if xml_path.is_file():
        return parse_cycles_xml(xml_path)

    return -1


def extract_metrics(solution_dir) -> Dict[str, Union[float, int]]:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        metrics = AREA_METRICS + ['dynamic_power', 'achieved_clk', 'cc']
        return {key: -1 for key in metrics}
    
    metric_dict = extract_area(solution_dir)
    metric_dict['achieved_clk'] = extract_achieved_clk(solution_dir)
    metric_dict['dynamic_power'] = extract_dynamic_power(solution_dir)
    metric_dict['cc'] = extract_latency_in_cycles(solution_dir)

    metric_dict['latency'] = metric_dict['cc'] * metric_dict['achieved_clk']
    metric_dict['energy'] = metric_dict['latency'] * metric_dict['dynamic_power']
    metric_dict['edp'] = metric_dict['energy'] * metric_dict['latency']
    
    snru = 0.0
    for m, avail in AVAILABLE_RESOURCES.items():
        util = metric_dict.get(m, -1)
        if util < 0:
            snru = -1.0
            break
        snru += float(util) / avail
    metric_dict['snru'] = snru

    return metric_dict


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
        if resources is None: continue

        module_type = module.get('TYPE', '')

        if module_type == 'function':
            name = module.get('MODULENAME')
        else:
            name = module.get('DISPNAME')

        if name:
            module_area_map[name] = {
                metric: int(resources.get(metric.upper(), 0))
                for metric in AREA_METRICS
            }

    return module_area_map


def extract_array_dim_info(solution_dir):
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        raise FileNotFoundError(f"Solution directory does not exist: {solution_dir}")
    
    if Path(solution_dir / 'reports').is_dir():
        # Filtered solution directory
        xml_path = Path(solution_dir) / 'reports/csynth.xml'
    else:
        # Non-filtered solution directory
        xml_path = Path(solution_dir) / 'syn/report/csynth.xml'

    if not xml_path.is_file():
        raise FileNotFoundError(f'File not found: {xml_path}')
    
    tree = ET.parse(xml_path)
    root = tree.getroot()
    array_dim_info = {}

    for module in root.findall('ModuleInformation/Module'):
        module_name = module.findtext('Name', '')
        pfx = module_name + '/'

        for bind_node in module.findall('BindNodes/BindNode'):
            if bind_node.get('BINDTYPE', '') == 'storage':
                storage_size = bind_node.get('STORAGESIZE', '')
                variable = bind_node.get('VARIABLE', '')
                if not storage_size or not variable: continue

                try:
                    dims = list(map(lambda x: int(x.strip('" \n')), storage_size.split()))
                    dims = dims[1:]
                    if dims[-1] <= 1: dims = dims[:-1]
                    assert len(dims) > 0
                except:
                    continue

                array_dim_info[pfx + variable] = dims

    return array_dim_info


def extract_array_impl_info(solution_dir):
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        raise FileNotFoundError(f"Solution directory does not exist: {solution_dir}")
    
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
    array_impl_map = {}

    for module in root.findall('RtlModules/RtlModule'):
        if module.get('TYPE', '') != 'resource': continue

        bind_node = module.find('BindNode')
        if bind_node is None: continue
        if bind_node.get('BINDTYPE', '') != 'storage': continue

        name = bind_node.get('RTLNAME', '')
        op_type = bind_node.get('OPTYPE', '')
        if name and op_type:
            array_impl_map[name] = op_type

    return array_impl_map


def extract_hls_area_estimates(solution_dir) -> Dict[str, int]:
    solution_dir = Path(solution_dir)
    if not solution_dir.is_dir():
        return {m: -1 for m in AREA_METRICS}
    
    if Path(solution_dir / 'reports').is_dir():
        xml_path = Path(solution_dir) / 'reports/csynth.xml'
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
    return findfloat(root, 'TimingReport/AchievedClockPeriod', -1.0)


def parse_cycles_xml(filepath):
    try:
        tree = ET.parse(filepath)
        root = tree.getroot()
        cc = int(root.findtext('PerformanceEstimates/SummaryOfOverallLatency/Average-caseLatency'))
        return cc
    except:
        return -1
    

def parse_area_rpt(filepath):
    with open(filepath, "r") as rpt:
        lines = rpt.readlines()

    def find_line_containing(search_str):
        for i, line in enumerate(lines):
            if search_str in line: 
                return i
        return -1

    lut_line = find_line_containing('CLB LUTs')
    ff_line = find_line_containing('Register as Flip Flop')
    dsp_line = find_line_containing('DSPs')
    bram_line = find_line_containing('Block RAM Tile')

    integer_pattern = '[+-]?\d+'
    decimal_pattern = '[+-]?\d*\.?\d+'
    rx_int = re.compile(integer_pattern, re.VERBOSE)
    rx_dec = re.compile(decimal_pattern, re.VERBOSE)

    lut = ff = bram = dsp = -1

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

    search_str = 'WNS(ns)'
    idx = 0
    while idx < len(lines):
        if search_str in lines[idx]: break
        idx += 1

    if idx + 2 >= len(lines): 
        return -1.0
    rpt_line = lines[idx + 2]
    
    rx = re.compile('[+-]?\d*\.?\d+', re.VERBOSE)
    rpts = rx.findall(rpt_line)
    if len(rpts) == 0:
        return -1.0
    
    wns = float(rpts[0])
    return TARGET_CLOCK_PERIOD - wns


def parse_cycles_rpt(filepath):
    with open(filepath, "r") as rpt:
        lines = rpt.readlines()

    search_str = "+ Performance & Resource Estimates:"
    idx = 0
    while idx < len(lines):
        if search_str in lines[idx]: break
        idx += 1

    found = False
    while idx < len(lines):
        idx += 1
        line = lines[idx].strip()
        found = line.startswith('|+')
        if found: break

    if not found: return -1

    rpt_cols = lines[idx].split('|')
    if len(rpt_cols) < 5: return -1

    try:
        cc = int(rpt_cols[4].strip())
        return cc
    except:
        return -1


def export_directives_as_tcl(json_path, tcl_path):
    with open(json_path, "r") as f:
        data = json.load(f)
    directives = data.get("HlsSolution", {}).get("DirectiveTcl", [])
    with open(tcl_path, "w") as f:
        f.write("\n".join(directives))


def parse_tcl_directives(tcl_path) -> List[Dict[str, Any]]:
    if not os.path.exists(tcl_path):
        raise ValueError(f"Directives file not found: {tcl_path}")
    
    with open(tcl_path, "r") as f:
        lines = f.readlines()

    directives = []
    for line in lines:
        if line.startswith('set_directive_') and not line.startswith('set_directive_top'):
            directives.append(parse_directive_command(line))

    return directives


def parse_directive_command(directive_cmd: str) -> Dict[str, Any]:
    if not directive_cmd.startswith('set_directive_'): return {}
    tokens = directive_cmd.strip('"\n').split(' ')
    dct_type = tokens[0].replace('set_directive_', '')
    arg_tokens = tokens[1:]

    parsed_args = {}
    parsed_args['directive'] = dct_type
    i = 0

    while i < len(arg_tokens):
        token = arg_tokens[i]
        i += 1
        if token == '': continue

        if token.startswith('-'):
            token = token[1:]

            if token.find('=') != -1:
                key, value = token.split('=')
            elif token == 'off':
                key, value = 'off', 'true'
            else:
                if i < len(arg_tokens):
                    key, value = token, arg_tokens[i]
                    i += 1
                else:
                    key, value = token, 'true'

            value = value.strip('\' \n')
            if key in ['dim', 'factor']: value = int(value)
            elif key == 'off': value = bool(value)
            parsed_args[key] = value

        elif 'location' not in parsed_args:
            parsed_args['location'] = token
            if '/' in token:
                func, loop = token.split('/')
                parsed_args['function'] = func
                parsed_args['label'] = loop
            else:
                parsed_args['function'] = token

        elif dct_type == 'array_partition':
            parsed_args['variable'] = token

    return parsed_args


def extract_early_auto_pipelines(log_lines):
    START_PREFIX = "INFO: [HLS 200-1505] Using flow_target 'vivado'"
    END_PREFIX = "INFO: [HLS 200-111] Finished Compiling Optimization and Transform"
    AUTO_PIPELINE_PREFIX = "INFO: [HLS 214-376] automatically set the pipeline for Loop<"

    start_idx = 0
    for i, line in enumerate(log_lines):
        if START_PREFIX in line:
            start_idx = i

    log_lines = log_lines[start_idx:]
    auto_pipelines = set()

    for line in log_lines:
        if END_PREFIX in line: break
        if AUTO_PIPELINE_PREFIX not in line: continue
        try:
            loop = line.split(AUTO_PIPELINE_PREFIX)[1].split(">")[0].strip()
            auto_pipelines.add(loop)
        except:
            continue

    return list(auto_pipelines)


def parse_predictions(filepath: str) -> EvalReport:
    with open(filepath, 'r') as f:
        lines = f.readlines()

    lines = lines[1:]  # Skip header
    indices, targets, preds, errors = [], [], [], []

    for line in lines:
        index, target, pred, error = line.strip().split(',')
        indices.append(int(index))
        targets.append(float(target))
        preds.append(float(pred))
        errors.append(float(error))

    return EvalReport(
        indices=indices,
        targets=targets,
        preds=preds,
        errors=errors,
        smape=np.mean(errors)
    )


# -------- XML Utils --------

def findint(element: ET.Element, path: str, default=None):
    value = element.find(path)
    if value is not None:
        try:
            value = int(value.text)
            return value
        except ValueError:
            print(f"Warning: Could not convert '{value.text}' to int at path '{path}'")
            return default
    return default


def findfloat(element: ET.Element, path: str, default=None):
    value = element.find(path)
    if value is not None:
        try:
            value = float(value.text)
            return value
        except ValueError:
            print(f"Warning: Could not convert '{value.text}' to float at path '{path}'")
            return default
    return default