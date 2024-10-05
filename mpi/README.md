# MPI

We use rank 0 as our root process.

At first, we share `rows` and `columns` with all processes.
We choose a partition with amount of `rows` divided by the amount of root processes. If this does not divide cleanly, we use a slightly bigger partition size and make the last process has less data to work on. The matrices of the other processes are only as big as they have to be.

After distributing the starting values between the other processes, we start the parallelized `ForwardElimination` function. We parallelized it by broadcasting the row in the matrix everything depends on per row from the current "master" process.

The calculation is basically the same as it was in the serial implementation. The only exception is, that we determine a master-process which then redistributes the data of the current row. We only redistribute values right of the pivot element (after profiling our initial implementation). Since all processes have their respective share to work on, they run out of work as soon as the pivot-row is below the slice. Then, they stop execution and send the data back to the root process.

Afterwards, the processes exit, except the root process. When the root process has gathered all data, it will calculate the `BackwardSubstitution` since we cannot parallelize it due to data dependencies with respect to the previous row-calculation.




