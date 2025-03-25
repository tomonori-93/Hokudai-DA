module load netcdf netcdf-fortran

ulimit -s unlimited

#-- ensmean
idir=6h_V01/.vt/hist.dmp_20180926-000000.bin.dat.nc
move_ave_nc $idir 3 'r' 'z' 't' 't' 30 1 -999.0 'vt'

idir=6h_V01/.vt/hist.dmp_20180926-120000.bin.dat.nc
move_ave_nc $idir 3 'r' 'z' 't' 't' 30 1 -999.0 'vt'

idir=12h/.vt/hist.dmp_20180926-120000.bin.dat.nc
move_ave_nc $idir 3 'r' 'z' 't' 't' 30 1 -999.0 'vt'

#-- diff
f6h_V01=6h_V01/.vt/hist.dmp_20180926-120000.bin.dat_Moveave.nc
f12h=12h/.vt/hist.dmp_20180926-120000.bin.dat_Moveave.nc
fdiff=6h_V01/.vt/hist.dmp_20180926-120000.bin.dat_Moveave_diff.nc
netcdf_calc_fast 'r' 'z' '' 't' "vt6h_V01==$f6h_V01@vt" "vt12h==$f12h@vt" "$fdiff" "dvt" 'difference of vt between DA6h_V01 and DA12h' 'm s-1' '+missing_value' 'vt6h_V01' 'vt12h' -
exit

module unload netcdf netcdf-fortran
