//
// Created by shubham on 26.05.21.
//

#include <cassert>
#include <chrono>
#include <omp.h>
#include "ompge.h"

// #define CHUNKSIZE 4

#define IDX(r,c) ((r) * (rows) + (c))

namespace OMP{
void ForwardElimination(double *matrix, double *rhs, const uint_fast32_t rows, const uint_fast32_t columns){

    for(uint_fast32_t row = 0; row < rows; row++){
        // Extract Diagonal element
        double diag_elem = matrix[IDX(row, row)];
        assert(diag_elem!=0);

#pragma omp parallel default(none) firstprivate(rows, columns, row, diag_elem) shared(matrix, rhs)
#pragma omp for
        for (uint_fast32_t lower_rows=row+1; lower_rows<rows; lower_rows++){
            // Compute the factor
            double elimination_factor = matrix[IDX(lower_rows,row)]/diag_elem;
            for (uint_fast32_t column=row+1; column<columns; column++){
                // subtract the row
                matrix[IDX(lower_rows,column)] -= elimination_factor * matrix[IDX(row,column)];
            }
            rhs[lower_rows] -= elimination_factor*rhs[row];
        }
    }
}

// #define PAR_BACKWARD

/**
 * This function is unchanged compared to the serial implementation.
 */
void BackwardSubstitution(double *matrix, double *rhs, double*solution, const uint_fast32_t rows, uint_fast32_t columns){
    for(int_fast32_t row=rows-1; row>=0; row--){
        solution[row] = rhs[row];

#ifdef PAR_BACKWARD
        // This did not bring performance improvments in our rudimentary tests, therefore we did not do it
        double val = 0;
#pragma omp parallel default(none) shared(solution, matrix, val) firstprivate(row, columns, rows)
#pragma omp for reduction(+:val)
        for (uint_fast32_t column=row+1; column<columns; column++){
            val += matrix[IDX(row, column)]*solution[column];
        }
        solution[row] -= val;
#else
        for (uint_fast32_t column=row+1; column<columns; column++){
            solution[row] -= matrix[IDX(row, column)]*solution[column];
        }
#endif

        solution[row] /= matrix[IDX(row,row)];
    }
}
}
void OMP::Solve(double *matrix, double *rhs, double *solution,
                   int rows, int columns){
    OMP::ForwardElimination(matrix, rhs, rows, columns);
    OMP::BackwardSubstitution(matrix, rhs, solution, rows, columns);
}
