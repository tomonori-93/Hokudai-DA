#!/usr/bin/bash

ruby_="/home/z44533r/usr/local/CL_intel/bin/ruby"

#ruby make_nc_obs_diff.rb refncname ncname outname expname obstime[s]

for i in 1h_{eye_A08,eye+upper,upper}_identicaltwin
do
   $ruby_ make_nc_obs_diff.rb ../obs_identicaltwin/UV_.vt.grd.nc 1_output/$i/.vt/hist.dmp_20180926-120000.bin.dat_Moveave.nc vt 1_output/$i/.vt/hist.dmp_20180926-120000.bin.dat_Moveave_obsdiff.nc ${i%_identicaltwin} 43200.0
   $ruby_ make_nc_obs_diff.rb ../obs_identicaltwin/UV_.vt.grd.nc 1_output/$i/.vt/hist.dmp_20180927-000000.bin.dat_Moveave.nc vt 1_output/$i/.vt/hist.dmp_20180927-000000.bin.dat_Moveave_obsdiff.nc ${i%_identicaltwin} 86400.0
   $ruby_ make_nc_obs_diff.rb ../obs_identicaltwin/UV_.vt.grd.nc 1_output/$i/.vt/hist.dmp_20180927-120000.bin.dat_Moveave.nc vt 1_output/$i/.vt/hist.dmp_20180927-120000.bin.dat_Moveave_obsdiff.nc ${i%_identicaltwin} 129600.0
   $ruby_ make_nc_obs_diff.rb ../obs_identicaltwin/UV_.vt.grd.nc 1_output/$i/.vt/hist.dmp_20180928-000000.bin.dat_Moveave.nc vt 1_output/$i/.vt/hist.dmp_20180928-000000.bin.dat_Moveave_obsdiff.nc ${i%_identicaltwin} 172800.0
   $ruby_ make_nc_obs_diff.rb ../obs_identicaltwin/UV_.vt.grd.nc 1_output/$i/.vt/hist.dmp_20180928-120000.bin.dat_Moveave.nc vt 1_output/$i/.vt/hist.dmp_20180928-120000.bin.dat_Moveave_obsdiff.nc ${i%_identicaltwin} 216000.0
done

for i in 1h_{eye_A08,eye+upper,upper}_identicaltwin
do
   $ruby_ make_nc_obs_diff.rb ../obs_identicaltwin/UV_.vr.grd.nc 1_output/$i/.vr/hist.dmp_20180926-120000.bin.dat_Moveave.nc vr 1_output/$i/.vr/hist.dmp_20180926-120000.bin.dat_Moveave_obsdiff.nc ${i%_identicaltwin} 43200.0
   $ruby_ make_nc_obs_diff.rb ../obs_identicaltwin/UV_.vr.grd.nc 1_output/$i/.vr/hist.dmp_20180927-000000.bin.dat_Moveave.nc vr 1_output/$i/.vr/hist.dmp_20180927-000000.bin.dat_Moveave_obsdiff.nc ${i%_identicaltwin} 86400.0
   $ruby_ make_nc_obs_diff.rb ../obs_identicaltwin/UV_.vr.grd.nc 1_output/$i/.vr/hist.dmp_20180927-120000.bin.dat_Moveave.nc vr 1_output/$i/.vr/hist.dmp_20180927-120000.bin.dat_Moveave_obsdiff.nc ${i%_identicaltwin} 129600.0
   $ruby_ make_nc_obs_diff.rb ../obs_identicaltwin/UV_.vr.grd.nc 1_output/$i/.vr/hist.dmp_20180928-000000.bin.dat_Moveave.nc vr 1_output/$i/.vr/hist.dmp_20180928-000000.bin.dat_Moveave_obsdiff.nc ${i%_identicaltwin} 172800.0
   $ruby_ make_nc_obs_diff.rb ../obs_identicaltwin/UV_.vr.grd.nc 1_output/$i/.vr/hist.dmp_20180928-120000.bin.dat_Moveave.nc vr 1_output/$i/.vr/hist.dmp_20180928-120000.bin.dat_Moveave_obsdiff.nc ${i%_identicaltwin} 216000.0
done
