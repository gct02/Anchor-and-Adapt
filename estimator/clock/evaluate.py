import json
from pathlib import Path

from estimator.common.model_utils import prepare_loader
from estimator.clock.models import ClockPeriodModel
from estimator.clock.dataset import ClockPeriodDataset
from estimator.clock.train import evaluate_ensemble, export_eval_results


if __name__ == "__main__":
    import argparse

    parser = argparse.ArgumentParser(description="Evaluate a pre-trained ensemble.")
    parser.add_argument("-d", "--dataset-dir", type=str, default="estimator/clock/dataset",
                        help="The dataset directory.")
    parser.add_argument("-m", "--model_dir", type=str, default=None,
                        help="Path to the directory containing the trained models and associated metadata.")
    parser.add_argument("-b", "--batch-size", type=int, default=32,
                        help="The batch size.")
    args = vars(parser.parse_args())

    dataset_dir = Path(args["dataset_dir"])
    target_model_dir = args["model_dir"]
    batch_size = args["batch_size"]

    if target_model_dir is None:
        model_dirs = Path("estimator/clock/models").iterdir()
    else:
        model_dirs = [target_model_dir]

    for model_dir in model_dirs:
        output_dir = model_dir / "eval_results"
        output_dir.mkdir(exist_ok=True)

        train_args_path = model_dir / "training_args.json"
        with open(train_args_path, 'r') as f:
            train_args = json.load(f)

        model_paths = sorted(
            [
                p for p in model_dir.iterdir()
                if p.name.startswith('model_') and p.name.endswith('.pt')
            ],
            key=lambda p: int(p.stem.replace('model_', ''))
        )

        benchmark = train_args['test_bench']

        loader = prepare_loader(
            ClockPeriodDataset, dataset_dir, [benchmark], batch_size=batch_size
        )

        model = ClockPeriodModel(
            hidden_dim=train_args['hidden_dim'],
            num_layers_micro=train_args['num_layers_micro'],
            num_layers_macro=train_args['num_layers_macro'],
            heads=train_args['heads'],
            dropout=train_args['dropout']
        )

        rpt = evaluate_ensemble(model, loader, model_paths)
        export_eval_results(benchmark, rpt, output_dir)