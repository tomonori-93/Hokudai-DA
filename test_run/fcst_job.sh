#!/bin/sh
# Satoki Tsujino
#PJM --rsc-list "rscunit=fx"
#PJM --rsc-list "rscgrp=fx-small"
#PJM --rsc-list "node=10:noncont"
#PJM --rsc-list "elapse=12:00:00"
#PJM --rsc-list "node-mem=28000"
#PJM --mpi "rank-map-bychip"
#PJM --mpi "proc=80"

cd ${PJM_O_WORKDIR}
echo "cd ${PJM_O_WORKDIR}"

export OMP_NUM_THREADS=6
export PARALLEL=6
export MPI_NUM_PROCS=80
export OMP_STACKSIZE=5120000
module unload netcdf-c netcdf-fortran phdf5 hdf5
module load netcdf-c/4.7.3 netcdf-fortran/4.5.2 phdf5/1.10.6 hdf5/1.10.6
module list
ulimit -s unlimited

#sh ./fcst.sh "20180926000000" "20180926000000" "1" "3" "static" || exit $?
#sh -x ./fcst.sh "20180926000000" "20180926000000" "1" "3" "static" || exit $?
sh ./fcst.sh "20180926000000" "20180926000000" "0000 0001 0002 0003 0004 " "0" "1" "0" "0" "1" "3" "static" || exit $?
