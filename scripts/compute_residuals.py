import numpy as np
import matplotlib.pyplot as plt
import seaborn as sns


def mad(residuals):
    return np.mean(np.abs(residuals - np.median(residuals)))


def parse_residuals(log_file):
    with open(log_file, 'r') as file:
        lines = file.readlines()
    lines = lines[1:]  # Skip header

    residuals = []
    for line in lines:
        _, target, pred = map(float, line.strip().split(','))
        residuals.append(target - pred)

    residuals = np.array(residuals)

    return residuals


def plot_residuals(residuals):
    plt.figure(figsize=(12, 8), dpi=150)
    sns.histplot(residuals, bins=100, kde=True, color='royalblue', stat='density', alpha=0.6)

    mean_res = np.mean(residuals)
    median_res = np.median(residuals)

    plt.axvline(mean_res, color='red', linestyle='--', label=f'Mean: {mean_res:.3f}')
    plt.axvline(median_res, color='green', linestyle='--', label=f'Median: {median_res:.3f}')
    plt.axvline(0, color='black', linestyle=':', linewidth=1, label='Zero Residual')

    std_res = np.std(residuals)
    mad_res = mad(residuals)

    plt.text(
        0.1, 0.98, f'Std: {std_res:.3f}\nMAD: {mad_res:.3f}',
        horizontalalignment='right', verticalalignment='top',
        transform=plt.gca().transAxes, fontsize=12,
        bbox=dict(
            facecolor='white', alpha=0.5, 
            edgecolor='grey', boxstyle='round,pad=0.3'
        )
    )
    plt.xlabel('Residual', fontsize=12)
    plt.ylabel('Density', fontsize=12)
    plt.title('Distribution of Residuals', fontsize=14)
    plt.legend()
    plt.grid(True, linestyle='--', alpha=0.5)
    plt.tight_layout()
    plt.show()
    

if __name__ == '__main__':
    from sys import argv

    log_file = argv[1]
    residuals = parse_residuals(log_file)
    plot_residuals(residuals)
    