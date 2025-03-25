module load netcdf netcdf-fortran

ulimit -s unlimited

#-- ensmean
#idir=1_output/1h_eye_A08_identicaltwin/.vr/hist.dmp_20180926-000000.bin.dat.nc
#move_ave_nc $idir 3 'r' 'z' 't' 't' 30 1 -999.0 'vr'

#idir=1_output/1h_eye_A08_identicaltwin/.vr/hist.dmp_20180926-120000.bin.dat.nc
#move_ave_nc $idir 3 'r' 'z' 't' 't' 30 1 -999.0 'vr'

#idir=1_output/48h/.vr/hist.dmp_20180926-120000.bin.dat.nc
#move_ave_nc $idir 3 'r' 'z' 't' 't' 30 1 -999.0 'vr'

#-- diff
idir=1_output/1h_eye+upper
#idir=1_output/1h_eye_A08_identicaltwin
refdir=1_output/48h

for var in vr vt w
do
   for tim in 26-12 27-00 27-12
   do
      f6h_V01=${idir}/.${var}/hist.dmp_201809${tim}0000.bin.dat_Moveave.nc
      f48h=${refdir}/.${var}/hist.dmp_201809${tim}0000.bin.dat_Moveave.nc
      fdiff=${idir}/.${var}/hist.dmp_201809${tim}0000.bin.dat_Moveave_diff.nc
      netcdf_calc_fast 'r' 'z' '' 't' "vr6h_V01==$f6h_V01@${var}" "vr48h==$f48h@${var}" "$fdiff" "d${var}" "'difference of ${var} between DA6h_V01 and DA48h'" 'm s-1' '+missing_value' 'vr6h_V01' 'vr48h' -
   done
done
exit

module unload netcdf netcdf-fortran
