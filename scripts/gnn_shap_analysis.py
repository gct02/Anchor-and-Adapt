import os
import pickle

import shap
import numpy as np
import xgboost as xgb
import matplotlib.pyplot as plt
from interpret.glassbox import ExplainableBoostingRegressor
from interpret import set_visualize_provider
from interpret.provider import DashProvider

from estimators.area.graph import GRAPH_ATTRS

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
        'loop1', 'loop2', 'loop3',
        'loop4', 'loop5', 'loop6'
    },
    'GSM': {
        'Autocorrelation_label0', 'Autocorrelation_label1',
        'Autocorrelation_label2', 'Autocorrelation_label3',
        'Autocorrelation_label4', 'Autocorrelation_label5',
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
        'sha_transform_label1', 'sha_transform_label2',
        'sha_transform_label3', 'sha_transform_label4',
        'sha_transform_label5', 'sha_transform_label6'
    },
    'STENCIL3D': {
        'height_bound_col', 'height_bound_row',
        'col_bound_height', 'col_bound_row',
        'row_bound_height', 'row_bound_col',
        'loop_height', 'loop_col', 'loop_row'
    },
    'TRANS_FFT': {
        'loop1', 'loop2', 'loop3', 'loop4', 'loop5',
        'loop6', 'loop7', 'loop8', 'loop9', 'loop10', 'loop11'
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

DATASET_DIR = 'estimators/area/dataset/test_ADPCM/raw'


def explain_model(model, X_feat):
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
        max_display=30, alpha=0.4,
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
        n_estimators=1000,
        learning_rate=1e-2,
        max_depth=10,
        random_state=42
    )
    model.fit(X_feat, y_mape)
    return model


def process_data(benchmark, predictions_path):
    mape_dict = parse_mapes(predictions_path)
    dataset_dir = os.path.join(DATASET_DIR, benchmark)
    data_tuples = []
    feat_names = None

    for idx, mape in mape_dict.items():
        graph_path = os.path.join(dataset_dir, f'solution{idx}/graph.pkl')
        if not os.path.exists(graph_path):
            print(f"Graph file does not exist for solution {idx}.")
            continue
        print(f"Processing graph for solution {idx}...")

        with open(graph_path, 'rb') as f:
            graph = pickle.load(f)

        dct_feat_dict = extract_dct_features(graph)
        dct_feats = list(dct_feat_dict.values())

        if feat_names is None:
            dct_feat_names = list(dct_feat_dict.keys())
            feat_names = dct_feat_names + GRAPH_ATTRS

        graph_attr = [graph.graph_attr[key] for key in GRAPH_ATTRS]
        feats = dct_feats + graph_attr
        data_tuples.append((feats, mape))
        
    data_tuples = sorted(data_tuples, key=lambda x: x[1], reverse=True)
    feats = np.array([data[0] for data in data_tuples], dtype=np.float32)
    mapes = np.array([data[1] for data in data_tuples], dtype=np.float32)

    return feats.reshape(feats.shape[0], -1), mapes, feat_names


def extract_dct_features(kernel_graph):
    target_arrays = TARGET_ARRAY_DICT[kernel_graph.benchmark_name]
    target_loops = TARGET_LOOP_DICT[kernel_graph.benchmark_name]
    dct_feat_dict = {}
    processed_nodes = set()

    for node in kernel_graph.nodes.values():
        if (node.node_type in ['internal_mem', 'port'] and node.is_array and 
            node.name in target_arrays and node.name not in processed_nodes):
            dct_feat_dict.update({
                f'{node.name}.ap': node.feature_dict['array_partition'],
                f'{node.name}.ap.cyclic': node.feature_dict['partition_type'][0],
                f'{node.name}.ap.block': node.feature_dict['partition_type'][1],
                f'{node.name}.ap.complete': node.feature_dict['partition_type'][2],
                f'{node.name}.ap.factor': node.feature_dict['partition_factor'],
                f'{node.name}.unv': node.feature_dict['is_unevenly_partitioned'],
                f'{node.name}.hyb': node.feature_dict['has_hybrid_impl'],
            })
            processed_nodes.add(node.name)
        elif (node.node_type == 'region' and node.is_loop and
            node.name in target_loops and node.name not in processed_nodes):
            dct_feat_dict.update({
                f'{node.name}.uf': node.feature_dict['unroll_factor'],
                f'{node.name}.pl': node.feature_dict['pipeline'],
                f'{node.name}.lf': node.feature_dict['loop_flatten'],
                f'{node.name}.lm': node.feature_dict['loop_merge']
            })
            processed_nodes.add(node.name)
        elif node.node_type == 'function' and node.name not in processed_nodes:
            dct_feat_dict.update({
                f'{node.name}.il': node.feature_dict['inline'],
                f'{node.name}.df': node.feature_dict['dataflow'],
                f'{node.name}.lm': node.feature_dict['loop_merge'],
            })
            processed_nodes.add(node.name)
        
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
    parser.add_argument('-o', '--output', type=str, default=None, help='Output file for SHAP values plot')
    return parser.parse_args()


if __name__ == "__main__":
    args = parse_args()
    benchmark = args.benchmark.upper()
    predictions_path = args.predictions
    output_path = args.output

    X_feat, y_mape, feat_names = process_data(benchmark, predictions_path)

    model = train_model(X_feat, y_mape)
    shap_values = explain_model(model, X_feat)

    plot_shap_values(X_feat, shap_values, feat_names, output_path)
    explain_model_ebm(X_feat, y_mape, feat_names)