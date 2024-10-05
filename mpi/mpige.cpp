//
// Created by shubham on 26.05.21.
//

#include <chrono>
#include <cassert>
#include <cstdio>
#include <mpi.h>
#include "mpige.h"

#include <algorithm>
#include <cstring>

#define IDX(r,c) ((r) * (rows) + (c))

/**
 * Meta structure to safe start, end, and amount for all others in root
 */
struct meta {
    uint_fast32_t start;
    uint_fast32_t end;
    uint_fast32_t amount;
};

namespace MPI{
    /**
     * Every process calculates it's share of the data
     */
    void ForwardElimination(uint_fast32_t rank, uint_fast32_t size, double *matrix, double *rhs, uint_fast32_t rows, uint_fast32_t columns, uint_fast32_t partition, meta meta_own){

        MPI_Status s;
        double rhs_row = 0.;
        double *matrix_row = new double[columns];

        // skip the last element, since there is no need to calculate that
        for(uint_fast32_t row = 0; row < rows - 1; row++){

            // determine master process
            uint_fast32_t master_rank = row / partition;

            if (rank == master_rank) {
                // current master sends it's row_matrix to all others which still need to do calculations
                mempcpy(matrix_row + row, matrix + (row - meta_own.start) * columns + row, (columns-row) * sizeof(double));
                rhs_row = rhs[row-meta_own.start];
                for (uint_fast16_t i = master_rank + 1; i < size; i++) {
                    MPI_Send(matrix_row + row, columns-row, MPI_DOUBLE, i, 7, MPI_COMM_WORLD);
                    MPI_Send(&rhs_row, 1, MPI_DOUBLE, i, 8, MPI_COMM_WORLD);
                }
            } else if (rank < master_rank) {
                // no longer need to do calculations, return and send the data back to root
                break;
            } else {
                // slave processes, get data from master
                MPI_Recv(matrix_row + row, columns-row, MPI_DOUBLE, master_rank, 7, MPI_COMM_WORLD, &s);
                MPI_Recv(&rhs_row, 1, MPI_DOUBLE, master_rank, 8, MPI_COMM_WORLD, &s);
            }

            // since we have our matrix_row, we can just get the pivot element on position "row"
            double diag_elem = matrix_row[row];
            // assert since /0 is not defined
            assert(diag_elem != 0);

            for (uint_fast32_t lower_rows=0; lower_rows < meta_own.amount; lower_rows++){
                // only run calculations when we are not yet finished on the current row
                if (meta_own.start + lower_rows <= row) {
                    continue;
                }

                double elimination_factor = matrix[IDX(lower_rows,row)]/diag_elem;
                // actual calculation
                for (uint_fast32_t column=row+1; column<columns; column++){
                    matrix[IDX(lower_rows,column)] -= elimination_factor*matrix_row[column];
                }
                rhs[lower_rows] -= elimination_factor*rhs_row;
            }
        }

        delete matrix_row;
    }


    /**
     * Only calculated by rank 0. Not parallelizable. Copy paste of serial code.
     */
    void BackwardSubstitution(double *matrix, double*solution, uint_fast32_t rows, uint_fast32_t columns) {
        for(int_fast32_t row=rows-1; row>=0; row--){
            for (uint_fast32_t column=row+1; column<columns; column++){
                solution[row] -= matrix[IDX(row, column)]*solution[column];
            }
            solution[row] /= matrix[IDX(row, row)];
        }
    }
}


void MPI::Solve(double *matrix, double *rhs, double *solution,
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
    uint_fast32_t amount = end >= start ? end - start : 0;
    meta meta_own = {start, end, amount};

    // only used by root, we ignore the warning here
    meta *meta_slaves;
    if (rank == 0) {
        meta_slaves = reinterpret_cast<meta*>(malloc(size * sizeof(meta)));
    }

    MPI_Status s;

    // send data from master to slaves
    if (rank == 0) {
        // send the rest to all others
        for (uint_fast32_t i = 1; i < size; i++) {
            // the root process has to know the meta-values of the slaves
            uint_fast32_t start_i = i * partition;
            uint_fast32_t end_i = std::min(start_i + partition, (uint_fast32_t)rows);
            uint_fast32_t amount_i = end_i >= start_i ? end_i - start_i : 0;
            meta_slaves[i] = {start_i, end_i, amount_i};
            MPI_Send(matrix + start_i * columns, amount_i * columns, MPI_DOUBLE, i, 1, MPI_COMM_WORLD);
            MPI_Send(rhs + start_i, amount_i, MPI_DOUBLE, i, 5, MPI_COMM_WORLD);
        }
    } else {
        // matrix for all non root processes is only as big as it needs to be
        matrix = new double[amount * columns];
        MPI_Recv(matrix, amount * columns, MPI_DOUBLE, 0, 1, MPI_COMM_WORLD, &s);
        // rhs also only as big as needed
        rhs = new double[amount];
        MPI_Recv(rhs, amount, MPI_DOUBLE, 0, 5, MPI_COMM_WORLD, &s);
    }

    // actual parallelized calculation
    MPI::ForwardElimination(rank, size, matrix, rhs, rows, columns, partition, meta_own);

    // get data from slaves back to root
    if (rank == 0) {
        // copy rhs to solution before 2nd step
        memcpy(solution, rhs, amount * sizeof(double));

        for (uint_fast32_t i = 1; i < size; i++) {
            // recv only from pivot to right
            for (uint_fast32_t row = 0; row < meta_slaves[i].amount; row++) {
                MPI_Recv(matrix + (meta_slaves[i].start + row) * columns + row, columns - row, MPI_DOUBLE, i, 2, MPI_COMM_WORLD, &s);
            }
            // copy rhs from slaves to master solution
            MPI_Recv(solution + meta_slaves[i].start, meta_slaves[i].amount, MPI_DOUBLE, i, 4, MPI_COMM_WORLD, &s);
        }
        // free memory since the slaves are no longer needed
        free(meta_slaves);
        // calculate backward substitution without parallelization
        MPI::BackwardSubstitution(matrix, solution, rows, columns);
    } else {
        for (uint32_t row = 0; row < amount; row++) {
            // send only the necessary data (pivot and right of it)
            MPI_Send(matrix + row * columns + row, columns - row, MPI_DOUBLE, 0, 2, MPI_COMM_WORLD);
        }
        // cleanup matrix
        delete matrix;
        // copy rhs from slaves to master solution
        MPI_Send(rhs, amount, MPI_DOUBLE, 0, 4, MPI_COMM_WORLD);
        // cleanup rhs
        delete rhs;
    }
}
