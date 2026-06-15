#!/bin/bash

METRIC=$1

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

SCRIPT=estimator.${METRIC}.fine_tuning.anchor_calibration
MODELS_DIR=estimator/${METRIC}/models
DATASET_DIR=estimator/${METRIC}/dataset/raw

for BENCH in "${BENCHMARKS[@]}"; do
    python3 -m ${SCRIPT} "${MODELS_DIR}/${BENCH}" \
        --anchor-path "${DATASET_DIR}/${BENCH}/anchor_graph.pkl"
done
