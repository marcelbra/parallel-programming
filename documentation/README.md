# Group-218

This is your teams documentation repository.
You can find informational material here.
This is also the place where you should keep your project documentation (such as the slides for the presentation).

You should have access to separate repositories to store code for each of the tasks on your project descriptions (OpenMP, MPI, Hybrid, Bonus).

## Team Members

Member 1: Syed Salman Ahmed <salman.ahmed@tum.de>

Member 2: Sandro Bauer <sandro.bauer@tum.de>

Member 3: Marcel Braasch <marcel.braasch@tum.de>

## Serial Optimizations: Changed order of execution

### Original Algorithm Forward Elimination

```py
for row = 0 < rows
  for lower_row = row+1 < rows
    for column = row+1 < columns
      diag_elem # dependent only on row
      elimination_factor # dependent only lower_row
      update_element # dependent on column
    update_solution # dependent on lower_row
    set_0_values # dependent on lower_row
```

### Optimized Algorithm Forward Elimination

```py
for row = 0 < rows
  diag_elem # sufficient if we calculate this here only once
  for lower_row = row+1 < rows
    elimination_factor # sufficient if we calculate this here only once
    for column = row+1 < columns
      update_element # unchanged
    update_solution # unchanged
    # set_0_values # removed, since it's not necessary because we do not check the other values afterwards
```

### Speedup

This achieved a 4.7x speedup on the submission server already.

## Serial Optimization: Use (u)int_fast32_t instead of int

Since we had good results with fast-types in the homework assignments, we also used them here. This way, we were able to improve the 4.7x speedup to a 5x speedup.

## Parallelization

Please see the other repositories for individual explanations.
