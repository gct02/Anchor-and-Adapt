#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <tcl_script> [<vitis_hls_settings> <vivado_settings>]"
    exit 1
fi

tcl_script=$1

# Check if the config file exists
if [ ! -f "$tcl_script" ]; then
    echo "File not found: $tcl_script"
    exit 1
fi

# Check if the settings files are provided, otherwise use defaults
if [ $# -gt 1 ]; then
    vitis_hls_settings=$2
    vivado_settings=$3
else
    vitis_hls_settings="/tools/Xilinx/Vitis_HLS/2023.2/settings64.sh"
    vivado_settings="/tools/Xilinx/Vivado/2023.2/settings64.sh"
fi

# Source the settings files
if [ -f "$vitis_hls_settings" ] && [ -f "$vivado_settings" ]; then
    source "$vitis_hls_settings"
    source "$vivado_settings"
else
    echo "Vitis HLS or Vivado settings file not found."
    exit 1
fi

vitis_hls -f "$tcl_script"