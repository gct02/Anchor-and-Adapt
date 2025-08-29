#!/bin/bash

if [ $# -lt 1 ]; then
    echo "Usage: $0 <hls_tcl> [<vitis_hls_settings> <vivado_settings>]"
    exit 1
fi

hls_tcl=$1

# Check if the config file exists
if [ ! -f "$hls_tcl" ]; then
    echo "File not found: $hls_tcl"
    exit 1
fi

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

vitis_hls -f "$hls_tcl"