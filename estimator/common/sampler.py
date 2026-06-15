import numpy as np
import itertools

from torch.utils.data import Sampler


class BalancedBenchmarkSampler(Sampler):
    def __init__(self, benchmark_indices):
        """
        Args:
            benchmark_indices (list or np.array): A 1D array where each element 
                is the benchmark ID/name for the corresponding dataset instance.
        """
        self.benchmark_indices = np.array(benchmark_indices)
        self.unique_benchmarks = np.unique(self.benchmark_indices)
        self.num_benchmarks = len(self.unique_benchmarks)
        
        self.indices_per_bench = {
            bench: np.where(self.benchmark_indices == bench)[0].tolist()
            for bench in self.unique_benchmarks
        }
        
        # Find the largest benchmark to define the epoch length
        self.max_size = max(len(idx) for idx in self.indices_per_bench.values())

        # Total samples yielded per epoch ensures the largest benchmark is fully seen
        self.total_samples = self.max_size * self.num_benchmarks

    def __iter__(self):
        iterators = {}
        for bench, indices in self.indices_per_bench.items():
            np.random.shuffle(indices)
            iterators[bench] = itertools.cycle(indices)
            
        round_robin_benchmarks = itertools.cycle(self.unique_benchmarks)
        
        for _ in range(self.total_samples):
            current_bench = next(round_robin_benchmarks)
            yield next(iterators[current_bench])

    def __len__(self):
        return self.total_samples