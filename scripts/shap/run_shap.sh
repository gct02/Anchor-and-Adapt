#!/bin/bash

METRIC=$1

BENCHMARKS=(
    "GEMM"
    "KNN"
    "ADPCM"
    "AES"
    "TRANS_FFT"
    "STENCIL3D"
    "SHA"
    "BACKPROP"
    "GSM"
    "GRAMSCHMIDT"
)

for TEST_BENCH in "${BENCHMARKS[@]}"; do
    python -m scripts.shap.gnn_shap_analysis \
        -b ${TEST_BENCH} \
        -p estimator/models/${METRIC}/${TEST_BENCH}/${METRIC}_predictions.csv \
        -o scripts/shap/outputs/${TEST_BENCH}_${METRIC}_shap.png \
        -r scripts/shap/outputs/${TEST_BENCH}_${METRIC}_shap_risk.csv
    echo "Finished run for ${TEST_BENCH}"
done