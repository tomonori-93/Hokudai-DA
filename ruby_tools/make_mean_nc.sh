module load netcdf netcdf-fortran

ulimit -s unlimited

#-- ensmean
idir=$1
mval=$2
#idir=6h_V01/.vt/hist.dmp_20180926-000000.bin.dat.nc
move_ave_nc $idir 3 'r' 'z' 't' 't' 30 1 -999.0 "$mval"

module unload netcdf netcdf-fortran
