# Anchor-and-Adapt

[![Python 3.8+](https://img.shields.io/badge/python-3.8+-blue.svg)](https://www.python.org/downloads/)
[![PyTorch](https://img.shields.io/badge/PyTorch-%23EE4C2C.svg?logo=PyTorch&logoColor=white)](https://pytorch.org/)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

An efficient and flexible GNN-based QoR estimator for multi-objective High-Level Synthesis Design Space Exploration.

## Project Overview

Graph Neural Networks (GNNs) have emerged as powerful tools for guiding Design Space Exploration (DSE) in High-Level Synthesis (HLS), but they face a critical trade-off: models that base inference on pre-HLS inputs are often inaccurate, while accurate models based on post-HLS inputs are too slow for iterative exploration.

This project introduces a novel framework that targets this dilemma. Our approach centers on an **anchor-based graph representation**, where a single, ground-truth hardware implementation is used to seed a design graph with rich, post-implementation data. A heterogeneous GNN is then trained to predict the Quality of Results (QoR) delta caused by applying new optimization directives to this anchor, enabling rapid and high-fidelity multi-objective estimation (Area, Dynamic Power, Clock Cycles, and Clock Period) without re-running the HLS toolchain.

If you find this repository useful, please cite our DATE 2026 paper:

```bibtex
@inproceedings{tavares2026anchor,
  title={Anchor-and-Adapt: HLS QoR Prediction using Ground-Truth Seeding and Few-Shot Fine-Tuning},
  author={Tavares, Gabriel C and De Andrade, Heitor C and Itturriet, F{\'a}bio P and Nazar, Gabriel L},
  booktitle={2026 Design, Automation \& Test in Europe Conference (DATE)},
  pages={1--7},
  year={2026},
  organization={IEEE}
}
```

_Note: The framework proposed in the DATE 2026 papers covers only area metrics. This repository, however, extends and adapts that framework for multiple QoR metrics (area, dynamic power, clock cycles, and achieved clock period)._

## Installation

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

### Building the Custom LLVM Passes

The custom LLVM passes used in this framework (`ArrayProfiler` and `PerfectNests`) are built out-of-source using CMake.

#### Prerequisites

Before building the passes, ensure your system has the following installed:

- **CMake** (version 3.13.4 or higher)
- **LLVM 14** (development libraries and headers)
- A C++ compiler supporting the **C++14 standard** (e.g., GCC or Clang)

#### Build Instructions

```bash
cd llvm_passes
mkdir build
cd build
cmake ..
make
```

## Dataset

The experiments rely on a comprehensive dataset of over 3,000 fully synthesized hardware designs across 10 applications from CHStone, MachSuite, and PolyBench.

You can download the dataset used in this framework here:
[Anchor-and-Adapt Dataset (MLDHLS.tar.gz)](http://www.inf.ufrgs.br/~glnazar/MLDHLS.tar.gz)

## Usage

### Data Processing

Assuming the dataset was downloaded from the link above and extracted to `<source_dataset_dir>`, to process the data to train and evaluate the models for all target metrics, run:

```bash
chmod +x scripts/process_dataset.sh
bash scripts/process_dataset.sh <source_dataset_dir>
```

This will generate four directories containing the raw data that can be further processed and used to train and evaluate the models:

- `estimator/area/dataset/raw` (for the area model)
- `estimator/power/dataset/raw` (for the dynamic power model)
- `estimator/cycles/dataset/raw` (for the clock cycles model)
- `estimator/clock/dataset/raw` (for the achieved clock period model)

Alternatively, it is possible to process the data for a single model, covering a unique target metric `<metric>`:

```bash
python -m scripts.process_dataset_<metric> --dataset-dir <source_dataset_dir>
```

### Main Workflow

The workflow is divided into three main stages: pre-training a model, fine-tuning it for a specific specialist kernel, and running inference.

#### 1. Pre-training

The pre-training is performed using a leave-one-out cross-validation scheme. To train the models for all target metrics, run:

```bash
chmod +x scripts/train.sh
bash scripts/train.sh <benchmark>
```

where `<benchmark>` is the target kernel to hold out as the test set. Valid options include `ADPCM`, `AES`, `BACKPROP`, `GEMM`, `GRAMSCHMIDT`, `GSM`, `KNN`, `SHA`, `STENCIL3D`, and `TRANS_FFT`.

After the training script finishes its operation, four directories will be available, containing the pre-trained ensemble models, the performance of the pre-trained ensemble in the held-out test set, and additional information about the training procedure:

- `estimator/area/models/<benchmark>` (for the area model)
- `estimator/power/models/<benchmark>` (for the dynamic power model)
- `estimator/cycles/models/<benchmark>` (for the clock cycles model)
- `estimator/clock/models/<benchmark>` (for the achieved clock period model)

Alternatively, you can train a single model for a target metric `<metric>` by running:

```bash
python -m estimator.<metric>.train --test-bench <benchmark>
```

#### 2. Fine-Tuning

To perform fine-tuning on the pre-trained models, using `<benchmark>` as the held-out test set, run:

```bash
chmod +x scripts/fine_tune.sh
bash scripts/fine_tune.sh <benchmark>
```

Alternatively, you can fine-tune a single model for a target metric `<metric>` by running:

```bash
python -m estimator.<metric>.fine_tuning.fine_tune <model_dir>
```

where `<model_dir>` is the directory where the pre-trained model (and additional training information) is located. For a target metric `<metric>` and held-out benchmark `<benchmark>`, this directory is automatically created by the pre-training script in `estimator/<metric>/models/<benchmark>` (unless another location for it is explicitly specified as command-line argument for the script).

#### 3. Anchor Calibration

Additionally, for lower time budgets, the pre-trained models can be rapidly "calibrated" on the anchor instance alone. We advise the user to execute this procedure only for the area and dynamic power metrics, as those were the only metrics where doing it effectively improved the model's performance on new instances. To run the calibration process for a pre-trained model located in `<model_dir>` using the anchor instance graph (`.pkl` file) located in `<anchor_path>` (this anchor should be from the same kernel that was held-out as test set to pre-train the model in `<model_dir>`), run:

```bash
python -m estimator.<metric>.fine_tuning.anchor_calibration <model_dir> --anchor-path <anchor_path>
```

where `<metric>` is the target metric that the model was trained to predict.

#### 4. Evaluation

To evaluate any model for target metric `<metric>` located in `<model_dir>`, run:

```bash
python -m estimator.<metric>.evaluate --model-dir <model_dir>
```
