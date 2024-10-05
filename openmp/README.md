# OpenMP

This code includes optimizations done in serial. For these optimizations, please check the README.md in documentation.

We parallelized the `ForwardElimination` by using `omp for` on the second loop since it has only dependencies to the outermost loop. We can not parallelize the outermost loop since every step of the outermost loop is dependent on the previous steps.

In `BackwardSubstitution` we can not parallelize it, since every step is dependent on it's previous steps.
