#!/bin/bash

# Source the Vitis HLS settings
# (Make sure to change the path to your Vitis HLS installation)
source /tools/Xilinx/Vitis_HLS/2023.2/settings64.sh

HLS_LLVM_DIR="${HOME}/Documents/hls-llvm-project" # Change this to the path of the hls-llvm-project directory
HLS_LLVM_BUILD_DIR="${HLS_LLVM_DIR}/hls-build"

# Set the HLS LLVM environment variables
export DSE_LIB="${HLS_LLVM_BUILD_DIR}/lib/libDSE.so"
export OPT="${HLS_LLVM_BUILD_DIR}/bin/opt"
export LLI="${HLS_LLVM_BUILD_DIR}/bin/lli"
export LLC="${HLS_LLVM_BUILD_DIR}/bin/llc"
export LLVM_LINK="${HLS_LLVM_BUILD_DIR}/bin/llvm-link"
export LLVM_DIS="${HLS_LLVM_BUILD_DIR}/bin/llvm-dis"
export LLVM_AS="${HLS_LLVM_BUILD_DIR}/bin/llvm-as"
export CLANG="${HLS_LLVM_BUILD_DIR}/bin/clang"
export CLANGXX="${HLS_LLVM_BUILD_DIR}/bin/clang++"
export LLVM_CMAKE_DIR="${HLS_LLVM_DIR}/llvm/cmake/modules"

# Set PYTHONPATH to the root of the project
export PYTHONPATH=.