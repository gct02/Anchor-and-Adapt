from typing import List, Optional, Union

import numpy as np
import pandas as pd
import seaborn as sns
import matplotlib.pyplot as plt
import torch
from torch import Tensor
from scipy.stats import kendalltau

from estimator.common.metrics import smape_loss

METRIC_NAME_MAP = {
    "cc": "Clock Cycles",
    "achieved_clk": "Clock Period",
    "dynamic_power": "Dynamic Power",
    "lut": "LUT",
    "ff": "FF",
    "dsp": "DSP",
    "bram": "BRAM",
    "latency": "Latency",
    "energy": "Energy"
}


def export_predictions_as_csv(
    targets: List[float],
    preds: List[float],
    errors: List[float],
    indices: List[int],
    output_path: str
):
    with open(output_path, 'w') as f:
        f.write("index,target,prediction,error\n")
        for i, t, p, e in zip(indices, targets, preds, errors):
            f.write(f"{i},{t},{p},{e}\n")


def plot_prediction_bars(
    targets: Union[Tensor, List[float]],
    preds: Union[Tensor, List[float]],
    indices: List[int],
    benchmark: str, 
    metric: str, 
    output_path: Optional[str] = None,
    errors: Optional[Union[Tensor, List[float]]] = None,
    mape: Optional[float] = None,
    sort_by_error: bool = True
):
    """Plot per-benchmark instance-level predictions and errors"""
    if errors is None:
        errors = smape_loss(preds, targets, metric, reduce=False)

    if mape is None:
        if isinstance(errors, Tensor): 
            mape = torch.mean(errors, dim=0).item()
        else:
            mape = np.mean(errors)

    if isinstance(errors, Tensor): errors = errors.flatten().tolist()
    if isinstance(targets, Tensor): targets = targets.flatten().tolist()
    if isinstance(preds, Tensor): preds = preds.flatten().tolist()

    n_instances = len(indices)
    if (n_instances != len(preds) 
        or n_instances != len(targets) 
        or n_instances != len(errors)):
        raise ValueError("Mismatch in number of targets, predictions and indices")

    df = pd.DataFrame({
        'index': indices,
        'target': targets,
        'prediction': preds,
        'error': errors
    })

    if sort_by_error:
        df = df.sort_values(by=['error'], ascending=True, ignore_index=True)

    _, ax = plt.subplots(figsize=(16, 8), dpi=350)
    sns.set_style("whitegrid")

    x = np.arange(n_instances)
    ax.bar(x, df['target'], color='blue', alpha=0.5, label='Targets')
    ax.bar(x, df['prediction'], color='darkorange', alpha=0.5, label='Predictions')

    max_val = max(df['target'].max(), df['prediction'].max())

    if max_val < 1e-6:
        # Targets and predictions are all zeros
        tau = 1.0
        max_val = 1e-4
    elif len(np.unique(df['target'])) > 1 and len(np.unique(df['prediction'])) > 1:
        tau, _ = kendalltau(df['target'], df['prediction'])
    else:
        tau = 0.0
        print(
            "Warning: Zero variance in targets or predictions. "
            "Cannot compute Kendall Tau."
        )

    ax.set_ylim(0, max_val * 1.2)
    ax.set_xlim(x[0] - 1, x[-1] + 1)

    for i, row in df.iterrows():
        p, t, r = row['prediction'], row['target'], row['error']
        ax.text(
        	i, max(p, t) + 0.005 * max_val, f"{r:.2f}%", 
        	rotation=90, ha='center', fontsize=4, alpha=0.9
        )

    ax.grid(axis='y', linestyle='--', alpha=0.7)
    ax.set_xticks(x)
    ax.set_xticklabels(
        df['index'], rotation=90, ha='center', va='top', fontsize=3.5, alpha=0.9
    )

    ax.text(
        0.1, 0.95, f"MAPE: {mape:.2f}%\nτ: {tau:.4f}", 
        transform=ax.transAxes, fontsize=11, ha='left'
    )

    metric_norm = METRIC_NAME_MAP.get(metric, metric.upper())

    ax.set_title(f"{metric_norm} Predictions for {benchmark}", fontsize=14)
    ax.set_xlabel('Solution Index', fontsize=12)
    ax.set_ylabel(metric_norm, fontsize=12)
    ax.legend()

    plt.tight_layout()
    if output_path is not None:
        plt.savefig(output_path, bbox_inches='tight', dpi=350)
    else:
        plt.show()
    plt.close()


def plot_learning_curves(
    train_errors: Union[Tensor, List[float]], 
    test_errors: Union[Tensor, List[float]], 
    output_path: str
):
    """Plot training and test errors over epochs"""
    if isinstance(train_errors, Tensor):
        train_errors = train_errors.tolist()
    if isinstance(test_errors, Tensor):
        test_errors = test_errors.tolist()

    num_epochs = len(train_errors)
    if num_epochs != len(test_errors):
        raise ValueError("Mismatch in number of training and test epochs")

    plt.figure(figsize=(12, 6), dpi=150)
    sns.set_style("whitegrid")

    df = pd.DataFrame({
        'Epoch': list(range(num_epochs)) * 2,
        'Error': train_errors + test_errors,
        'Type': ['Train'] * num_epochs + ['Test'] * num_epochs
    })
    ax = sns.lineplot(
        x='Epoch', y='Error', hue='Type', data=df, 
        palette={'Train': 'green', 'Test': 'red'}, 
        linewidth=2.5, marker='o'
    )
    plt.title(
        f'Training Progress (Final Test Error: {test_errors[-1]:.4f})', 
        fontsize=14
    )
    plt.xlabel('Epoch', fontsize=12)
    plt.ylabel('MAPE', fontsize=12)
    plt.legend()

    if np.max(test_errors) / np.min(test_errors) > 100:
        plt.yscale('log')

    plt.tight_layout()
    plt.savefig(output_path, bbox_inches='tight', dpi=150)
    plt.close()


def plot_prediction_scatter(
    targets: Union[Tensor, List[float]], 
    preds: Union[Tensor, List[float]], 
    benchmark: str, 
    metric: str, 
    output_path: str,
    mape: Optional[float] = None
):
    """Plot scatter plot of actual vs predicted values with regression line"""
    if mape is None:
        mape = smape_loss(preds, targets, metric).item()

    if isinstance(targets, Tensor): targets = targets.tolist()
    if isinstance(preds, Tensor): preds = preds.tolist()
    
    if len(targets) != len(preds):
        raise ValueError("Mismatch in number of targets and predictions")
    
    max_val = max(max(targets), max(preds))
    min_val = min(min(targets), min(preds))

    if max_val < 1e-6:
        # Targets and predictions are all zeros
        corr = 1.0
    elif len(np.unique(targets)) > 1 and len(np.unique(preds)) > 1:
        corr = np.corrcoef(targets, preds)[0, 1]
    else:
        corr = 0.0
        print(
            "Warning: Zero variance in targets or predictions. "
            "Cannot compute correlation coeficients."
        )

    plt.figure(figsize=(10, 10), dpi=200)
    sns.set_style("whitegrid")

    # Reference line for perfect prediction
    plt.plot(
        [min_val, max_val], [min_val, max_val], 'r--', 
        label='Perfect Prediction', alpha=0.7
    )
    # Regression line
    sns.regplot(
        x=targets, y=preds, scatter=False, color='blue', 
        label='Trend Line'
    )
    # Scatter plot
    sns.scatterplot(
        x=targets, y=preds, alpha=0.6, edgecolor='w', 
        label='Predictions'
    )

    plt.text(
        min_val*1.05, max(1e-4, max_val)*0.9, f'MAPE: {mape:.2f}\nR: {corr:.4f}', 
        bbox=dict(facecolor='white', alpha=0.8)
    )

    metric_norm = METRIC_NAME_MAP.get(metric, metric.upper())
    
    plt.title(f'Actual vs. Predicted {metric_norm} for {benchmark}', fontsize=14)
    plt.xlabel('Actual Values', fontsize=12)
    plt.ylabel('Predictions', fontsize=12)
    plt.legend()

    plt.tight_layout()
    plt.savefig(output_path, bbox_inches='tight', dpi=200)
    plt.close()