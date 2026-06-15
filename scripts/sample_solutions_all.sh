#!/bin/bash

NUM_BASE=${1:-5}
NUM_COMPLEX=${2:-4}

METRICS=(
    "area"
    "power"
    "cycles"
    "clock"
)

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

for METRIC in "${METRICS[@]}"; do
    for BENCH in "${BENCHMARKS[@]}"; do
        python3 -m $SCRIPT ${BENCH} -t $METRIC -b 16 --num-base $NUM_BASE --num-complex $NUM_COMPLEX
    done
done