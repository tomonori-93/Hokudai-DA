#!/usr/bin/bash

geofile="T1824.2km.NCEP.03.geography.CReSStoSCALE"

for i in calc_tangen_mean_nc_anal1.nml calc_tangen_mean_nc_anal2.nml
do
   for j in 1_output/{1h_eye_A08,1h_upper,1h_eye+upper}
   do
      dcl_nml_change.rb $i grdname "'"$j"/"$geofile"'"
      for k in anal gues
      do
         dcl_nml_change.rb $i hname "'"$j"/mean_ruby/mean_"$k"_20180926-120000.000.bin'"
         dcl_nml_change.rb $i ininame 432000
         ./calc_tangen_mean_nc < $i &
         sleep 5

         dcl_nml_change.rb $i hname "'"$j"/mean_ruby/mean_"$k"_20180927-000000.000.bin'"
         dcl_nml_change.rb $i ininame 475200
         ./calc_tangen_mean_nc < $i &
         sleep 5

         dcl_nml_change.rb $i hname "'"$j"/mean_ruby/mean_"$k"_20180927-120000.000.bin'"
         dcl_nml_change.rb $i ininame 518400
         ./calc_tangen_mean_nc < $i &
         sleep 5

      done
   done
done
