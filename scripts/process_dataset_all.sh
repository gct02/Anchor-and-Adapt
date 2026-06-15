#!/bin/bash

METRICS=(
    "logic"
    "power"
    "cycles"
    "clock"
    "bram"
    "dsp"
)

for METRIC in "${METRICS[@]}"; do
    python -m scripts.process_dataset_${METRIC} -d ../dataset-filtered
done