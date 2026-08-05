#!/bin/bash
set -e

BENCHMARK=$1

METRICS=(
    "area"
    "power"
    "cycles"
    "clock"
)

for METRIC in "${METRICS[@]}"; do
    # The Python script to run (adjust if necessary)
    TRAIN_SCRIPT="estimator.${METRIC}.train"  # Note: Running as a module
    DATASET_DIR="estimator/${METRIC}/dataset"

    rm -rf "estimator/${METRIC}/dataset/processed"

    time python3 -m $TRAIN_SCRIPT \
        --test-bench $BENCHMARK \
        --dataset-dir $DATASET_DIR \
        --loss "huber"

    echo "Finished run for $BENCHMARK"
done