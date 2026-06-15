# --- Metrics & Directives (DSE Domain) ---

AREA_METRICS = ['bram', 'dsp', 'ff', 'lut']
POWER_METRICS = ['dynamic_power']
TIMING_METRICS = ['achieved_clk', 'cc']

METRICS = sorted(AREA_METRICS + POWER_METRICS + TIMING_METRICS)

COMPUTE_AREA_METRICS = ["dsp", "ff", "lut"]
MEM_AREA_METRICS = ["bram", "ff", "lut"]
LOGIC_AREA_METRICS = ["ff", "lut"]

# Total number of resources available on the target device
# (xcu50-fsvh2104-2-e)
AVAILABLE_RESOURCES = {
    "lut": 871680,
    "ff": 1743360,
    "dsp": 5952,
    "bram": 2688
}

 # Default target clock period in ns
TARGET_CLOCK_PERIOD = 8.0

BRAM_18K_BITS = 18432
LUTRAM_THRESHOLD = 1024

DIRECTIVES = [
    "array_partition", "loop_flatten", "loop_merge",
    "pipeline", "unroll"
]

BENCHMARKS = [
    'ADPCM', 'AES', 'BACKPROP', 'GEMM', 'GRAMSCHMIDT', 
    'GSM', 'KNN', 'SHA', 'STENCIL3D', 'TRANS_FFT'
]
BENCHMARK_INDEX_MAP = {b: i for i, b in enumerate(BENCHMARKS)}


# --- IR Operations ---

ARITH_OPS = {
    "add", "sub", "mul", "udiv", "sdiv", "urem", "srem", "ashr",
    "fadd", "fsub", "fmul", "fdiv", "frem", "fsqrt", "frsqrt", "fexp", "flog", "frecip",
    "dadd", "dsub", "dmul", "ddiv", "drem", "dsqrt", "drsqrt", "dexp", "dlog", "drecip",
    "hadd", "hsub", "hdiv", "hmul", "hsqrt", 
    "facc", "fmacc", "fmadd"
}
CAST_OPS = {
    "sitofp", "sitodp", "uitofp", "uitodp", 
    "dptosi", "dptoui", "fptosi", "fptoui", 
    "sext", "fpext", "dext", "inttoptr", "ptrtoint",
    "bitcast", "zext", "trunc", "bitconcatenate", "bitselect", 
    "partselect", "insertvalue", "extractvalue"
}
LOGIC_CMP_AND_MUX_OPS = {
    "and", "or", "xor", "shl", "lshr", 
    "icmp", "fcmp", "dcmp", 
    "select", "mux", "sparsemux"
}

BINARY_OPS = {*ARITH_OPS, "and", "or", "xor", "icmp", "fcmp", "dcmp"}

MEM_RW_OPS = {"load", "store", "read", "write"}

# Ops with floating-point output
FLOAT_OPS = {
    "fadd", "fsub", "fmul", "fdiv", "frem", "fsqrt", "frsqrt", "fexp", "flog", "frecip",
    "dadd", "dsub", "dmul", "ddiv", "drem", "dsqrt", "drsqrt", "dexp", "dlog", "drecip",
    "hadd", "hsub", "hdiv", "hmul", "hsqrt", "facc", "fmacc", "fmadd",
    "sitofp", "sitodp", "uitofp", "uitodp", "fpext", "dext"
}


# --- Paths ---

BENCHMARK_INFO_PATH = "data/benchmark_info.json"
PERFECT_NESTS_PASS_PATH = "./llvm_passes/build/PerfectNests/ExtractPerfectNests.so"
ARRAY_PROFILER_PASS_PATH = "./llvm_passes/build/ArrayProfiler/ArrayProfiler.so"