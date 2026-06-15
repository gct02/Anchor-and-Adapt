import os
import json
import pickle

import numpy as np
import pandas as pd

import shap
import numpy as np
import xgboost as xgb
import matplotlib.pyplot as plt
from interpret.glassbox import ExplainableBoostingRegressor
from interpret import set_visualize_provider
from interpret.provider import DashProvider

REQUIRED_METRICS = ['lut', 'ff', 'dsp', 'bram', 'cc', 'achieved_clk', 'dynamic_power']

set_visualize_provider(DashProvider.from_address(('127.0.0.1', 7001)))

TARGET_LOOP_DICT = {
    'ADPCM': {
        'adpcm_main_label12', 'adpcm_main_label13',
        'encode_label0', 'encode_label1',
        'decode_label2', 'decode_label3',
        'reset_label4', 'reset_label5',
        'reset_label6', 'reset_label7',
        'filtez_label8', 'quantl_label9',
        'upzero_label10', 'upzero_label11'
    },
    'AES': {
        "AddRoundKey_InversMixColumn_label0", "AddRoundKey_InversMixColumn_label1", 
        "AddRoundKey_InversMixColumn_label2", "AddRoundKey_InversMixColumn_label3", 
        "encrypt_label1", "decrypt_label4",
        "MixColumn_AddRoundKey_label0", "MixColumn_AddRoundKey_label1", 
        "KeySchedule_label4", "KeySchedule_label5", 
        "KeySchedule_label6", "KeySchedule_label8", 
        "KeySchedule_label9", "AddRoundKey_label0"
    },
    'BACKPROP': {
        "matrix_vector_product_with_bias_input_layer_loop1",
        "matrix_vector_product_with_bias_input_layer_loop1_1",
        "matrix_vector_product_with_bias_second_layer_loop1",
        "matrix_vector_product_with_bias_second_layer_loop1_1",
        "matrix_vector_product_with_bias_output_layer_loop1",
        "matrix_vector_product_with_bias_output_layer_loop1_1",
        "get_oracle_activations1_loop1", "get_oracle_activations1_loop1_1",
        "get_oracle_activations2_loop1", "get_oracle_activations2_loop1_1",
        "get_delta_matrix_weights1_loop1", "get_delta_matrix_weights1_loop1_1",
        "get_delta_matrix_weights2_loop1", "get_delta_matrix_weights2_loop1_1",
        "get_delta_matrix_weights3_loop1", "get_delta_matrix_weights3_loop1_1",
        "update_weights_loop1", "update_weights_loop1_1", "update_weights_loop2",
        "update_weights_loop3", "update_weights_loop3_1", "update_weights_loop4",
        "update_weights_loop5", "update_weights_loop5_1", "update_weights_loop6", 
        "update_weights_loop7", "update_weights_loop7_1", "update_weights_loop8",
        "update_weights_loop9", "update_weights_loop9_1", "update_weights_loop10", 
        "update_weights_loop11", "update_weights_loop11_1", "update_weights_loop12",
        "backprop_loop1"
    },
    'GEMM': {
        "loopjj", "loopkk", "loopi", 'loopk', 'loopj'
    },
    'GRAMSCHMIDT': {
        'loop1', 'loop2', 'loop3', 'loop4', 'loop5', 'loop6'
    },
    'GSM': {
        'Autocorrelation_label0', 'Autocorrelation_label1', 'Autocorrelation_label2', 
        'Autocorrelation_label3', 'Autocorrelation_label4', 'Autocorrelation_label5',
        'Reflection_coefficients_label0', 'Reflection_coefficients_label1',
        'Reflection_coefficients_label2', 'Reflection_coefficients_label3',
        'Reflection_coefficients_label4', 'Reflection_coefficients_label5',
        'Reflection_coefficients_label6', 'gsm_div_label0'
    },
    'KNN': {
        'loop_i', 'loop_j'
    },
    'SHA': {
        'local_memset_label0', 'local_memset_label1', 'sha_update_label4',
        'sha_transform_label1', 'sha_transform_label2', 'sha_transform_label3', 
        'sha_transform_label4', 'sha_transform_label5', 'sha_transform_label6'
    },
    'STENCIL3D': {
        'height_bound_col', 'height_bound_row', 'col_bound_height', 
        'col_bound_row', 'row_bound_height', 'row_bound_col',
        'loop_height', 'loop_col', 'loop_row'
    },
    'TRANS_FFT': {
        'loop1', 'loop2', 'loop3', 'loop4', 'loop5', 'loop6', 
        'loop7', 'loop8', 'loop9', 'loop10', 'loop11'
    }
}

TARGET_ARRAY_DICT = {
    'ADPCM': {'encoded'},
    'AES': {'Sbox', 'InvSbox', 'statemt'},
    'BACKPROP': {
        'weights1', 'weights2', 'weights3', 
        'biases1', 'biases2', 'biases3', 
        'training_data', 'training_targets', 
        'delta_weights1', 'delta_weights2', 'd_weights3'
    },
    'GEMM': {'m1', 'm2', 'prod'},
    'GRAMSCHMIDT': {'A', 'R', 'Q'},
    'GSM': {'bitoff', 'indata', 'L_ACF'},
    'KNN': {'NL', 'force_x', 'force_y', 'force_z', 'position_x', 'position_y', 'position_z'},
    'SHA': {'sha_info_digest', 'W'},
    'STENCIL3D': {'orig', 'sol'},
    'TRANS_FFT': {'reversed', 'DATA_x', 'DATA_y', 'data_x', 'data_y', 'smem'}
}

DATASET_DIR = 'estimator/dataset/raw'


def explain_model(model, X_feat) -> np.ndarray:
    explainer = shap.TreeExplainer(model, X_feat)
    shap_values = explainer.shap_values(X_feat)
    return shap_values


def explain_model_ebm(X_feat, y_mape, feat_names):
    ebm_explainer = ExplainableBoostingRegressor(feature_names=feat_names)
    ebm_explainer.fit(X_feat, y_mape)
    ebm_results = ebm_explainer.explain_global()
    go_fig = ebm_results.visualize()
    go_fig.update_layout(
        title="Explainable Boosting Machine Global Explanation",
        width=1000,
        height=600
    )
    go_fig.show(renderer='browser')


def plot_shap_values(X_feat, shap_values, feat_names, output_path=None):
    shap.summary_plot(
        shap_values, X_feat, 
        feature_names=feat_names, 
        max_display=20, alpha=0.4,
        show_values_in_legend=True,
        color=X_feat, show=False
    )
    if output_path:
        plt.savefig(output_path, bbox_inches='tight')
    else:
        plt.show()
    plt.close()


def train_model(X_feat, y_mape):
    model = xgb.XGBRegressor(
        objective='reg:squarederror',
        n_estimators=500,
        learning_rate=1e-2,
        max_depth=10,
        random_state=42
    )
    model.fit(X_feat, y_mape)
    return model


def process_data(benchmark, predictions_path, base_only=False):
    if base_only:
        with open("data/benchmark_info.json", "r") as f:
            bench_info_dict = json.load(f)
        last_base_index = bench_info_dict.get(benchmark, {}).get("last_base_index", 0)
    else:
        last_base_index = 1e6

    dataset_dir = os.path.join(DATASET_DIR, benchmark)
    graph_paths = {}

    for solution_dir in os.listdir(dataset_dir):
        if not solution_dir.startswith('solution'): continue

        solution_index = int(solution_dir.replace('solution', ''))
        if solution_index > last_base_index: continue
        
        graph_path = os.path.join(dataset_dir, f'{solution_dir}/graph.pkl')
        metrics_path = os.path.join(dataset_dir, f'{solution_dir}/metrics.json')
        if not (os.path.exists(graph_path) and os.path.exists(metrics_path)): continue

        with open(metrics_path, 'r') as f:
            metrics = json.load(f)
        
        if any([metrics.get(k, -1) < 0 for k in REQUIRED_METRICS]): continue

        graph_paths[solution_index] = graph_path

    mape_dict = parse_mapes(predictions_path)
    data_tuples = []
    feat_names = None

    for solution_index, mape in mape_dict.items():
        if solution_index not in graph_paths: continue
        graph_path = graph_paths[solution_index]

        with open(graph_path, 'rb') as f:
            graph = pickle.load(f)

        dct_feat_dict = extract_dct_features(graph)

        if feat_names is None:
            dct_feat_names = list(dct_feat_dict.keys())
            feat_names = dct_feat_names # + DIRECTIVE_GRAPH_ATTRS

        feats = list(dct_feat_dict.values()) # + graph_attr
        data_tuples.append((feats, mape))
        
    # data_tuples = sorted(data_tuples, key=lambda x: x[1], reverse=True)
    feats = np.array([data[0] for data in data_tuples], dtype=np.float32)
    mapes = np.array([data[1] for data in data_tuples], dtype=np.float32)

    return feats.reshape(feats.shape[0], -1), mapes, feat_names


def extract_dct_features(graph):
    target_arrays = TARGET_ARRAY_DICT[graph.benchmark_name]
    target_loops = TARGET_LOOP_DICT[graph.benchmark_name]
    dct_feat_dict = {}
    processed_nodes = set()

    for node in graph.nodes.values():
        if node.tag in processed_nodes: continue

        if node.type in ['data', 'port'] and node.is_array and node.tag in target_arrays:
            dct_feat_dict.update({
                f'{node.tag}.ap': node.feature_dict['array_partition'],
                f'{node.tag}.ap.factor': node.feature_dict['partition_factor'],
            })
            processed_nodes.add(node.tag)
        elif node.type == 'region' and node.is_loop and node.tag in target_loops:
            dct_feat_dict.update({
                f'{node.tag}.unr': node.feature_dict['unroll'],
                f'{node.tag}.unr.factor': node.feature_dict['unroll_factor'],
                f'{node.tag}.unr.full': node.feature_dict['full_unroll'],
                f'{node.tag}.pipe': node.feature_dict['pipeline'],
                f'{node.tag}.pipe.off': node.feature_dict['pipeline_off'],
                f'{node.tag}.lf': node.feature_dict['loop_flatten'],
                f'{node.tag}.lm': node.feature_dict['loop_merge']
            })
            processed_nodes.add(node.tag)
        elif node.type == 'region' and node.is_function:
            dct_feat_dict.update({
                # f'{node.tag}.in': node.feature_dict['inline'],
                f'{node.tag}.lm': node.feature_dict['loop_merge'],
            })
            processed_nodes.add(node.tag)
        
    return dct_feat_dict


def parse_mapes(predictions_path):
    with open(predictions_path, 'r') as f:
        lines = f.readlines()
    lines = lines[1:] # Skip header

    mape_dict = {}
    for line in lines:
        idx, target, pred = line.strip().split(',')
        idx, target, pred = int(idx), float(target), float(pred)
        mape_dict[idx] = abs(target - pred) / (abs(target) + 1e-6)

    return mape_dict


def parse_args():
    import argparse
    parser = argparse.ArgumentParser(description="GNN Explainer Script")
    parser.add_argument('-b', '--benchmark', type=str, required=True, help='Benchmark name')
    parser.add_argument('-p', '--predictions', type=str, required=True, help='Path to predictions file')
    parser.add_argument('-o', '--plot-path', type=str, default=None, help='Output file for SHAP values plot')
    parser.add_argument('-r', '--risk-path', type=str, default=None, help='Output CSV for SHAP risk analysis')
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    benchmark = args.benchmark.upper()
    predictions_path = args.predictions
    plot_path = args.plot_path
    risk_path = args.risk_path

    X_feat, y_mape, feat_names = process_data(benchmark, predictions_path)

    model = train_model(X_feat, y_mape)
    shap_values = explain_model(model, X_feat)

    df_shap = pd.DataFrame(shap_values, columns=feat_names)
    df_feat = pd.DataFrame(X_feat, columns=feat_names) # We need feature values to see correlation

    risk_analysis = []

    for feature in feat_names:
        shap_vals = df_shap[feature]
        feat_vals = df_feat[feature]
        
        # 1. Global Impact
        impact = shap_vals.abs().mean()
        
        # 2. "Hardness" (Mean SHAP only when it increases error)
        risk_score = shap_vals[shap_vals > 0].mean() if (shap_vals > 0).any() else 0.0
        
        # 3. Correlation (Does higher value = higher error?)
        # Positive corr = Harder as value increases (e.g., Unroll Factor)
        # Negative corr = Easier as value increases
        correlation = np.corrcoef(feat_vals, shap_vals)[0, 1] if np.std(feat_vals) > 0 else 0
        
        risk_analysis.append({
            'feature': feature,
            'impact': impact,
            'risk_score': risk_score,
            'correlation': correlation,
            'risk_correlation': risk_score * correlation
        })

    # Convert to DataFrame and Sort by RISK, not just impact
    df_risk = pd.DataFrame(risk_analysis)
    
    # Filter: Directives that are actually impactful AND risky
    hardest_directives = df_risk.sort_values(by=['risk_correlation', 'risk_score', 'impact'], ascending=False)

    if risk_path:
        hardest_directives.to_csv(risk_path)
    else:    
        print("\n=== TOP 15 HARDEST DIRECTIVES (Drivers of Error) ===")
        print(hardest_directives[['feature', 'risk_score', 'correlation']].head(15))

    # print("\n=== TOP 10 EASIEST DIRECTIVES (Drivers of Success) ===")
    # # High impact but low risk means they actively drive error down
    # easiest_directives = df_risk.sort_values(by=['impact', 'risk_score'], ascending=[False, True])
    # print(easiest_directives[['feature', 'impact', 'risk_score']].head(10))

    plot_shap_values(X_feat, shap_values, feat_names, plot_path)
    # explain_model_ebm(X_feat, y_mape, feat_names)