#!/bin/bash
#===============================================================================
#
#  Wrap fcst.sh in a torque job script and run it.
#
#-------------------------------------------------------------------------------
#
#  Usage:
#    fcst_FX1000.sh [..]
#  Author: Satoki Tsujino (Modified from cycle_torque.sh)
#
#===============================================================================

#set -x
cd "$(dirname "$0")"
myname="$(basename "$0")"
job='fcst'

#===============================================================================
# Configuration

. ./config.main || exit $?
. ./config.${job} || exit $?

. src/func_datetime.sh || exit $?
. src/func_util.sh || exit $?
. src/func_${job}.sh || exit $?

#-------------------------------------------------------------------------------

echo "[$(datetime_now)] Start $myname $@"
echo

setting "$@" || exit $?

if [ "$CONF_MODE" = 'static' ]; then
  . src/func_common_static.sh || exit $?
  . src/func_${job}_static.sh || exit $?
fi

echo
print_setting || exit $?
echo

#===============================================================================
# Creat a job script

jobscrp="${job}_job.sh"

echo "[$(datetime_now)] Create a job script '$jobscrp'"

if ((NNODES > 768)); then
  rscgrp="fx-special"
elif ((NNODES > 192)); then
  rscgrp="fx-xlarge"
elif ((NNODES > 96)); then
  rscgrp="fx-large"
elif ((NNODES > 24)); then
  rscgrp="fx-middle"
else
  rscgrp="fx-small"
fi

cat > $jobscrp << EOF
#!/bin/sh
# Satoki Tsujino
#PJM --rsc-list "rscunit=fx"
#PJM --rsc-list "rscgrp=${rscgrp}"
#PJM --rsc-list "node=${NNODES}:noncont"
#PJM --rsc-list "elapse=${TIME_LIMIT}"
#PJM --rsc-list "node-mem=28000"
#PJM --mpi "rank-map-bychip"
#PJM --mpi "proc=$((NNODES*PPN))"

cd \${PJM_O_WORKDIR}
echo "cd \${PJM_O_WORKDIR}"

export OMP_NUM_THREADS=${THREADS}
export PARALLEL=${THREADS}
export MPI_NUM_PROCS=$((NNODES*PPN))
export OMP_STACKSIZE=5120000
module unload netcdf-c netcdf-fortran phdf5 hdf5
module load netcdf-c/4.7.3 netcdf-fortran/4.5.2 phdf5/1.10.6 hdf5/1.10.6
module list
ulimit -s unlimited

#sh ./${job}.sh "$STIME" "$ETIME" "$ISTEP" "$FSTEP" "$CONF_MODE" || exit \$?
#sh -x ./${job}.sh "$STIME" "$ETIME" "$ISTEP" "$FSTEP" "$CONF_MODE" || exit \$?
sh ./${job}.sh "$STIME" "$ETIME" "$MEMBERS" "$CYCLE" "$CYCLE_SKIP" "$IF_VERF" "$IF_EFSO" "$ISTEP" "$FSTEP" "$CONF_MODE" || exit \$?
EOF

echo "[$(datetime_now)] Run ${job} job on PJM"
echo

job_submit_PJM $jobscrp
echo

job_end_check_PJM $jobid
res=$?

#exit  # satoki

#===============================================================================
# Finalization

echo "[$(datetime_now)] Finalization"
echo

backup_exp_setting $job $SCRP_DIR $jobid $jobscrp 'o e'

archive_log

#if ((CLEAR_TMP == 1)); then
#  safe_rm_tmpdir $TMP
#fi

#===============================================================================

echo "[$(datetime_now)] Finish $myname $@"

exit $res
