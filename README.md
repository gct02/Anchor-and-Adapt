# Anchor-and-Adapt

Fast and accurate GNN-based QoR estimator for High-Level Synthesis Design Space Exploration

## Project Overview

Graph Neural Networks (GNNs) have emerged as powerful tools for guiding Design Space Exploration (DSE) in High-Level Synthesis (HLS), but they face a critical trade-off: models that base inference on pre-HLS inputs are often inaccurate, while accurate models based on post-HLS inputs are too slow for iterative exploration. This paper introduces a novel framework that targets this dilemma. Our approach centers on an **anchor-based graph representation**, where a single, ground-truth hardware implementation is used to seed a design graph with rich, post-implementation data. A heterogeneous GNN is then trained to predict the QoR delta caused by applying new optimization directives to this anchor, enabling rapid and high-fidelity estimation without re-running the HLS toolchain.

## Instalation

### Dependencies

- Python 3.8+
- PyTorch
- PyTorch Geometric

All required Python packages can be installed from the `requirements.txt` file.

```bash
# 1. Create and activate a virtual environment
python3 -m venv .venv
source .venv/bin/activate

# 2. Install dependencies
pip install --upgrade pip
pip install -r requirements.txt
```

### LLVM Pass Compilation

The LLVM passes in this project access specific loop and array features required for the Multi-Level Annotation process. Although we used the [Vitis HLS LLVM Front-End](https://github.com/Xilinx/hls-llvm-project.git) for development, our implementation does not rely on any of its specific functionalities. Therefore, a standard LLVM installation is sufficient. We recommend using [LLVM 7.0](https://releases.llvm.org/), as this is the version the Vitis HLS Front-End is built on.

## Usage

### Setting Environment Variables

Before running any experiment, run the project configuration script to set the required environment variables:

```bash
source ./config.sh
```

### Main Workflow

The workflow is divided into two main stages: pre-training a model and fine-tuning it for a specific kernel.

#### 1. Pre-training

The pre-training is performed using a leave-one-out cross-validation scheme. To train a model using `<benchmark_name>` as the held-out test set, run:

```bash
python -m estimators.area.train --dataset-dir <path_to_dataset> --test-bench <benchmark_name>
```

#### 2. Fine-Tuning

To perform few-shot fine-tuning on a pre-trained model for a specific kernel, run the fine-tuning script:

```bash
python -m estimators.area.fine_tuning.fine_tune --model-dir <path_to_model> --dataset-dir <path_to_dataset>
```

## Citation

If you use this work, please cite our paper (details to be added upon publication).

```bibtex
@inproceedings{anonymous2026anchor,
  title={Anchor-and-Adapt: HLS QoR Prediction using Ground-Truth Seeding and Few-Shot Fine-Tuning},
  author={Anonymous Author(s)},
  booktitle={Anonymous Conference},
  year={2026}
}
```
