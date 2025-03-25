#!/bin/sh
# Satoki Tsujino
#PJM --rsc-list "rscunit=fx"
#PJM --rsc-list "rscgrp=fx-middle"
#PJM --rsc-list "node=62:noncont"
#PJM --rsc-list "elapse=00:30:00"
#PJM --mpi "rank-map-bychip"
#PJM --mpi "proc=496"

cd ${PJM_O_WORKDIR}
echo "cd ${PJM_O_WORKDIR}"

export OMP_NUM_THREADS=6
export PARALLEL=6
export MPI_NUM_PROCS=496
export OMP_STACKSIZE=5120000
module unload netcdf-c netcdf-fortran phdf5 hdf5
module load netcdf-c/4.7.3 netcdf-fortran/4.5.2 phdf5/1.10.6 hdf5/1.10.6
module list

mpiexec -n ${MPI_NUM_PROCS} -of-proc log/letkf.NOUT_test ./letkf ./letkf_20180926010000.conf
echo "mpiexec -n ${MPI_NUM_PROCS} -of-proc log/letkf.NOUT_test ./letkf"
#sh ./cycle.sh "20180926000000" "20180926060000" "1" "5" "static" || exit $?
#sh -x ./cycle.sh "20180926000000" "20180926060000" "1" "5" "static" || exit $?
