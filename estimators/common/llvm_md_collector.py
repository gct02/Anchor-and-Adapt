import os
import json
import subprocess
import copy
from typing import Optional


def extract_array_and_loop_md(
    hls_ir_dir: str, 
    opt_path: str = '/usr/bin/opt', 
    dse_lib_path: Optional[str] = None
):
    dse_lib = os.environ.get('DSE_LIB', dse_lib_path)
    opt = os.environ.get('OPT', opt_path)

    if dse_lib is None or not os.path.exists(dse_lib):
        raise FileNotFoundError(f"DSE library not found: {dse_lib}")
    if not os.path.exists(opt):
        raise FileNotFoundError(f"LLVM opt not found: {opt}")

    if not os.path.exists(hls_ir_dir):
        raise FileNotFoundError(f"HLS IR directory not found: {hls_ir_dir}")
    
    ir_base = os.path.join(hls_ir_dir, "a.g.ld.0.bc")
    ir_lowered = os.path.join(hls_ir_dir, "a.o.3.bc")
    if not os.path.exists(ir_base) or not os.path.exists(ir_lowered):
        raise FileNotFoundError(f"Required IR files not found in {hls_ir_dir}")
    
    base_array_md_path = os.path.join(hls_ir_dir, "array_info_ld0.json")
    lowered_array_md_path = os.path.join(hls_ir_dir, "array_info_o3.json")
    loop_md_path = os.path.join(hls_ir_dir, "loop_info.json")
    
    try:
        subprocess.check_output(
            f"{opt} -load {dse_lib} -extract-array-info -out-array {base_array_md_path} < {ir_base}",
            shell=True, stderr=subprocess.STDOUT
        )
        subprocess.check_output(
            f"{opt} -load {dse_lib} -extract-array-info -out-array {lowered_array_md_path} -lowered < {ir_lowered}",
            shell=True, stderr=subprocess.STDOUT
        )
        subprocess.check_output(
            f"{opt} -load {dse_lib} -extract-loop-info -out-loop {loop_md_path} < {ir_base}",
            shell=True, stderr=subprocess.STDOUT
        )

        array_md_dict = merge_array_info(base_array_md_path, lowered_array_md_path)

        with open(loop_md_path, 'r') as f:
            loop_md_dict = json.load(f)

    except subprocess.CalledProcessError as e:
        raise RuntimeError(f"Error processing IR: {e.output.decode()}")
    
    return array_md_dict, loop_md_dict
    

def merge_array_info(base_array_md_path: str, lowered_array_md_path: str):
    def normalize_function_name(name: str) -> str:
        original_name = name
        chars_to_replace = ['.', '-', ' ', '(', ')', '[', ']', '<', '>', ':']
        for char in chars_to_replace:
            name = name.replace(char, '_')
        if ("Pipeline" in name or original_name.endswith(">")) and name.endswith("_"):
            name += "s"
        return name

    required_keys = ["Global", "Local"]

    with open(base_array_md_path, 'r') as f:
        base_array_md_dict = json.load(f)

    if any([key not in base_array_md_dict for key in required_keys]):
        raise ValueError(f"Base array metadata must contain keys: {required_keys}")

    with open(lowered_array_md_path, 'r') as f:
        lowered_array_md_dict = json.load(f)

    if any([key not in lowered_array_md_dict for key in required_keys]):
        raise ValueError(f"Lowered array metadata must contain keys: {required_keys}")
    
    keys_to_merge = ["Dimensions", "BaseType", "BaseBitwidth", "NumDimensions", "TotalSize"]
    merged_array_md_dict = {"Global": {}, "Local": {}}

    for scope in ["Global", "Local"]:
        for array_label, lowered_array_md in lowered_array_md_dict[scope].items():
            merged_array_md = copy.deepcopy(lowered_array_md)

            if scope == "Local":
                function_name, array_name = array_label.split('/')
                function_name = normalize_function_name(function_name)
                original_array_label = f"{function_name}/{array_name}"
            else:
                original_array_label = array_label

            if original_array_label in base_array_md_dict[scope]:
                base_array_md = base_array_md_dict[scope][original_array_label]
                for key in keys_to_merge:
                    if key in base_array_md:
                        merged_array_md[f"Original{key}"] = base_array_md[key]
                    else:
                        print(f"Warning: Key '{key}' not found in base metadata for array "
                              f"'{original_array_label}' in scope '{scope}'")
                        merged_array_md[f"Original{key}"] = lowered_array_md[key]
            else:
                for key in keys_to_merge:
                    merged_array_md[f"Original{key}"] = lowered_array_md[key]

            for key in ["Stores", "Loads", "GEPs"]:
                for item in merged_array_md.get(key, []):
                    if "FunctionName" in item:
                        item["FunctionName"] = normalize_function_name(item["FunctionName"])
            
            merged_array_md_dict[scope][original_array_label] = merged_array_md

    return merged_array_md_dict

    