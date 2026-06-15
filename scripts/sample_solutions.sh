#!/bin/bash

METRIC=$1
NUM_BASE=${2:-5}
NUM_COMPLEX=${3:-4}

BENCHMARKS=(
    "ADPCM"
    "AES"
    "BACKPROP"
    "GEMM"
    "GRAMSCHMIDT"
    "GSM"
    "KNN"
    "SHA"
    "STENCIL3D"
    "TRANS_FFT"
)

SCRIPT=estimator.common.fine_tuning.solution_sampler
MODELS_DIR=estimator/${METRIC}/models

for BENCH in "${BENCHMARKS[@]}"; do
    python3 -m $SCRIPT ${BENCH} -t $METRIC -b 16 --num-base $NUM_BASE --num-complex $NUM_COMPLEX
done