//
// Created by shubham on 28.05.21.
//
#include "hybrid_interface.h"
#include <mpi.h>
#include <omp.h>
#include "hybridge.h"
#include "utility.h"
#include <iostream>
#include "serial.h"
#include <chrono>

#define TEST

void Parallel::HybridSolve(int argc, char** argv, float& parallel_runtime, int& print_rank){
        int rows, columns;
#ifdef TEST
   double *matrixSeq, *rhsSeq, *solutionSeq, *reference;
#endif
    double *matrixPar, *rhsPar, *solutionPar;
    std::string matrix_name, rhs_name, ref_name;
    int rank, size;

    MPI_Init(&argc, &argv);
    MPI_Comm_rank(MPI_COMM_WORLD, &rank);
    MPI_Comm_size(MPI_COMM_WORLD, &size);
    if (rank==0){

        Utility::ParseFilesNames(argc, argv, matrix_name, rhs_name, &rows, &columns);
#ifdef TEST
       matrixSeq = new double[(rows)*(columns)];
       rhsSeq = new double[(rows)];
       solutionSeq = new double[(columns)];
#endif

        matrixPar = new double[(rows)*(columns)];
        rhsPar = new double[(rows)];
        solutionPar = new double[(columns)];

        Utility::InitializeArray(matrix_name, rhs_name,
                                 matrixPar, rhsPar, solutionPar, rows, columns);

#ifdef TEST
       std::copy(matrixPar, matrixPar + rows*columns, matrixSeq);
       std::copy(rhsPar, rhsPar + rows, rhsSeq);
       std::copy(solutionPar, solutionPar + columns, solutionSeq);

       Serial::Solve(matrixSeq, rhsSeq, solutionSeq, rows, columns);
#endif
    }

    if (rank==0) {
        print_rank = rank;
    }
    else{
        print_rank = 1;
    }
    auto start = std::chrono::steady_clock::now();
    Hybrid::Solve(matrixPar, rhsPar, solutionPar, rows, columns);
    if (rank==0) {
        auto end = std::chrono::steady_clock::now();
        parallel_runtime = std::chrono::duration<float>(end - start).count();
    }
    if (rank==0) {
#ifdef TEST
       delete[] matrixSeq;
       delete[] rhsSeq;
#endif
        delete[] matrixPar;
        delete[] rhsPar;
        Utility::PrintSolution(solutionPar, rows, columns);

#ifdef TEST
       Utility::CompareBuffer<double>(solutionSeq, solutionPar, columns, 1e-6);
       delete[] solutionSeq;
#endif
        delete[] solutionPar;
    }
    MPI_Finalize();

}
