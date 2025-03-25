#!/bin/sh
# this script can be only used FX10.
# made by Satoki Tsujino.
#PJM --rsc-list "rscunit=fx"
#PJM --rsc-list "rscgrp=fx-small"
#PJM --rsc-list "node=2:noncont,elapse=01:00:00"
#PJM --mpi "rank-map-bychip"
#PJM --mpi "proc=4"
#PJM --name "solve2km01.sh"
#PJM -j
#PJM -S

############ configure ###############
#NODES=${PJM_VNODES}
NODES=2
CORES=16
PROCS=4
cnf=pp.d01.conf
log=log.pp.txt
slv=scale-rm_pp
############ configure ###############

cd ${PJM_O_WORKDIR}
echo "cd ${PJM_O_WORKDIR}"

export OMP_NUM_THREADS=$CORES
export PARALLEL=$CORES
export MPI_NUM_PROCS=$PROCS
#export FORT90=-Wl,-Lu
export OMP_STACKSIZE=512000
ulimit -s unlimited

module load netcdf-c netcdf-fortran phdf5/1.10.6 parallel-netcdf hdf5/1.10.6

mpiexec -n ${MPI_NUM_PROCS} ./$slv ./"$cnf" > ./"$log"
#mpiexec -n ${MPI_NUM_PROCS} -stdin ./"$cnf" -of-proc ./"$log" ./$slv -Wl,-Lu -Wl,-T
echo "mpiexec -n ${MPI_NUM_PROCS} -stdin ./"$cnf" -of-proc ./"$log" ./$slv -Wl,-Lu -Wl,-T"
