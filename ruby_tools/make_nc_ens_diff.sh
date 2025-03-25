module load netcdf netcdf-fortran

ulimit -s unlimited

#-- diff
f6h_V01=1h_eye+upper/.vt/hist.dmp_20180926-120000.bin.dat.nc
f12h=12h/.vt/hist.dmp_20180926-120000.bin.dat.nc
fdiff=1h_eye+upper/.vt/hist.dmp_20180926-120000.bin.dat_diff.nc
netcdf_calc_fast 'r' 'z' '' 't' "vt6h_V01==$f6h_V01@vt" "vt12h==$f12h@vt" "$fdiff" "dvt" 'difference of vt between DA6h_V01 and DA12h' 'm s-1' '+missing_value' 'vt6h_V01' 'vt12h' -
exit

module unload netcdf netcdf-fortran
