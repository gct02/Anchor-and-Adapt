#!/bin/bash

SOURCE_DATASET_DIR=$1

METRICS=(
    "area"
    "power"
    "cycles"
    "clock"
)

for METRIC in "${METRICS[@]}"; do
    python -m scripts.process_dataset_${METRIC} -d ${SOURCE_DATASET_DIR}
done