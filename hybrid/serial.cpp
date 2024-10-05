//
// This is a plain copy of the serial file in openmp.
//

#include <cassert>
#include <iostream>
#include <chrono>
#include "utility.h"
#include "serial.h"
#include <string.h>

#define IDX(r,c) ((r) * (rows) + (c))

namespace Serial{
void ForwardElimination(double *matrix, double *rhs, int rows, int columns){
    int diag_idx, lower_rows, below_diag_idx, element_idx;
    double diag_elem, elimination_factor;
    for(int row = 0; row < rows; row++){
        for (lower_rows=row+1; lower_rows<rows; lower_rows++){
            below_diag_idx = lower_rows*rows + row;
            for (int column=row+1; column<columns; column++){
                // Extract Diagonal element
                diag_idx = row*rows + row;
                diag_elem = matrix[diag_idx];
                assert(diag_elem!=0);
                // Compute the factor
                elimination_factor = matrix[below_diag_idx]/diag_elem;
                element_idx = lower_rows*rows + column;
                // subtract the row
                matrix[element_idx] -= elimination_factor*matrix[row*rows+column];
            }
            rhs[lower_rows] -= elimination_factor*rhs[row];
            // set below diagonal elements to 0
            matrix[below_diag_idx] = 0.;
        }
    }
}
void ForwardEliminationOptimized(double *matrix, double *rhs, uint_fast32_t rows, uint_fast32_t columns){
    // printf("%f\n", matrix[IDX(4,columns - 1)]);

    for(uint_fast32_t row = 0; row < rows; row++){
        /**
         * Extract Diagonal element
         * [x1] x2  x3 <= diag_elem = x1
         *  x4  x5  x6
         *  x7  x8  x9
         */
        double diag_elem = matrix[IDX(row, row)];
        // assert since /0 is not defined
        assert(diag_elem!=0);

        for (uint_fast32_t lower_rows=row+1; lower_rows<rows; lower_rows++){

            /**
             * Compute the factor
             * [x1] x2  x3
             * [x4] x5  x6 <= elimination_factor = x4 / x1
             *  x7  x8  x9
             */
            double elimination_factor = matrix[IDX(lower_rows, row)]/diag_elem;
            for (uint_fast32_t column=row+1; column<columns; column++){

                /**
                 * Subtract the row
                 *  x1 [x2] x3
                 *  x4 [x5] x6 <= x5 = x5 - elimination_factor * x2 = x5 - (x4 / x1) * x2
                 *  x7  x8  x9
                 *
                 *  x1  x2 [x3]
                 *  x4  x5 [x6] <= x6 = x6 - elimination_factor * x3 = x6 - (x4 / x1) * x3
                 *  x7  x8  x9
                 *
                 */
                matrix[IDX(lower_rows, column)] -= elimination_factor*matrix[IDX(row,column)];
            }
            rhs[lower_rows] -= elimination_factor*rhs[row];
            // setting of below to 0 not necessary, since it's never used in the future
            // matrix[IDX(lower_rows,row)] = 0.;
        }
    }
}

void BackwardSubstitution(double *matrix, double *rhs, double*solution, int rows, int columns){
    for(int row=rows-1; row>=0; row--){
        solution[row] = rhs[row];
        int diag_idx = row*rows + row;
        for (int column=row+1; column<columns; column++){
            int element_idx = row*rows + column;
            solution[row] -= matrix[element_idx]*solution[column];
        }
        solution[row] /= matrix[diag_idx];
    }
}
void BackwardSubstitutionOptimized(double *matrix, double*rhs, uint_fast32_t rows, uint_fast32_t columns){
    for(int_fast32_t row=rows-1; row>=0; row--){
        /**
         * Run through all previous solutions, multiply them with the current element one at a time
         * x1 x2 x3 = y1
         *  0 x4 x5 = y2
         *  0  0 x6 = y3
         *
         * y2 -= x5 * y3
         * y1 -= x2 * y2 - x3 * y3
         */
        for (uint_fast32_t column=row+1; column<columns; column++){
            rhs[row] -= matrix[IDX(row,column)]*rhs[column];
        }

        /**
         * Divide by the diagonal element
         * y3 /= x6
         * y2 /= x4
         */
        rhs[row] /= matrix[IDX(row, row)];
    }
}
}
void Serial::Solve(double *matrix, double *rhs, double *solution,
                   int rows, int columns){

    Serial::ForwardEliminationOptimized(matrix, rhs, rows, columns);
    Serial::BackwardSubstitutionOptimized(matrix, rhs, rows, columns);
    // we pulled this out here to optimize writing to solution in the mpi implementation
    for(uint_fast32_t row=0; row<rows; row++){
        solution[row] = rhs[row];
    }
}

void Serial::SerialSolve(int argc, char **argv, float &sequential_runtime, int rank){
    if(rank==0)
    {
        int rows, columns;
        double *matrixSeq, *rhsSeq, *solutionSeq;
        std::string matrix_name, rhs_name, ref_name;
        Utility::ParseFilesNames(argc, argv, matrix_name, rhs_name, &rows, &columns);
        matrixSeq = new double[(rows) * (columns)];
        rhsSeq = new double[(rows)];
        solutionSeq = new double[(columns)];
        Utility::InitializeArray(matrix_name, rhs_name,
                                 matrixSeq, rhsSeq, solutionSeq, rows, columns);

        auto start = std::chrono::steady_clock::now();
        Serial::Solve(matrixSeq, rhsSeq, solutionSeq, rows, columns);
        auto end = std::chrono::steady_clock::now();
        sequential_runtime = std::chrono::duration<float>(end - start).count();
        Utility::PrintSolution(solutionSeq, rows, columns);
        delete[] matrixSeq;
        delete[] rhsSeq;
        delete[] solutionSeq;
    }
}