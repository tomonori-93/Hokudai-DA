#!/bin/sh
#PJM -N cycle_testcase_45km_4p_l36
#PJM --rsc-list "rscunit=fx"
#PJM -S
#PJM --rsc-list "node=2:noncont"
#PJM --rsc-list "elapse=04:00:00"
#PJM --rsc-list "rscgrp=micro"
#PJM --mpi "rank-map-bychip"
#PJM --mpi "proc="

export OMP_NUM_THREADS=1
export PARALLEL=1

module load netcdf-c netcdf-fortran phdf5/1.10.6 parallel-netcdf hdf5/1.10.6
which mpiexec

./cycle.sh "20180921120000" "20180922000000" "1" "5" "K_micro" || exit $?
