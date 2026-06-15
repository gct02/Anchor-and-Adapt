from pathlib import Path
from typing import List, Dict


def parse_tcl_directives(directives_tcl_path) -> List[Dict[str, str]]:
    if not Path(directives_tcl_path).is_file():
        raise FileNotFoundError(f"File not found: {directives_tcl_path}")
    
    with open(directives_tcl_path, "r") as f:
        lines = f.readlines()

    directives = []
    for l in lines:
        if l.startswith('set_directive_') and not l.startswith('set_directive_top'):
            directives.append(parse_directive_command(l))

    return directives


def parse_directive_command(directive_cmd) -> Dict[str, str]:
    if directive_cmd == '': return {}
    dct_type = directive_cmd.split(' ')[0].split('set_directive_')[1]
    dct_as_dict = {}
    dct_as_dict['directive'] = dct_type

    tokens = directive_cmd.split(' ')[1:]
    arg_dict = parse_directive_arg_tokens(tokens)
    dct_as_dict.update(arg_dict)
    return dct_as_dict


def convert_directive_dict_to_command(directive_dict) -> str:
    if not directive_dict: return ''
    if 'directive' not in directive_dict or 'location' not in directive_dict: return ''

    dct_type = directive_dict['directive']
    dct_loc = directive_dict['location']
    cmd = f'set_directive_{dct_type} \"{dct_loc}\"'
    
    if 'off' in directive_dict:
        if dct_type not in ['pipeline', 'loop_flatten']: return ''
        return cmd + ' -off'
        
    if dct_type == 'unroll':
        if 'factor' in directive_dict:
            factor = directive_dict['factor']
            cmd += f' -factor {factor}'
    elif dct_type == 'array_partition':
        if 'variable' not in directive_dict: return ''
        kwargs = ['type', 'factor', 'dim']
        for k in kwargs:
            if k in directive_dict:
                cmd += f' -{k} {directive_dict[k]}'
        variable = directive_dict['variable']
        cmd += ' ' + variable

    return cmd


def export_directives_as_tcl(directive_config: Dict[str, Dict[str, str]], output_tcl_path=None):
    output_text = ''

    for dct_dict in directive_config.values():
        cmd = convert_directive_dict_to_command(dct_dict)
        if cmd != '':
            output_text += cmd + '\n'

    if not output_tcl_path: return output_text

    with open(output_tcl_path, 'w') as f:
        f.write(output_text)


def parse_directive_arg_tokens(tokens: List[str]) -> Dict[str, str]:
    arg_dict = {}
    i = 0

    while i < len(tokens):
        if tokens[i]:
            if tokens[i].startswith('-'):
                if tokens[i].find('=') != -1:
                    key, value = tokens[i].split('=')
                    arg_dict[key[1:]] = value
                elif tokens[i] == '-off':
                    arg_dict['off'] = 'true'
                else:
                    arg_dict[tokens[i][1:]] = tokens[i + 1]
                    i += 1
            elif 'location' not in arg_dict:
                arg_dict['location'] = tokens[i]
            else:
                arg_dict['variable'] = tokens[i]
        i += 1

    for key, args in arg_dict.items():
        arg_dict[key] = args.strip('" \n')

    return arg_dict