expname=$1
wkdir="1_output/"
nml=draw_time_series_tot.nml
#true_tcenter=0_data/bst_T1824_tot.dat
true_tcenter=0_data/bst_T1824_identicaltwin_tot.dat

dcl_nml_change.rb ${nml} pfname "'${true_tcenter}', '${wkdir}/${expname}/hist.geo_20180926-000000.bin.dat.tcenter', '${wkdir}/${expname}/hist.geo_20180926-120000.bin.dat.tcenter', '${wkdir}/${expname}/hist.geo_20180927-000000.bin.dat.tcenter', '${wkdir}/${expname}/hist.geo_20180927-120000.bin.dat.tcenter'"
dcl_nml_change.rb ${nml} title "'${expname}'"
draw_time_series < ${nml}
mv -i dcl.pdf track_${expname}.pdf
