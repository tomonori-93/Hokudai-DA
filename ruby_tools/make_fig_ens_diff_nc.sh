
gpview --anim t --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye+upper/.vt/hist.dmp_20180926-120000.bin.dat_diff.nc@dvt,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_diff_vt_1h_eye+upper_2018092612.pdf
gpview --anim t --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye+upper/.vt/hist.dmp_20180927-000000.bin.dat_diff.nc@dvt,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_diff_vt_1h_eye+upper_2018092700.pdf
gpview --anim t --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye+upper/.vt/hist.dmp_20180927-120000.bin.dat_diff.nc@dvt,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_diff_vt_1h_eye+upper_2018092712.pdf
#convert -trim dcl_0001.png DA_VT_DT6h_2018092612.png
#gpview --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 6h/.vt/hist.dmp_20180926-120000.bin.dat_diff_diff.nc@dvt,t=^0,r=0.0:100000.0,z=0.0:20000.0
#convert -trim dcl_0001.png DVT_DT6h-12h_2018092600.png
#exit

gpview --anim t --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye+upper/.vr/hist.dmp_20180926-120000.bin.dat_diff.nc@dvr,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_diff_vr_1h_eye+upper_2018092612.pdf
gpview --anim t --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye+upper/.vr/hist.dmp_20180927-000000.bin.dat_diff.nc@dvr,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_diff_vr_1h_eye+upper_2018092700.pdf
gpview --anim t --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye+upper/.vr/hist.dmp_20180927-120000.bin.dat_diff.nc@dvr,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_diff_vr_1h_eye+upper_2018092712.pdf
#convert -trim dcl_0001.png DA_VR_DT12h_2018092612.png
#gpview --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1h/.vr/hist.dmp_20180926-120000.bin.dat_diff_diff.nc@dvr,t=^0,r=0.0:100000.0,z=0.0:20000.0
#convert -trim dcl_0001.png DVR_VR_DT1h-12h_2018092600.png

#rm dcl_0001.png
