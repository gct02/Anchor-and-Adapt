import subprocess
import time
import psutil
import json
import shutil
from pathlib import Path
from random import randint

import numpy as np

from estimators.common.parsers import parse_directive_cmd
from hls_utils.tcl_script import gen_script

from estimators.common.parsers import (
    AVAILABLE_RESOURCES,
    parse_directive_cmd
)
from estimators.area.graph import find_array_node, find_region_node

BENCH_INFO_PATH = 'data/benchmark_info.json'
VITIS_SCRIPT_PATH = './hls_utils/run_vitis.sh'

MAX_LUT = float(AVAILABLE_RESOURCES['lut']) * 0.8
MAX_FF = float(AVAILABLE_RESOURCES['ff']) * 0.8
AREA_THRESHOLD = 0.024  # Computed with metrics from our dataset

NUM_UNROLLS = 2
NUM_PARTITIONS = 2
NUM_PIPELINES = 1

NUM_UNROLLS_LARGE = 4
NUM_PARTITIONS_LARGE = 3
NUM_PIPELINES_LARGE = 3

NUM_COMPLEX_SOLUTIONS = 4


class DatasetGenerator:
    def __init__(self, dataset_dir, benchmark, kernel_graph, base_metrics, run_timeout=3600):
        with open(BENCH_INFO_PATH, 'r') as f:
            bench_info_dict = json.load(f)

        if benchmark not in bench_info_dict:
            raise ValueError(f'Could not find info for benchmark {benchmark}.')
        
        self.benchmark_info = bench_info_dict[benchmark]
        self.top_level_function = self.benchmark_info['top_level']
        self.run_timeout = run_timeout if run_timeout > 0 else 1e6
        self.kernel_graph = kernel_graph

        self.control_tree = {}
        self.num_successful_runs = 0
        self.solution_index = 0
        self.project_dir = Path(dataset_dir) / benchmark
        self.project_dir.mkdir(parents=True, exist_ok=True)
        
        self.prj_state_path = self.project_dir / 'prj_state.json'

        self._temp_dir = self.project_dir / '.temp'
        self._temp_dir.mkdir(parents=True, exist_ok=True)

        self._script_tcl_path = self._temp_dir / 'script.tcl'
        self._directives_tcl_path = self._temp_dir / 'directives.tcl'

        lut = float(base_metrics['lut'])
        ff = float(base_metrics['ff'])
        area_norm = (lut / MAX_LUT) + (ff / MAX_FF)
        self.is_large_kernel = area_norm > AREA_THRESHOLD

        if self.is_large_kernel:
            self.num_constrained_solutions = (
                NUM_UNROLLS_LARGE + 
                NUM_PIPELINES_LARGE + 
                NUM_PARTITIONS_LARGE
            )
            self.num_solutions = self.num_constrained_solutions
        else:
            self.num_constrained_solutions = (
                NUM_UNROLLS + NUM_PIPELINES + NUM_PARTITIONS
            )
            self.num_solutions = self.num_constrained_solutions + NUM_COMPLEX_SOLUTIONS

        with open(self.benchmark_info['directives_path'], 'r') as f:
            domain = json.load(f)

        self._directive_map = {
            'pipeline': {},
            'unroll': {},            
            'array_partition': {}
        }

        directive_groups = {}
        for group_label, group_data in domain['directives'].items():
            directives = group_data.get('possible_directives', [])
            directives = [dct.strip('\n') for dct in directives]

            disabled_dct = None
            for i, dct in enumerate(directives):
                if dct == '' or '-off' in dct:
                    disabled_dct = (i, dct)
                    break

            if disabled_dct is not None:
                del directives[disabled_dct[0]]
                directives = [disabled_dct[1]] + directives
            else:
                directives.insert(0, '')

            directive_groups[group_label] = {'possible_directives': directives}
            directive_groups[group_label].update({
                key: value for key, value in group_data.items() 
                if key != 'possible_directives'
            })

            dct_type = group_data.get('directive_type')
            function = group_data.get('function')
            label = group_data.get('label') if dct_type != 'array_partition' else group_data.get('variable')

            if (dct_type in {'pipeline', 'unroll', 'array_partition'}
                and function and label):
                self._directive_map[dct_type][(function, label)] = directives

        self.domain = {
            'directives': directive_groups,
            'nested_loops': domain.get('nested_loops', [])
        }
        
        self._separate_arrays()
        self._separate_unroll_loops()
        self._separate_pipeline_loops()

        self._select_base_directives()

    def run(self, clear_previous_runs: bool = True):
        if clear_previous_runs:
            shutil.rmtree(self.project_dir, ignore_errors=True)
            self.project_dir.mkdir(parents=True, exist_ok=True)
            self._temp_dir.mkdir(parents=True, exist_ok=True)
            self.solution_index = 1
            self.num_successful_runs = 0
            self.control_tree = {}
        else:
            self._handle_resume()

        for i in range(self.num_constrained_solutions):
            dct_config = [self._base_directives[i]]

            self._save_directives_as_tcl(dct_config)
            solution_dir = self.project_dir / f'solution{self.solution_index}'
            solution_dir.mkdir(parents=True, exist_ok=True)

            gen_script(
                self.project_dir, self.benchmark_info['source_files'],
                self.benchmark_info['top_level'], solution_dir.name,
                self._directives_tcl_path, self._script_tcl_path,
            )
            if self._gen_solution(solution_dir):
                self.num_successful_runs += 1
                self.solution_index += 1
                self._save_project_state()

        if not self.is_large_kernel:
            while self.num_successful_runs < self.num_solutions:
                dct_config = self._gen_complex_config()
                if not dct_config:
                    print("All valid configurations have been exhausted.")
                    break
                dct_config = list(dct_config.values())

                self._save_directives_as_tcl(dct_config)
                solution_dir = self.project_dir / f'solution{self.solution_index}'
                solution_dir.mkdir(parents=True, exist_ok=True)

                gen_script(
                    self.project_dir, self.benchmark_info['source_files'],
                    self.benchmark_info['top_level'], solution_dir.name,
                    self._directives_tcl_path, self._script_tcl_path,
                )
                if self._gen_solution(solution_dir):
                    self.num_successful_runs += 1
                    self.solution_index += 1
                    self._save_project_state()

        # Clean up temporary files
        if self._temp_dir.is_dir():
            shutil.rmtree(self._temp_dir, ignore_errors=True)

    def _gen_solution(self, solution_dir):
        try:
            print(f'\n** Starting {solution_dir.name} run **\n')

            proc = subprocess.Popen(
                [f'{VITIS_SCRIPT_PATH} {self._script_tcl_path}'],
                shell=True
            )
            start_time = time.time()
            parent_proc = psutil.Process(proc.pid)

            while parent_proc.is_running() and parent_proc.status() != psutil.STATUS_ZOMBIE:
                time.sleep(30)

                if self._check_run_completion(solution_dir):
                    print(f'\n** Run completed successfully ({solution_dir.name}) **\n')
                    shutil.copy(self._directives_tcl_path, solution_dir / 'directives.tcl')
                    return True

                if (time.time() - start_time) > self.design_flow_timeout:
                    print(f'\n** Run exceeded time limit ({solution_dir.name}) **\n')
                    for child in parent_proc.children(recursive=True):
                        child.kill()
                    parent_proc.kill()
                    shutil.rmtree(solution_dir, ignore_errors=True)
                    return False

            # Final check in case the process finished between sleep intervals
            if self._check_run_completion(solution_dir):
                print(f'\n** Run completed successfully ({solution_dir.name}) **\n')
                shutil.copy(self._directives_tcl_path, solution_dir / 'directives.tcl')
                return True
            else:
                print(f'\n** Run did not complete successfully ({solution_dir.name})**\n')
                shutil.rmtree(solution_dir, ignore_errors=True)
                return False

        except Exception as e:
            print(e)
            shutil.rmtree(solution_dir, ignore_errors=True)
            return False

    def _handle_resume(self):
        if not self.prj_state_path.is_file():
            self._config_prj_state_from_previous_runs()
            self._save_project_state()
            return

        with open(self.prj_state_path, 'r') as f:
            prj_state = json.load(f)

        self.control_tree = self._decode_config_tree(prj_state.get('control_tree', {}))
        self.num_successful_runs = int(prj_state.get('num_successful_runs', 0))
        self.solution_index = self.num_successful_runs + 1

    def _check_run_completion(self, solution_dir: Path):
        impl_dir = solution_dir / 'impl'
        if not impl_dir.is_dir():
            return False
        
        run_dir = impl_dir / 'verilog/project.runs/impl_1'
        if not run_dir.is_dir():
            return False
        
        power_rpt_file = run_dir / 'bd_0_wrapper_power_routed.rpt'
        util_rpt_file = run_dir / 'bd_0_wrapper_utilization_placed.rpt'
        time_rpt_file = run_dir / 'bd_0_wrapper_timing_summary_routed.rpt'
        return power_rpt_file.exists() and util_rpt_file.exists() and time_rpt_file.exists()
    
    def _gen_complex_config(self):
        node = self.control_tree
        dct_config = {}
        is_new = False

        for group_label, group_data in self.domain['directives'].items():
            directives = group_data['possible_directives']
            directive_type = group_data['directive_type']

            if directive_type == 'array_partition':
                function = group_data['function']
                label = group_data['variable']
                if (function, label) in self._relevant_arrays:
                    idx = randint(1, len(directives) - 1)
                    if idx not in node:
                        is_new = True
                        node[idx] = {}
                    node = node[idx]
                    continue

            idx = randint(0, len(directives) - 1)
            dct = directives[idx]

            if idx != 0:
                if (self._is_complex_directive(group_label, dct) or 
                    self._is_conflicting_directive(dct_config, group_label, dct)):
                    idx = 0
                    dct_config[group_label] = directives[idx]
                else:
                    dct_config[group_label] = dct
                    if (self._is_restricted_design(dct_config) or 
                        self._is_redundant_design(dct_config)):
                        idx = 0
                        dct_config[group_label] = directives[idx]
            else:
                dct_config[group_label] = dct

            if idx not in node:
                is_new = True
                node[idx] = {}
            node = node[idx]

        return dct_config if is_new else None
    
    def _is_redundant_design(self, dct_config):
        label_dct_dict = self._build_label_dct_dict(dct_config)

        for loop in self.domain['nested_loops']:
            inner_loop = loop
            function = loop['function']
            pipeline_loop = None

            while (nest := inner_loop.get('nest')):
                label = inner_loop['label']
                key = f"{function}/{label}"
                if (config := label_dct_dict.get(key)) is None:
                    inner_loop = nest
                    continue

                pipeline_config = config.get('pipeline', '')
                if pipeline_config != '' and '-off' not in pipeline_config:
                    pipeline_loop = inner_loop
                    break

                inner_loop = nest

            if not pipeline_loop:
                continue
            
            inner_loop = pipeline_loop
            while (inner_loop := inner_loop.get('nest')):
                label = inner_loop['label']
                key = f"{function}/{label}"
                if (config := label_dct_dict.get(key)) is None:
                    continue

                pipeline_config = config.get('pipeline', '')
                unroll_config = config.get('unroll', '')
                if ((pipeline_config != '' and '-off' not in pipeline_config)
                    or unroll_config != ''):
                    return True

        return False

    def _is_restricted_design(self, dct_config):
        for key, value in dct_config.items():
            if value == '' or '-off' in value:
                continue
            
            for group_label, group_data in self.domain['directives'].items():
                if key != group_label:
                    dct = dct_config.get(group_label)
                    if not dct or '-off' in dct:
                        continue

                    if key in group_data.get('constraints', []):
                        return True
        return False
    
    def _is_conflicting_directive(self, dct_config, group, new_dct):
        group_data = self.domain['directives'].get(group)
        if not group_data:
            return False
        
        new_dct_type = group_data['directive_type']
        if (new_dct_type not in {'pipeline', 'unroll', 'loop_flatten'} or 
            (new_dct_type == 'unroll' and '-factor' in new_dct) or 
            (new_dct_type == 'pipeline' and '-off' in new_dct) or 
            (new_dct_type == 'loop_flatten' and ('-off' in new_dct or not new_dct))):
            return False
        
        label = group_data.get('label', '')
        function = group_data.get('function', '')
        key = f"{function}/{label}"

        label_dct_dict = self._build_label_dct_dict(dct_config, include_flatten=True)
        dct_dict = label_dct_dict.get(key, {})
        if not dct_dict:
            return False
        
        if new_dct_type == 'unroll':
            # Complete unroll directive would break the target 
            # of any other loop pragmas if applied
            if 'unroll' in dct_dict and dct_dict['unroll'] != '':
                return True
            if 'pipeline' in dct_dict:
                pipeline_dct = dct_dict['pipeline']
                if pipeline_dct != '' and '-off' not in pipeline_dct:
                    return True
            if 'loop_flatten' in dct_dict:
                loop_flatten_dct = dct_dict['loop_flatten']
                if loop_flatten_dct != '' and '-off' not in loop_flatten_dct:
                    return True
        else:
            if 'unroll' in dct_dict:
                unroll_dct = dct_dict['unroll']
                if unroll_dct != '' and '-factor' not in unroll_dct:
                    return True
            
        return False

    def _build_label_dct_dict(self, dct_config, include_flatten=False):
        dct_keys = {'pipeline', 'unroll'}
        if include_flatten:
            dct_keys.add('loop_flatten')

        label_dct_dict = {}
        for group in dct_config:
            group_data = self.domain['directives'][group]
            dct_type = group_data['directive_type']
            if dct_type not in dct_keys:
                continue

            function = group_data.get('function', '')
            target = group_data.get('label', '')
            key = f"{function}/{target}"
            
            if key not in label_dct_dict:
                label_dct_dict[key] = {}
            label_dct_dict[key][dct_type] = dct_config[group]

        return label_dct_dict
    
    def _select_base_directives(self):
        if self.is_large_kernel:
            num_unrolls = NUM_UNROLLS_LARGE
            num_partitions = NUM_PARTITIONS_LARGE
            num_pipelines = NUM_PIPELINES_LARGE
        else:
            num_unrolls = NUM_UNROLLS
            num_partitions = NUM_PARTITIONS
            num_pipelines = NUM_PIPELINES

        total_sols = num_unrolls + num_partitions + num_pipelines

        selected_arrays = self._selected_arrays[:num_partitions]

        num_unrolls += (num_partitions - len(selected_arrays))
        selected_unroll_loops = self._selected_unroll_loops[:num_unrolls]

        num_pipelines += (num_unrolls - len(selected_unroll_loops))
        selected_pipeline_loops = self._selected_pipeline_loops[:num_pipelines]

        selected_partition_directives = []
        for label in selected_arrays:
            directives = self._directive_map['array_partition'][label]
            directives = [d for d in directives if '-factor' in d and '-factor 0' not in d]
            if not directives:
                continue
            dct = directives[len(directives) // 2]
            selected_partition_directives.append(dct)

        selected_unroll_directives = []
        for label in selected_unroll_loops:
            directives = self._directive_map['unroll'][label]
            directives = [d for d in directives if '-factor' in d and '-factor 0' not in d]
            if not directives:
                continue
            dct = directives[-1]
            selected_unroll_directives.append(dct)

        selected_pipeline_directives = []
        for label in selected_pipeline_loops:
            directives = self._directive_map['unroll'][label]
            if len(directives) > 1:
                dct = directives[-1]
                selected_pipeline_directives.append(dct)

        self._base_directives = (
            selected_partition_directives + 
            selected_unroll_directives + 
            selected_pipeline_directives
        )

        total_sols_available = len(self._base_directives)
        num_missing = total_sols - total_sols_available
          
        if num_missing > 0:
            # Include the unroll with second highest factor
            additional_unrolls = []
            for label in selected_unroll_loops:
                directives = self._directive_map['unroll'][label]
                directives = [d for d in directives if '-factor' in d and '-factor 0' not in d]
                if not directives:
                    continue
                if len(directives) > 1:
                    dct = directives[-2]
                    additional_unrolls.append(dct)
                if len(additional_unrolls) >= num_missing:
                    break
            additional_unrolls = additional_unrolls[:num_missing]
            self._base_directives += additional_unrolls

        total_sols_available = len(self._base_directives)
        num_missing = total_sols - total_sols_available

        if num_missing > 0:
            # Include extra partition solutions
            additional_partitions = []
            for label in selected_arrays:
                directives = self._directive_map['array_partition'][label]
                directives = [d for d in directives if '-factor' in d and '-factor 0' not in d]
                if not directives:
                    continue
                if len(directives) > 1:
                    dct = directives[-1]
                    additional_partitions.append(dct)
                if len(additional_partitions) >= num_missing:
                    break
            additional_partitions = additional_partitions[:num_missing]
            self._base_directives += additional_partitions

    def _is_complex_directive(self, group, directive):
        group_data = self.domain['directives'].get(group)
        if not group_data:
            return False
        
        dct_type = group_data['directive_type']
        function = group_data['function']
        label = group_data['label']

        if dct_type == 'loop_merge' and function == self.top_level_function:
            return True
        
        if dct_type == 'unroll':
            if (function, label) in self._l_unroll_loops and '-factor' not in directive:
                return True
            
        return False
    
    def _separate_pipeline_loops(self):
        complete, small, medium, large = self._separate_loops(self._directive_map['pipeline'])
        self._pipeline_loops = complete
        self._s_pipeline_loops = small
        self._m_pipeline_loops = medium
        self._l_pipeline_loops = large
        self._selected_pipeline_loops = (
            list(self._l_pipeline_loops.keys()) +
            list(self._m_pipeline_loops.keys()) +
            list(self._s_pipeline_loops.keys())
        )

    def _separate_unroll_loops(self):
        complete, small, medium, large = self._separate_loops(self._directive_map['unroll'])
        self._unroll_loops = complete
        self._s_unroll_loops = small
        self._m_unroll_loops = medium
        self._l_unroll_loops = large
        self._selected_unroll_loops = (
            list(self._l_unroll_loops.keys()) +
            list(self._m_unroll_loops.keys()) +
            list(self._s_unroll_loops.keys())
        )

    def _separate_arrays(self):
        self._partition_arrays_nd = {'global': {}, 'interface': {}}
        self._partition_arrays_1d = {'global': {}, 'interface': {}}
        self._selected_arrays = set()

        for label in self._directive_map['array_partition']:
            function_name, array_name = label
            node = find_array_node(self.kernel_graph, array_name, function_name)
            if node is not None:
                if node.node_type == 'port' and node.is_top_level_port:
                    array_type = 'interface'
                elif node.node_type == 'internal_mem' and node.is_global_mem:
                    array_type = 'global'
                else:
                    continue
                    
                if node.num_dims > 1:
                    self._partition_arrays_nd[array_type][label] = node
                else:
                    self._partition_arrays_1d[array_type][label] = node

        self._selected_arrays = (
            list(self._partition_arrays_nd['global'].keys()) +
            list(self._partition_arrays_nd['interface'].keys()) +
            list(self._partition_arrays_1d['global'].keys()) +
            list(self._partition_arrays_1d['interface'].keys())
        )
        self._relevant_arrays = (
            list(self._partition_arrays_nd['global'].keys()) +
            list(self._partition_arrays_nd['interface'].keys()) +
            list(self._partition_arrays_1d['global'].keys())
        )
        
    def _separate_loops(self, loops):
        loop_dict = {}
        loop_ils = []
        for function_name, loop_name in loops:
            node = find_region_node(self.kernel_graph, loop_name, function_name)
            if node is not None:
                loop_il = node.feature_dict.get('il', 0)
                if loop_il > 0:
                    loop_dict[(function_name, loop_name)] = node
                    loop_ils.append(float(loop_il))

        q3 = np.quantile(loop_ils, 0.75)
        q1 = np.quantile(loop_ils, 0.25)
        
        small_loop_dict = {}
        medium_loop_dict = {}
        large_loop_dict = {}

        for label, node in loop_dict.items():
            loop_il = float(node.feature_dict.get('il', 0))
            if loop_il <= q1:
                small_loop_dict[label] = node
            elif loop_il >= q3:
                medium_loop_dict[label] = node
            else:
                large_loop_dict[label] = node

        return (
            loop_dict, small_loop_dict, 
            medium_loop_dict, large_loop_dict
        )

    def _config_prj_state_from_previous_runs(self):
        invalid_runs, successful_runs = [], []

        for solution_dir in self.project_dir.iterdir():
            if (not solution_dir.is_dir() or 
                not solution_dir.name.startswith('solution') or 
                solution_dir.name == 'solution0'):
                continue

            solution_index = solution_dir.name.replace('solution', '')
            if not solution_index.isdigit():
                invalid_runs.append(solution_dir)
                continue

            solution_index = int(solution_index)

            run_dir = solution_dir / 'impl/verilog/project.runs/impl_1'
            if not run_dir.is_dir():
                # Check if the solution was filtered
                reports_dir = solution_dir / 'reports'
                if not (solution_dir / 'reports').is_dir():
                    invalid_runs.append(solution_dir)
                    continue

                power_rpt_file = reports_dir / 'impl_power.rpt'
                util_rpt_file = reports_dir / 'impl_utilization_placed.rpt'
                time_rpt_file = reports_dir / 'impl_timing_summary.rpt'
            else:
                power_rpt_file = run_dir / 'bd_0_wrapper_power_routed.rpt'
                util_rpt_file = run_dir / 'bd_0_wrapper_utilization_placed.rpt'
                time_rpt_file = run_dir / 'bd_0_wrapper_timing_summary_routed.rpt'

            if power_rpt_file.exists() and util_rpt_file.exists() and time_rpt_file.exists():
                successful_runs.append(solution_dir)
            else:
                invalid_runs.append(solution_dir)

        for solution_dir in invalid_runs:
            print(f"Run {solution_dir.name} is incomplete or invalid. Removing it.")
            shutil.rmtree(solution_dir, ignore_errors=True)

        self.control_tree = {}

        for solution_dir in successful_runs:
            dct_config = self._extract_directives(solution_dir)
            if not dct_config:
                shutil.rmtree(solution_dir, ignore_errors=True)
                continue

            node = self.control_tree
            for group_label, group_data in self.domain['directives'].items():
                if group_label not in dct_config:
                    idx = 0
                else:
                    dct = dct_config[group_label]
                    if dct == '' or '-off' in dct:
                        idx = 0
                    elif dct not in group_data['possible_directives']:
                        print(f"Directive {dct} not found in group {group_label}.")
                        idx = 0
                    else:
                        idx = group_data['possible_directives'].index(dct)

                if idx not in node:
                    node[idx] = {}
                node = node[idx]

        solution_indices = [
            int(solution_dir.name.replace('solution', '')) 
            for solution_dir in self.project_dir.iterdir()
        ]
        self.solution_index = max(solution_indices) + 1 if solution_index else 1

    def _decode_config_tree(self, obj):
        if isinstance(obj, str):
            return int(obj)
        elif isinstance(obj, dict):
            return {
                self._decode_config_tree(key): self._decode_config_tree(value) 
                for key, value in obj.items()
            }
        return obj
    
    def _extract_directives(self, solution_dir: Path):
        directives_tcl = solution_dir / 'directives.tcl'
        if not directives_tcl.is_file():
            hls_data_json = solution_dir / f'{solution_dir.name}_data.json'
            if not hls_data_json.is_file():
                return None
            
            with open(hls_data_json, 'r') as f:
                hls_data = json.load(f)

            directive_data = hls_data.get('HlsSolution', {}).get('DirectiveTcl', [])
            if not directive_data:
                return None
            
            directive_data = '\n'.join(directive_data)
            with open(directives_tcl, 'w') as f:
                f.write(directive_data)

        with open(directives_tcl, 'r') as f:
            lines = f.readlines()
        
        dct_config = {}
        for line in lines:
            if (not line.startswith('set_directive_') or 
                line.startswith('set_directive_top')):
                continue

            cmd, args = parse_directive_cmd(line)
            location = args.get('location', '')

            if cmd == 'array_partition':
                variable = args.get('variable', '')
                label = f"{cmd} {variable} {location}"

                factor = args.get('factor', '')
                partition_type = args.get('type', '')
                dim = args.get('dim', '')

                factor = f"-factor {factor}" if factor else ''
                partition_type = f"-type {partition_type}" if partition_type else ''
                dim = f"-dim {dim}" if dim else ''

                args_str = ' '.join(
                    [arg for arg in [partition_type, factor, dim] if arg]
                )
                if args_str != '':
                    line = f"set_directive_{cmd} {args_str} \"{location}\" {variable}"
                else:
                    line = f"set_directive_{cmd} \"{location}\" {variable}"
            else:
                if '/' in location:
                    loop_label = location.split('/')[-1]
                    label = f"{cmd} {loop_label}"
                else:
                    label = f"{cmd} {location}"

                if cmd == 'unroll':
                    factor = args.get('factor', '')
                    if factor:
                        line = f"set_directive_{cmd} -factor {factor} \"{location}\""
                    else:
                        line = f"set_directive_{cmd} \"{location}\""
                elif 'off' in args:
                    line = f"set_directive_{cmd} -off \"{location}\""
                else:
                    line = f"set_directive_{cmd} \"{location}\""

            dct_config[label] = line
                
        return dct_config
    
    def _save_project_state(self):
        project_state = {
            'control_tree': self.control_tree,
            'num_successful_runs': self.num_successful_runs
        }
        with open(self._project_state_path, 'w') as f:
            json.dump(project_state, f, indent=2)

    def _save_directives_as_tcl(self, dct_config):
        with open(self._directives_tcl_path, "w") as f:
            f.write('\n'.join([v for v in dct_config if v]))


if __name__ == '__main__':
    """Example usage"""
    import pickle

    dataset_dir = '../dataset-fine-tuning'
    benchmark = 'ADPCM'
    kernel_graph_path = 'estimators/area/dataset/full/ADPCM/base_graph.pkl'
    metrics_path = 'estimators/area/dataset/full/ADPCM/base_metrics.json'

    with open(metrics_path, 'r') as f:
        metrics = json.load(f)

    with open(kernel_graph_path, 'rb') as f:
        kernel_graph = pickle.load(f)

    dataset_gen = DatasetGenerator(dataset_dir, benchmark, kernel_graph, metrics)
    dataset_gen.run()