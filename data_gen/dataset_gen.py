import json
import subprocess
import time
import psutil
import shutil
from random import randint
from pathlib import Path
from typing import Union, List, Dict, Any, Optional

from data_gen.tcl_script import generate_project_tcl_script
from data_gen.parsers import (
    parse_directive_command, 
    parse_tcl_directives, 
    export_directives_as_tcl
)

IMPL_RPTS = [
    'bd_0_wrapper_power_routed.rpt',
    'bd_0_wrapper_utilization_placed.rpt',
    'bd_0_wrapper_timing_summary_routed.rpt'
]
FILTERED_IMPL_RPTS = [
    'impl_power.rpt', 
    'impl_utilization_placed.rpt', 
    'impl_timing_summary.rpt'
]


class DatasetGenerator:
    def __init__(
        self,
        project_dir: Union[Path, str],
        sources: List[Union[Path, str]],
        top_function: str,
        directive_config_path: Union[Path, str],
        base_directive_config_path: Optional[Union[Path, str]] = None,
        gen_base_solutions: bool = True,
        max_instances: int = 1000,
        run_timeout: int = 5400,  # 1.5 hours
        run_script_path: Union[Path, str] = 'data_gen/run_toolchain.sh'
    ):
        # 1. Basic Assignments
        self.project_dir = Path(project_dir).resolve()
        self.sources = [Path(src).resolve() for src in sources]
        self.top_function = top_function
        self.directive_config_path = Path(directive_config_path).resolve()
        self.run_script_path = Path(run_script_path).resolve()

        if base_directive_config_path is not None:
            self.base_directive_config_path = Path(base_directive_config_path).resolve()
        else:
            if gen_base_solutions:
                self.base_directive_config_path = self.directive_config_path
            else:
                self.base_directive_config_path = None
        
        self.max_instances = max_instances
        self.run_timeout = run_timeout
        
        # 2. Validation
        self._validate_inputs()

        # 3. State Initialization
        self.instance_count = 0
        self.control_tree = {}
        self.dct_domain = {}
        self.dct_index_map = {}
        self.dct_domain_info = {}
        self.base_dct_domain = None
        
        # 4. Load and Process Config
        self._load_configs()

        # 5. Directory Setup
        self._setup_directories()

    def _validate_inputs(self):
        """Ensures all files and directories are valid before proceeding."""
        if not self.sources:
            raise ValueError("At least one source file must be provided.")
        
        paths_to_check = [self.directive_config_path, self.run_script_path] + self.sources
        if self.base_directive_config_path:
            paths_to_check.append(self.base_directive_config_path)

        for p in paths_to_check:
            if not p.is_file():
                raise FileNotFoundError(f"Required file not found: {p}")
            
    def _load_configs(self):
        """Parses the JSON configuration and populates domain dictionaries."""
        def load_config(config_path):
            try:
                with open(config_path, 'r') as f:
                    config = json.load(f)
            except json.JSONDecodeError as e:
                raise ValueError(f"Invalid JSON format in {config_path}: {e}")
            except Exception as e:
                raise ValueError(f"An unexpected error occurred: {e}")

            if 'directives' not in config:
                raise KeyError(f"JSON at {config_path} missing 'directives' key.")
            
            return config

        try:
            config = load_config(self.directive_config_path)
            self.nested_loops = config.get('nested_loops', [])
            self.parent_loops_dict = config.get('parent_loops', {})
            for domain in config['directives'].values():
                self._process_directive_group(domain)
        except:
            raise

        if self.base_directive_config_path:
            self.base_dct_domain = {}
            try:
                base_config = load_config(self.base_directive_config_path)
                for group, domain in base_config['directives'].items():
                    self.base_dct_domain[group] = [
                        dct.strip('\n') for dct in domain['possible_directives']
                    ]
            except:
                raise

    def _process_directive_group(self, domain: Dict[str, Any]):
        """Processes individual directive groups and sorts the possible values."""
        required_keys = ['possible_directives', 'directive_type', 'function']
        if any(not domain.get(k) for k in required_keys): return
        
        directives = domain['possible_directives']
        parsed_directives = []

        for dct in directives:
            dct = dct.strip('\n')
            dct_dict = parse_directive_command(dct)
            if dct == '' or '-off' in dct:
                parsed_directives.insert(0, dct_dict)
            else:
                parsed_directives.append(dct_dict)

        function = domain['function']
        if domain.get('variable', ''):
            target = function + '/' + domain['variable']
        elif domain.get('label', ''):
            target = function + '/' + domain['label']
        else:
            target = function

        group_label = domain['directive_type'] + ' ' + target
        
        self.dct_domain[group_label] = parsed_directives

        self.dct_index_map[group_label] = {
            frozenset(dct_dict.items()): i 
            for i, dct_dict in enumerate(parsed_directives)
        }

        self.dct_domain_info[group_label] = {
            'directive_type': domain['directive_type'],
            'function': domain['function'],
            'label': domain.get('label', ''),
            'variable': domain.get('variable', ''),
            'target': target,
            'constraints': set(domain.get('constraints', {}))
        }

    def _setup_directories(self):
        """Initializes project and temp directory structure."""
        self.project_dir.mkdir(parents=True, exist_ok=True)
        
        self._temp_dir = self.project_dir / 'temp'
        self._temp_dir.mkdir(parents=True, exist_ok=True)
        
        self._project_state_path = self.project_dir / 'project_state.json'
        self._dct_tcl_path = self._temp_dir / 'directives.tcl'
        self._script_tcl_path = self._temp_dir / 'hls_script.tcl'

        if self.base_directive_config_path:
            self._base_instances_path = self._temp_dir / 'base_instances.txt'
        else:
            self._base_instances_path = None

    def run(self, clear: bool = False):
        if clear:
            shutil.rmtree(self.project_dir, ignore_errors=True)
            self.project_dir.mkdir(parents=True, exist_ok=True)
            self._temp_dir.mkdir(parents=True, exist_ok=True)
            self.instance_count = 0
            self.control_tree = {}
        else:
            self._handle_resume()

        if self.base_directive_config_path:
            self.gen_base_solutions()
            self.max_instances += len(self._existing_base)

        while self.instance_count < self.max_instances:
            dct_config = self._gen_random_config()
            if not dct_config:
                print("INFO: All valid configurations have been exhausted.")
                break

            export_directives_as_tcl(dct_config, self._dct_tcl_path)
            solution_name = f'solution{self.instance_count + 1}'

            generate_project_tcl_script(
                project_path=self.project_dir,
                source_files=self.sources,
                top_function=self.top_function,
                solution_name=solution_name,
                output_script_path=self._script_tcl_path,
                directive_tcl_path=self._dct_tcl_path,
                part='xcu50-fsvh2104-2-e',
                clock_period=8
            )
            if self._run_design_flow(solution_name):
                self.instance_count += 1
                self._save_project_state()

        # Clean up temporary files
        if self._temp_dir.is_dir():
            shutil.rmtree(self._temp_dir, ignore_errors=True)

    def gen_anchor_solution(self, directive_tcl_path: Union[Path, str] = None):
        self._temp_dir.mkdir(parents=True, exist_ok=True)

        if directive_tcl_path is None:
            dct_config = self._get_anchor_config()
            export_directives_as_tcl(dct_config, self._dct_tcl_path)
        else:
            # Move the provided directive tcl file to the temp directory
            directive_tcl_path = Path(directive_tcl_path).resolve()
            if not directive_tcl_path.is_file():
                raise FileNotFoundError(f"File not found: {directive_tcl_path}.")
            shutil.copy(directive_tcl_path, self._dct_tcl_path)

        generate_project_tcl_script(
            project_path=self.project_dir,
            source_files=self.sources,
            top_function=self.top_function,
            solution_name='solution0',
            output_script_path=self._script_tcl_path,
            directive_tcl_path=self._dct_tcl_path,
            part='xcu50-fsvh2104-2-e',
            clock_period=8
        )
        self._run_design_flow('solution0')

    def gen_base_solutions(self):
        if not self.base_dct_domain or not self._base_instances_path: 
            return

        for group, directives in self.base_dct_domain.items():
            for dct in directives:
                base_solution_label = f'<{group}><{dct}>'
                if base_solution_label in self._existing_base:
                    continue

                base_dct_config = []
                for key in self.base_dct_domain:
                    if key != group:
                        base_dct_config.append(self.base_dct_domain[key][0])
                    else:
                        base_dct_config.append(dct)

                with open(self._dct_tcl_path, 'w') as f:
                    f.write('\n'.join([d for d in base_dct_config if d != '']))

                solution_name = f'solution{self.instance_count + 1}'

                generate_project_tcl_script(
                    project_path=self.project_dir,
                    source_files=self.sources,
                    top_function=self.top_function,
                    solution_name=solution_name,
                    output_script_path=self._script_tcl_path,
                    directive_tcl_path=self._dct_tcl_path,
                    part='xcu50-fsvh2104-2-e',
                    clock_period=8
                )
                if self._run_design_flow(solution_name):
                    self.instance_count += 1
                    self._existing_base.add(base_solution_label)
                    with open(self._base_instances_path, 'w') as f:
                        f.write('\n'.join(list(self._existing_base)))

    def _run_design_flow(self, solution_name):
        solution_dir = self.project_dir / solution_name

        try:
            if not solution_dir.is_dir():
                solution_dir.mkdir(parents=True, exist_ok=True)

            print('\n======================================================')
            print(f'Starting \'{solution_name}\' Run')
            print('======================================================\n')

            proc = subprocess.Popen(
                [f'{self.run_script_path} {self._script_tcl_path}'],
                shell=True
            )
            start_time = time.time()
            parent_proc = psutil.Process(proc.pid)

            while parent_proc.is_running() and parent_proc.status() != psutil.STATUS_ZOMBIE:
                time.sleep(30)
                if self._check_run_completion(solution_dir):
                    print(f'\n***** Run completed successfully ({solution_name}) *****\n')
                    shutil.copy(self._dct_tcl_path, solution_dir / 'directives.tcl')
                    return True

                if (time.time() - start_time) > self.run_timeout:
                    print(f'\n***** Run exceeded time limit ({solution_name}) *****\n')
                    for child in parent_proc.children(recursive=True):
                        child.kill()
                    parent_proc.kill()
                    shutil.rmtree(solution_dir, ignore_errors=True)
                    return False

            # Final check in case the process finished between sleep intervals
            if self._check_run_completion(solution_dir):
                print(f'\n***** Run completed successfully ({solution_name}) *****\n')
                shutil.copy(self._dct_tcl_path, solution_dir / 'directives.tcl')
                return True
            else:
                print(f'\n***** Run ended with errors ({solution_name}) *****\n')
                shutil.rmtree(solution_dir, ignore_errors=True)
                return False

        except Exception as e:
            print(e)
            shutil.rmtree(solution_dir, ignore_errors=True)
            return False

    def _handle_resume(self):
        self._existing_base = set()

        if self._base_instances_path and self._base_instances_path.is_file():
            with open(self._base_instances_path, 'r') as f:
                lines = f.readlines()

            for line in lines:
                line = line.strip()
                if line: self._existing_base.add(line)

        if not self._project_state_path.is_file():
            self._build_control_tree_from_previous_runs()
            self._save_project_state()
            return

        with open(self._project_state_path, 'r') as f:
            project_state = json.load(f)

        control_tree = project_state.get('control_tree', {})
        if not isinstance(control_tree, dict):
            raise ValueError(
                f"Invalid control tree format in {self._project_state_path}. "
                f"Expected a dictionary."
            )
        
        instance_count = project_state.get('instance_count', 0)
        if not isinstance(instance_count, int):
            raise ValueError(
                f"Invalid instance count format in {self._project_state_path}. "
                f"Expected an integer."
            )

        self.control_tree = self._decode_json(control_tree)
        self.instance_count = instance_count

    def _save_project_state(self):
        project_state = {
            'control_tree': self.control_tree,
            'instance_count': self.instance_count
        }
        with open(self._project_state_path, 'w') as f:
            json.dump(project_state, f, indent=2)

    def _save_dct_config(self, dct_config):
        with open(self._dct_tcl_path, "w") as f:
            f.write('\n'.join([v for v in dct_config.values() if v]))

    def _gen_random_config(self):
        N_TRIALS = 1000
        
        for _ in range(N_TRIALS):
            node = self.control_tree
            config = {}
            is_new = False

            for group, domain in self.dct_domain.items():
                idx = randint(0, len(domain) - 1)
                if self._is_conflicting_directive(config, group, domain[idx]): 
                    idx = 0
                
                config[group] = domain[idx]

                if idx not in node:
                    node[idx] = {}
                    is_new = True
                node = node[idx]
            
            if is_new: return config

        return None
    
    def _get_anchor_config(self):
        return {gp: self.dct_domain[gp][0] for gp in self.dct_domain}
    
    def _check_run_completion(self, solution_dir: Path):
        run_dir = solution_dir / 'impl/verilog/project.runs/impl_1'
        if not run_dir.is_dir(): return False
        return all((run_dir / f).exists() for f in IMPL_RPTS)
    
    def _is_conflicting_directive(self, dct_config, new_group, new_dct):
        if not new_dct or 'off' in new_dct: return False
        if new_group not in self.dct_domain_info: return False

        dct_info = self.dct_domain_info[new_group]
        dct_type = dct_info['directive_type']
        target = dct_info['target']

        if dct_type in ['unroll', 'pipeline']:
            for parent_loop in self.parent_loops_dict.get(target, []):
                if self._is_pipelined_loop(dct_config, parent_loop):
                    return True

        for group, dct in dct_config.items():
            if dct and 'off' not in dct and new_group != group:
                group_info = self.dct_domain_info[group]
                constraints = group_info.get('constraints', {})
                if new_group in constraints:
                    return True
        
        if dct_type != 'unroll' or 'factor' in new_dct: 
            return False

        target_dct_dict = self._get_target_directives(dct_config, target)

        for target_dct_type in ['unroll', 'pipeline', 'loop_flatten']:
            target_dct = target_dct_dict.get(target_dct_type)
            if target_dct and 'off' not in target_dct:
                return True

        return False

    def _map_loops_to_directives(self, dct_config):
        keys = {'unroll', 'pipeline'}
        loop_dct_map = {}

        for group, dct in dct_config.items():
            group_info = self.dct_domain_info[group]
            dct_type = group_info['directive_type']
            if dct_type in keys:
                target = group_info['target']
                if target not in loop_dct_map: 
                    loop_dct_map[target] = {}
                loop_dct_map[target][dct_type] = dct

        return loop_dct_map
    
    def _get_target_directives(self, dct_config, target):
        target_dct_dict = {}

        for group, dct in dct_config.items():
            group_info = self.dct_domain_info[group]            
            if group_info['target'] == target:
                target_dct_dict[group_info['directive_type']] = dct

        return target_dct_dict
    
    def _is_pipelined_loop(self, dct_config, target):
        for group, dct in dct_config.items():
            if not dct or 'off' in dct: continue
            group_info = self.dct_domain_info[group]            
            if group_info['target'] == target:
                if group_info['directive_type'] == 'pipeline':
                    return True
        return False

    def _decode_json(self, obj):
        if isinstance(obj, str):
            return int(obj)
        elif isinstance(obj, dict):
            return {
                self._decode_json(k): self._decode_json(v) 
                for k, v in obj.items()
            }
        return obj
    
    def _build_control_tree_from_previous_runs(self):
        self.control_tree = {}
        self.instance_count = 0
        incomplete_runs, complete_runs = [], []
        max_index = 0

        for solution_dir in self.project_dir.iterdir():
            if not solution_dir.is_dir(): continue
            if not solution_dir.name.startswith('solution'): continue
            try:
                instance_index = int(solution_dir.name.replace('solution', ''))
                assert instance_index > 0
            except: 
                continue

            run_dir = solution_dir / 'impl/verilog/project.runs/impl_1'
            if not run_dir.is_dir():
                # Filtered solution
                rpt_dir = solution_dir / 'reports'
                required_rpts = [rpt_dir / f for f in FILTERED_IMPL_RPTS]
            else:
                required_rpts = [run_dir / f for f in IMPL_RPTS]

            if all(rpt.exists() for rpt in required_rpts):
                complete_runs.append(solution_dir)
                max_index = max(max_index, instance_index)
            else:
                incomplete_runs.append(solution_dir)

        for run in (complete_runs + incomplete_runs):
            dct_config = self._extract_directives_from_previous_run(run)
            if dct_config is None: continue
            node = self.control_tree
            for group in self.dct_domain:
                idx = dct_config.get(group, 0)
                if idx not in node: node[idx] = {}
                node = node[idx]

        for run in incomplete_runs:
            print(f"Run {run.name} is incomplete. Removing it.")
            shutil.rmtree(run, ignore_errors=True)

        self.instance_count = max_index
        
    def _extract_directives_from_previous_run(self, solution_dir: Path):
        dct_path = solution_dir / 'directives.tcl'

        if not dct_path.is_file():
            hls_data_json = solution_dir / f'{solution_dir.name}_data.json'
            if not hls_data_json.is_file(): return None
            
            with open(hls_data_json, 'r') as f:
                hls_data = json.load(f)

            dct_data = hls_data.get('HlsSolution', {}).get('DirectiveTcl', [])
            if not dct_data: return None
            
            dct_data = '\n'.join(dct_data)
            with open(dct_path, 'w') as f:
                f.write(dct_data)

        directives = parse_tcl_directives(dct_path)
        dct_config = {}

        for dct_dict in directives:
            if 'directive' not in dct_dict or 'location' not in dct_dict:
                continue

            dct_type = dct_dict['directive']
            dct_loc = dct_dict['location']
            target = dct_loc.strip('" \n')

            if dct_type == 'array_partition':
                if 'variable' not in dct_dict: continue
                target += '/' + dct_dict['variable'].strip('" \n')

            group_label = dct_type + ' ' + target

            if group_label in self.dct_index_map:
                dct_fs = frozenset(dct_dict.items())
                dct_config[group_label] = self.dct_index_map[group_label].get(dct_fs, 0)

        for group_label in self.dct_domain.keys():
            if group_label not in dct_config:
                dct_config[group_label] = 0

        return dct_config


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(
        description="Generate a dataset of HLS solutions with various configurations."
    )
    parser.add_argument("-b", "--benchmark", type=str, default=None,
                        help="Name of the benchmark to use for the dataset generation.")
    parser.add_argument("-p", "--project-dir", type=str, default=None,
                        help="Path to the project directory (where the dataset will be generated).")
    parser.add_argument("-s", "--sources", nargs='*', type=str,
                         help="C/C++ sources for the HLS design.")
    parser.add_argument("-tf", "--top-function", type=str, default=None,
                        help="Top-level function name.")
    parser.add_argument("-d", "--directive-config", type=str, default=None,
                        help="Path to the directive configuration file JSON.")
    parser.add_argument("-bd", "--base-directive-config", type=str, default=None,
                        help="Path to the directive configuration file JSON (exclusive for generating the 'base' solutions).")
    parser.add_argument("-gb", "--gen-base", action='store_true',
                        help="Generate base solutions (with only a single directive applied).")
    parser.add_argument("-m", "--max-instances", type=int, default=1000,
                        help="Maximum number of instances to generate (default: 1000).")
    parser.add_argument("-t", "--timeout", type=int, default=5400,
                        help="Timeout for each design flow run in seconds (default: 5400, i.e., 1.5 hours).")
    parser.add_argument("-c", "--clear", action='store_true',
                        help="Clear previous runs before starting a new dataset generation.")
    parser.add_argument("-r", "--run-script", type=str, default='data_gen/run_toolchain.sh',
                        help="Path to the script that runs the HLS-to-bitstream toolchain (default: data_gen/run_toolchain.sh).")
    parser.add_argument("-s0", "--gen-anchor", action='store_true',
                        help="Generate anchor instance (solution0, with all directives set to off).")
    args = parser.parse_args()

    if args.benchmark:
        benchmark_info_path = 'data/benchmark_info.json'
        with open(benchmark_info_path, 'r') as f:
            benchmark_info_dict = json.load(f)

        if args.benchmark not in benchmark_info_dict:
            raise KeyError(f"Benchmark '{args.benchmark}' not found in {benchmark_info_path}.")
        
        benchmark_info = benchmark_info_dict[args.benchmark]
        
        args.sources = benchmark_info['source_files']
        args.top_function = benchmark_info['top_level']
        args.directive_config = benchmark_info['directive_config_path']

        if args.project_dir is None:
            args.project_dir = 'data_gen/dataset/' + args.benchmark
    else:
        required_args = [args.sources, args.top_function, args.directive_config, args.project_dir]
        if any(arg is None for arg in required_args):
            raise ValueError(
                "If 'benchmark' is not provided, "
                "'sources', 'top_function', and 'directive_config' must be specified."
            )
        
    dataset_gen = DatasetGenerator(
        project_dir=args.project_dir,
        sources=args.sources,
        top_function=args.top_function,
        directive_config_path=args.directive_config,
        max_instances=args.max_instances,
        run_timeout=args.timeout,
        run_script_path=args.run_script
    )
    dataset_gen.run(clear=args.clear)

    if args.gen_anchor:
        dataset_gen.gen_anchor_solution()