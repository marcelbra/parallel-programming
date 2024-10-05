# Hybrid

In our tests on the submission server, we saw a speedup of 3.5. This is caused since the server only used one thread per process. By manually setting `omp_set_num_threads(8)`, we achieved a speedup of 11.2. For the submission we commented the line out.

The approach in parallelization we did with MPI did not scale to the hybrid approach, since the processes of lower rank would be idle most of the time. Therefore, we implemented a new approach:

Instead of sending the data like: (explained by the example of a 7x7 matrix with 2 processes)

```.
+---------------+
|     Rank 0    |
+---------------+  | p
|     Rank 0    |  | r
+---------------+  | o
|     Rank 0    |  | c
+---------------+  | e
|     Rank 0    |  | s
+---------------+  | s
|     Rank 1    |  | i
+---------------+  | n
|     Rank 1    |  | g
+---------------+  v
|     Rank 1    |
+---------------+

=>

Rank 0 data
+---------------+
| row 0         |
+---------------+
| row 1         |
+---------------+
| row 2         |
+---------------+
| row 3         |
+---------------+

Rank 1 data
+---------------+
| row 4         |
+---------------+
| row 5         |
+---------------+
| row 6         |
+---------------+

```

we distribute the data like this:

```.
+---------------+
|     Rank 0    |
+---------------+  | p
|     Rank 1    |  | r
+---------------+  | o
|     Rank 0    |  | c
+---------------+  | e
|     Rank 1    |  | s
+---------------+  | s
|     Rank 0    |  | i
+---------------+  | n
|     Rank 1    |  | g
+---------------+  v
|     Rank 0    |
+---------------+

=>

Rank 0 data
+---------------+
| row 0         |
+---------------+
| row 2         |
+---------------+
| row 4         |
+---------------+
| row 6         |
+---------------+

Rank 1 data
+---------------+
| row 1         |
+---------------+
| row 3         |
+---------------+
| row 5         |
+---------------+

```

This brought a speedup of an additional 0.5 compared to the MPI implementation.

Since the algorithm works the rows from 0 to 6 (in the example), and already finished rows are not longer touched, the other processes are not idling anymore after a certain row is passed, but instead have data to work on until the end of processing.

Like before, the distribution is done from rank 0 (root) to all other processes. In `ForwardElimination`, the `master_rank` is determined which then broadcasts the current `matrix_row` and `rhs_row` to the other processes. On the root, the received data is written into the final arrays which will be used later for Backward Substitution.

Like before, parallelizing `BackwardSubstitution` is not parallelizable. (the only possible parallelization possible leads to a big overhead).

Additionally to optimizing the MPI data distribution, we added OpenMP to the approach by parallelizing the same for loop as in the omp-project in exactly the same way.
