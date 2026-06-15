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

bash scripts/sample_solutions.sh $METRIC $NUM_BASE $NUM_COMPLEX

FINE_TUNING_SCRIPT=estimator.${METRIC}.fine_tuning.fine_tune
MODELS_DIR=estimator/${METRIC}/models

for BENCH in "${BENCHMARKS[@]}"; do
    python3 -m $FINE_TUNING_SCRIPT "${MODELS_DIR}/${BENCH}" -b 32
done
