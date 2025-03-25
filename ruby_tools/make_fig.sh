
gpview --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs/T1824.2km.NCEP.03.dmp.vt.united.bin.nc@vt,t=432000.0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png obs_vt_2018092612.png
gpview --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 6h/.vt/hist.dmp_20180926-120000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DA_VT_DT6h_2018092612.png
gpview --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 12h/.vt/hist.dmp_20180926-120000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DA_VT_DT12h_2018092612.png
gpview --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 6h/.vt/hist.dmp_20180926-000000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DA_VT_DT6h_2018092600.png
gpview --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 6h/.vt/hist.dmp_20180926-120000.bin.dat_Moveave_diff.nc@dvt,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DVT_DT6h-12h_2018092600.png
exit

gpview --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 12h/.vr/hist.dmp_20180926-120000.bin.dat_Moveave.nc@vr,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DA_VR_DT12h_2018092612.png
gpview --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1h/.vr/hist.dmp_20180926-120000.bin.dat_Moveave.nc@vr,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DA_VR_DT1h_2018092612.png
gpview --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1h/.vr/hist.dmp_20180926-120000.bin.dat_Moveave_diff.nc@dvr,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DVR_VR_DT1h-12h_2018092600.png

rm dcl_0001.png
