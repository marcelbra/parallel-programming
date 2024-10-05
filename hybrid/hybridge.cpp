//
// Created by shubham on 26.05.21.
//
#include <chrono>
#include <cassert>
#include <mpi.h>
#include <omp.h>
#include "hybridge.h"
#define CHUNKSIZE 4
#include <algorithm>
#include <cstring>

#include <stdio.h>

#define IDX(r,c) ((r) * (rows) + (c))

namespace Hybrid{
/**
 * Every process calculates it's share of the data
 */
void ForwardElimination(uint_fast32_t rank, uint_fast32_t size, double *matrix, double *final_matrix, double *rhs, double *solution, uint_fast32_t rows, uint_fast32_t columns, uint_fast32_t amount){

    double rhs_row = 0.;
    double *matrix_row = new double[columns];
    uint_fast32_t local_row = 0;

    for (uint_fast32_t row = 0; row < rows; row++) {
        // determine master process
        uint_fast32_t master_rank = row % size;

        if (rank == master_rank) {
            // current master sends it's row_matrix to all others which still need to do calculations
            mempcpy(matrix_row + row, matrix + local_row * columns + row, (columns-row) * sizeof(double));
            rhs_row = rhs[local_row];
            // lower_rows = local_row + 1, therefore, we can increase here already
            local_row++;
        }
        MPI_Bcast(matrix_row + row, columns - row, MPI_DOUBLE, master_rank, MPI_COMM_WORLD);
        MPI_Bcast(&rhs_row, 1, MPI_DOUBLE, master_rank, MPI_COMM_WORLD);
        if (rank == 0) {
            // root writes into final_matrix
            memcpy(final_matrix + row * columns + row, matrix_row + row, (columns-row) * sizeof(double));
            // copy rhs to master solution
            solution[row] = rhs_row;
        }

        // since we have our matrix_row, we can just get the pivot element on position "row"
        double diag_elem = matrix_row[row];
        // assert since /0 is not defined
        assert(diag_elem != 0);

        #pragma omp parallel for default(none) firstprivate(rhs_row,diag_elem,row,amount,columns,rows,local_row) shared(rhs,matrix,matrix_row)
        for (uint_fast32_t lower_rows = local_row; lower_rows < amount; lower_rows++){
            double elimination_factor = matrix[IDX(lower_rows,row)] / diag_elem;
            // actual calculation
            for (uint_fast32_t column = row + 1; column<columns; column++){
                matrix[IDX(lower_rows,column)] -= elimination_factor * matrix_row[column];
            }
            rhs[lower_rows] -= elimination_factor*rhs_row;
        }
    }

    delete[] matrix_row;
}

/**
 * Only calculated by rank 0. Not parallelizable. Copy paste of serial code.
 */
void BackwardSubstitution(double *matrix, double*solution, uint_fast32_t rows, uint_fast32_t columns) {
    for(int_fast32_t row = rows - 1; row >= 0; row--){
        for (uint_fast32_t column = row + 1; column<columns; column++){
            solution[row] -= matrix[IDX(row, column)] * solution[column];
        }
        solution[row] /= matrix[IDX(row, row)];
    }
}
}

void Hybrid::Solve(double *matrix, double *rhs, double *solution,
                int rows, int columns){
    int rank, size;
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);

    // share rows and columns with the other ranks
    MPI_Bcast(&rows, 1, MPI_INTEGER, 0, MPI_COMM_WORLD);
    MPI_Bcast(&columns, 1, MPI_INTEGER, 0, MPI_COMM_WORLD);

    uint_fast32_t partition = rows / size;
    // if we cannot divide the rows by the amount of MPI processes, we increase the partition size
    if (rows % size != 0) {
        partition += 1;
    }
    // every process calculates its own start, end and amount
    uint_fast32_t start = rank * partition;
    uint_fast32_t end = std::min(start + partition, (uint_fast32_t)rows);
    uint_fast32_t amount = end > start ? end - start : 0;

    // not set on the server??
    // omp_set_num_threads(8);

    MPI_Status s;

    double *final_matrix;
    double *tmp_rhs;
    if (rank == 0) {
        final_matrix = matrix;
        tmp_rhs = rhs;
    }

    // structures for all processes should only be as big as they need to be
    matrix = new double[amount * columns];
    rhs = new double[amount];

    // send data from master to slaves
    if (rank == 0) {
        // copy to own process
        for (uint_fast32_t j = 0, pos = 0; j < (uint_fast32_t)rows; j += size, pos++) {
            memcpy(matrix + pos * columns, final_matrix + j * columns, sizeof(double) * columns);
            rhs[pos] = tmp_rhs[j];
        }
        // send the rest to all others (one row at a time)
        for (uint_fast32_t i = 1; i < (uint_fast32_t)size; i++) {
            for (uint_fast32_t j = i; j < (uint_fast32_t)rows; j += size) {
                MPI_Send(final_matrix + j * columns, columns, MPI_DOUBLE, i, 1, MPI_COMM_WORLD);
                MPI_Send(tmp_rhs + j, 1, MPI_DOUBLE, i, 5, MPI_COMM_WORLD);
            }
        }
    } else {
        // recv the data, one line at a time
        for (uint_fast32_t j = rank, pos = 0; j < (uint_fast32_t)rows; j += size, pos++) {
            MPI_Recv(matrix + pos * columns, columns, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD, &s);
            MPI_Recv(rhs + pos, 1, MPI_DOUBLE, 0, 5, MPI_COMM_WORLD, &s);
        }
    }

    // actual parallelized calculation
    Hybrid::ForwardElimination(rank, size, matrix, final_matrix, rhs, solution, rows, columns, amount);

    // get data from slaves back to root
    if (rank == 0) {
        // calculate backward substitution without parallelization
        Hybrid::BackwardSubstitution(final_matrix, solution, rows, columns);
    }
    // cleanup matrix
    delete[] matrix;
    // cleanup rhs
    delete[] rhs;
}
