#!/bin/bash
set -e

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

for METRIC in "${METRICS[@]}"; do
    # The Python script to run (adjust if necessary)
    TRAIN_SCRIPT="estimator.${METRIC}.train"  # Note: Running as a module
    DATASET_DIR="estimator/${METRIC}/dataset"

    echo "========================================================================"
    echo "Starting Cross-Validation Rotation"
    echo "Benchmarks: ${#BENCHMARKS[@]}"
    echo "Target Metric: ${METRIC}"
    echo "========================================================================"

    rm -rf "estimator/${METRIC}/models"

    for BENCH in "${BENCHMARKS[@]}"; do
        echo ""
        rm -rf "estimator/${METRIC}/dataset/processed"

        time python3 -m $TRAIN_SCRIPT \
            --test-bench $BENCH \
            --dataset-dir $DATASET_DIR \
            --loss "huber"

        echo "Finished run for $BENCH"
    done

    echo ""
    echo "All rotations completed."
    echo ""
done