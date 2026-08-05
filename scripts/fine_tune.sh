#!/bin/bash

BENCHMARK=$1

METRICS=(
    "area"
    "power"
    "cycles"
    "clock"
)

for METRIC in "${METRICS[@]}"; do
    echo "========================================================================"
    echo "Starting Fine-Tuning for Benchmark: ${BENCHMARK}"
    echo "Target Metric: ${METRIC}"
    echo "========================================================================"

    FINE_TUNING_SCRIPT=estimator.${METRIC}.fine_tuning.fine_tune
    MODELS_DIR=estimator/${METRIC}/models

    python3 -m $FINE_TUNING_SCRIPT "${MODELS_DIR}/${BENCHMARK}"
done