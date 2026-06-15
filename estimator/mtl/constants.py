# --- Metrics & Directives (DSE Domain) ---

AREA_METRICS = ['bram', 'dsp', 'ff', 'lut']
POWER_METRICS = ['dynamic_power']
TIMING_METRICS = ['achieved_clk', 'cc']

METRICS = sorted(AREA_METRICS + POWER_METRICS + TIMING_METRICS)

COMPUTE_AREA_METRICS = ["dsp", "ff", "lut"]
MEM_AREA_METRICS = ["bram", "ff", "lut"]
LOGIC_AREA_METRICS = ["ff", "lut"]

EXTENDED_METRICS = [
    "achieved_clk", "bram", "cc", "dsp", "dynamic_power",
    "edp", "energy", "ff", "latency", "lut"
]

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

# Operations with floating-point output
FLOAT_OPS = {
    "fadd", "fsub", "fmul", "fdiv", "frem", "fsqrt", "frsqrt", "fexp", "flog", "frecip",
    "dadd", "dsub", "dmul", "ddiv", "drem", "dsqrt", "drsqrt", "dexp", "dlog", "drecip",
    "hadd", "hsub", "hdiv", "hmul", "hsqrt", "facc", "fmacc", "fmadd",
    "sitofp", "sitodp", "uitofp", "uitodp", "fpext", "dext"
}

OPTYPE_MAP = {
    **{op: "optype_arith" for op in ARITH_OPS},
    **{op: "optype_logic" for op in LOGIC_CMP_AND_MUX_OPS},
    **{op: "optype_control" for op in ["br", "switch", "ret", "call", "phi"]},
    **{op: "optype_read" for op in ["load", "read"]},
    **{op: "optype_write" for op in ["store", "write"]},
    **{op: "optype_gep" for op in ["getelementptr"]},
    "other": "optype_other"
}

OPTYPE_SET = set(OPTYPE_MAP.values())
OPTYPES = sorted(list(OPTYPE_SET))

OPS_TO_TRIM = {
    "bitcast", "zext", "sext", "trunc",
    "inttoptr", "ptrtoint",
    "bitconcatenate", "bitselect", "partselect", 
    "insertvalue", "extractvalue"
}


# --- Node Features ---

NODE_FEATURES = {
    "mem_buf": [
        *[f"anchor_{m}" for m in MEM_AREA_METRICS],
        "bitwidth", "array_size",
        "is_local", "is_global", "is_port",
        "is_interface", "is_ram", "is_rom",
        "2p_read", "2p_write",
        "max_reads_in_iter", "max_writes_in_iter",
        "part_factor", "part_size", "part_type",
        "part_bitsize", "estimated_bram"
    ],
    "op": [
        *OPTYPES,
        *[f"anchor_{m}" for m in COMPUTE_AREA_METRICS],
        "bitwidth", "delay", "latency", "is_float"
    ],
    "block": [
        "is_entry", "is_exit"
    ],
    "region": [
        *[f"anchor_{m}" for m in AREA_METRICS],
        "region_latency", "trip_count", "is_top_function", 
        "is_top_loop", "is_innermost", 
        "resmii", "recmii", "num_phi_nodes", 
        "is_part_of_perfect_nest", "unroll_factor", 
        "pipeline", "pipeline_off", "pipelined_parent", 
        "loop_flatten", "loop_merge"
    ]
}

FEATURES_TO_LOG_SCALE = {
    *{f"anchor_{m}" for m in AREA_METRICS},
    "bitwidth", "array_size", "region_latency", 
    "max_reads_in_iter", "max_writes_in_iter",
    "trip_count", "resmii", "recmii", 
    "unroll_factor", "part_factor", 
    "part_size", "part_bitsize", "estimated_bram"
}

DIRECTIVE_FEATURES = {
    "mem_buf": [
        "part_factor", "part_size", "part_type",
        "part_bitsize", "estimated_bram"
    ],
    "op": [],
    "block": [],
    "region": [
        "unroll_factor", "pipeline", 
        "pipeline_off", "pipelined_parent", 
        "loop_flatten", "loop_merge"
    ]
}

DIRECTIVE_FEATURE_INDEX_MAP = {
    nt: {k: NODE_FEATURES[nt].index(k) for k in feats}
    for nt, feats in DIRECTIVE_FEATURES.items()
}

NODE_DIM_DICT = {nt: len(feats) for nt, feats in NODE_FEATURES.items()}
MAX_NODE_DIM = max(list(NODE_DIM_DICT.values()))


# --- Node & Edge Types ---

NODE_TYPES = sorted(list(NODE_FEATURES.keys()))
NODE_TYPE_SET = set(NODE_TYPES)

EDGE_TYPES = [
    ("op", "data", "op"), ("mem_buf", "data", "op"),
    ("op", "data_rec", "op"),

    ("block", "control", "block"), 
    ("block", "control_rec", "block"),

    ("op", "call", "region"), ("op", "ret", "op"),
    ("region", "inst", "region"), 
    ("region", "inst_rev", "region"),
    ("mem_buf", "arg", "mem_buf"), ("op", "arg", "mem_buf"),

    ("region", "hier", "region"), ("block", "hier", "region"),
    ("op", "hier", "block"), ("mem_buf", "hier", "block"),
    ("region", "hier_rev", "region"), 

    ("mem_buf", "access", "region"), 
    ("region", "access_rev", "mem_buf"),

    ("mem_buf", "interface", "region")
] + [
    (nt, "self", nt) for nt in NODE_TYPES
]
EDGE_TYPE_SET = set(EDGE_TYPES)

MACRO_NODE_TYPES = ["block", "region"]
MACRO_NODE_TYPE_SET = set(MACRO_NODE_TYPES)

MACRO_EDGE_TYPES = [
    (s, r, d) for s, r, d in EDGE_TYPES
    if s in MACRO_NODE_TYPE_SET and d in MACRO_NODE_TYPE_SET
    and r in {"hier", "inst", "self"}
]
MACRO_EDGE_TYPE_SET = set(MACRO_EDGE_TYPES)


# --- Paths ---

BENCHMARK_INFO_PATH = "data/benchmark_info.json"
PERFECT_NESTS_PASS_PATH = "./llvm_passes/build/PerfectNests/ExtractPerfectNests.so"
ARRAY_PROFILER_PASS_PATH = "./llvm_passes/build/ArrayProfiler/ArrayProfiler.so"