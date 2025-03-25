
gpview --anim t --wsn=2 --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,77999,84999,95999 1_output/1h_himawari_sig5ms_R050_V01/.w/hist.dmp_20180926-120000.bin.dat.nc@w,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_w_1h_himawari_sig5ms_R050_V01_2018092612.pdf
gpview --anim t --wsn=2 --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,77999,84999,95999 1_output/1h_himawari_sig5ms_R050_V01/.w/hist.dmp_20180927-000000.bin.dat.nc@w,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_w_1h_himawari_sig5ms_R050_V01_2018092700.pdf
gpview --anim t --wsn=2 --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,77999,84999,95999 1_output/1h_himawari_sig5ms_R050_V01/.w/hist.dmp_20180927-120000.bin.dat.nc@w,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_w_1h_himawari_sig5ms_R050_V01_2018092712.pdf
#exit

gpview --anim t --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_himawari_sig5ms_R050_V01/.vt/hist.dmp_20180926-120000.bin.dat.nc@vt,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_vt_1h_himawari_sig5ms_R050_V01_2018092612.pdf
gpview --anim t --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_himawari_sig5ms_R050_V01/.vt/hist.dmp_20180927-000000.bin.dat.nc@vt,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_vt_1h_himawari_sig5ms_R050_V01_2018092700.pdf
gpview --anim t --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_himawari_sig5ms_R050_V01/.vt/hist.dmp_20180927-120000.bin.dat.nc@vt,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_vt_1h_himawari_sig5ms_R050_V01_2018092712.pdf
#convert -trim dcl_0001.png DA_VT_DT6h_2018092612.png
#gpview --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 6h/.vt/hist.dmp_20180926-120000.bin.dat_diff.nc@dvt,t=^0,r=0.0:100000.0,z=0.0:20000.0
#convert -trim dcl_0001.png DVT_DT6h-12h_2018092600.png
#exit

gpview --anim t --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_himawari_sig5ms_R050_V01/.vr/hist.dmp_20180926-120000.bin.dat.nc@vr,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_vr_1h_himawari_sig5ms_R050_V01_2018092612.pdf
gpview --anim t --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_himawari_sig5ms_R050_V01/.vr/hist.dmp_20180927-000000.bin.dat.nc@vr,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_vr_1h_himawari_sig5ms_R050_V01_2018092700.pdf
gpview --anim t --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_himawari_sig5ms_R050_V01/.vr/hist.dmp_20180927-120000.bin.dat.nc@vr,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_vr_1h_himawari_sig5ms_R050_V01_2018092712.pdf
#convert -trim dcl_0001.png DA_VR_DT12h_2018092612.png
#gpview --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1h/.vr/hist.dmp_20180926-120000.bin.dat_diff.nc@dvr,t=^0,r=0.0:100000.0,z=0.0:20000.0
#convert -trim dcl_0001.png DVR_VR_DT1h-12h_2018092600.png

#rm dcl_0001.png
