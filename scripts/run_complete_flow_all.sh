#!/bin/bash

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

METRICS=(
    "area"
    "power"
    "cycles"
    "clock"
)

for METRIC in "${METRICS[@]}"; do
    # 1. Pre-training

    TRAIN_SCRIPT="estimator.$METRIC.train"  # Note: Running as a module
    DATASET_DIR="estimator/$METRIC/dataset"

    echo "========================================================================"
    echo "Starting Cross-Validation Rotation"
    echo "========================================================================"

    # rm -rf "estimator/$METRIC/models"

    for BENCH in "${BENCHMARKS[@]}"; do
        echo ""
        rm -rf "estimator/$METRIC/dataset/processed"

        time python3 -m $TRAIN_SCRIPT \
            --test-bench $BENCH \
            --dataset-dir $DATASET_DIR \
            --loss "huber"

        echo "Finished run for $BENCH"
    done

    echo ""
    echo "All rotations completed."
    echo ""

    # 1. Calibrating & Specializing

    MODELS_DIR=estimator/$METRIC/models
    DATASET_DIR=estimator/$METRIC/dataset/raw

    echo "========================================================================"
    echo "Starting Fine-Tuning Rotation"
    echo "========================================================================"

    NUM_BASE=5
    NUM_COMPLEX=4

    SELECT_SCRIPT=estimator.common.fine_tuning.solution_sampler
    FINE_TUNING_SCRIPT=estimator.$METRIC.fine_tuning.fine_tune

    for BENCH in "${BENCHMARKS[@]}"; do
        echo ""
        
        python3 -m $SELECT_SCRIPT $BENCH -t $METRIC --num-base $NUM_BASE --num-complex $NUM_COMPLEX
        python3 -m $FINE_TUNING_SCRIPT "${MODELS_DIR}/${BENCH}" -b 32

        echo "Finished run for $BENCH"
    done

    echo ""
    echo "All rotations completed."
    echo ""

    echo "========================================================================"
    echo "Starting Anchor Calibration Rotation"
    echo "========================================================================"

    CALIBRATION_SCRIPT=estimator.$METRIC.fine_tuning.anchor_calibration

    for BENCH in "${BENCHMARKS[@]}"; do
        echo ""
        python3 -m $CALIBRATION_SCRIPT "${MODELS_DIR}/${BENCH}" \
            --anchor-path "${DATASET_DIR}/${BENCH}/anchor_graph.pkl"

        echo "Finished run for $BENCH"
    done
done