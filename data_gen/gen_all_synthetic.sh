SCRIPT_PATH="data_gen.dataset_gen"
PRJ_PATH="data_gen/dataset/synthetic"
FILTERED_PRJ_PATH="data_gen/dataset/filtered/synthetic"
BENCH_DIR="data/benchmarks/synthetic/PowerGear"
DCT_DIR="data/directives/synthetic/complex"
BASE_DCT_DIR="data/directives/synthetic/base"

BENCHMARKS=(
    "aA"
    "aAB"
    "aABplusBC"
    "aAx"
    "ABC"
    "ABx_1"
    "ABx_2"
    "AplusB"
    "mac_1"
    "mac_2"
    "mac_3"
    "xy"
)

for BENCH in "${BENCHMARKS[@]}"; do
    echo ""
    echo "Generating solutions for ${BENCH}"
    python3 -m ${SCRIPT_PATH} -p "${PRJ_PATH}/${BENCH}" -s "${BENCH_DIR}/${BENCH}/${BENCH}.c" -tf ${BENCH} -d "${DCT_DIR}/${BENCH}.json" -bd "${BASE_DCT_DIR}/${BENCH}.json" -m 300 -s0
    python3 "${PRJ_PATH}/${BENCH}" "${FILTERED_PRJ_PATH}/${BENCH}"
done

