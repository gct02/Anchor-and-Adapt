#!/bin/bash

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

# bash scripts/sample_solutions_all.sh

for METRIC in "${METRICS[@]}"; do
    echo "========================================================================"
    echo "Starting Fine-Tuning Rotation"
    echo "Target Metric: ${METRIC}"
    echo "========================================================================"

    FINE_TUNING_SCRIPT=estimator.${METRIC}.fine_tuning.fine_tune
    MODELS_DIR=estimator/${METRIC}/models

    for BENCH in "${BENCHMARKS[@]}"; do
        python3 -m $FINE_TUNING_SCRIPT "${MODELS_DIR}/${BENCH}" -b 32
    done
done