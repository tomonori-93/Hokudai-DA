module load netcdf netcdf-fortran

ulimit -s unlimited

#-- ensmean
f1=$1
fref=$2
fdiff=$3
mval=$4
long=$5
unit=$6
#f1=1h_eye_R050/.vt/hist.dmp_20180926-120000.bin.dat.nc
#fref=48h/.vt/hist.dmp_20180926-120000.bin.dat_diff.nc
#fdiff=1h_eye_R050/.vt/hist.dmp_20180926-120000.bin.dat_diff.nc
#mval="vt"
#long="difference of vt between DA1h and NoDA"
#unit="m s-1"
netcdf_calc_fast 'r' 'z' '' 't' "vt6h_V01==$f1@$mval" "vt12h==$fref@$mval" "$fdiff" "d$mval" "$long" "$unit" '+missing_value' 'vt6h_V01' 'vt12h' -

module unload netcdf netcdf-fortran
