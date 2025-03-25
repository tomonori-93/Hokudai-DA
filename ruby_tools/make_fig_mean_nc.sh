
rrange=200000.0
trange=432000.0  # 2018/09/26 12Z
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs/T1824.2km.NCEP.03.dmp.vt.united.bin.nc@vt,t=$trange,r=0.0:$rrange,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_2018092612_wide.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs/T1824.2km.NCEP.03.dmp.vr.united.bin.nc@vr,t=$trange,r=0.0:$rrange,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_2018092612_wide.pdf
trange=475200.0  # 2018/09/27 00Z
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs/T1824.2km.NCEP.03.dmp.vt.united.bin.nc@vt,t=$trange,r=0.0:$rrange,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_2018092700_wide.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs/T1824.2km.NCEP.03.dmp.vr.united.bin.nc@vr,t=$trange,r=0.0:$rrange,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_2018092700_wide.pdf
trange=518400.0  # 2018/09/27 12Z
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs/T1824.2km.NCEP.03.dmp.vt.united.bin.nc@vt,t=$trange,r=0.0:$rrange,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_2018092712_wide.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs/T1824.2km.NCEP.03.dmp.vr.united.bin.nc@vr,t=$trange,r=0.0:$rrange,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_2018092712_wide.pdf

rrange1=100000.0
rrange2=200000.0
trange=0.0  # 2018/09/26 00Z
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs_identicaltwin/UV_.vt.grd.nc@vt,t=$trange,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_identicaltwin_2018092600.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs_identicaltwin/UV_.vt.grd.nc@vt,t=$trange,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_identicaltwin_2018092600_wide.pdf
trange=43200.0  # 2018/09/26 12Z
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs_identicaltwin/UV_.vt.grd.nc@vt,t=$trange,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_identicaltwin_2018092612.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs_identicaltwin/UV_.vt.grd.nc@vt,t=$trange,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_identicaltwin_2018092612_wide.pdf
trange=86400.0  # 2018/09/27 00Z
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs_identicaltwin/UV_.vt.grd.nc@vt,t=$trange,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_identicaltwin_2018092700.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs_identicaltwin/UV_.vt.grd.nc@vt,t=$trange,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_identicaltwin_2018092700_wide.pdf
trange=129600.0  # 2018/09/27 12Z
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs_identicaltwin/UV_.vt.grd.nc@vt,t=$trange,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_identicaltwin_2018092712.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 ../obs_identicaltwin/UV_.vt.grd.nc@vt,t=$trange,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vt_obs_identicaltwin_2018092712_wide.pdf

trange=0.0  # 2018/09/26 00Z
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs_identicaltwin/UV_.vr.grd.nc@vr,t=$trange,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_identicaltwin_2018092600.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs_identicaltwin/UV_.vr.grd.nc@vr,t=$trange,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_identicaltwin_2018092600_wide.pdf
trange=43200.0  # 2018/09/26 12Z
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs_identicaltwin/UV_.vr.grd.nc@vr,t=$trange,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_identicaltwin_2018092612.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs_identicaltwin/UV_.vr.grd.nc@vr,t=$trange,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_identicaltwin_2018092612_wide.pdf
trange=86400.0  # 2018/09/27 00Z
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs_identicaltwin/UV_.vr.grd.nc@vr,t=$trange,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_identicaltwin_2018092700.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs_identicaltwin/UV_.vr.grd.nc@vr,t=$trange,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_identicaltwin_2018092700_wide.pdf
trange=129600.0  # 2018/09/27 12Z
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs_identicaltwin/UV_.vr.grd.nc@vr,t=$trange,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_identicaltwin_2018092712.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 ../obs_identicaltwin/UV_.vr.grd.nc@vr,t=$trange,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vr_obs_identicaltwin_2018092712_wide.pdf

gpview --wsn=2 --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,77999,84999,95999 1_output/1h_eye_A08/.w/hist.dmp_20180926-120000.bin.dat_Moveave.nc@w,t=^0,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf mean_w_1h_eye_A08_2018092612.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,77999,84999,95999 1_output/1h_eye_A08/.w/hist.dmp_20180927-000000.bin.dat_Moveave.nc@w,t=^0,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf mean_w_1h_eye_A08_2018092700.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,77999,84999,95999 1_output/1h_eye_A08/.w/hist.dmp_20180927-120000.bin.dat_Moveave.nc@w,t=^0,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf mean_w_1h_eye_A08_2018092712.pdf
#exit

gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_eye_A08/.vt/hist.dmp_20180926-000000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vt_1h_eye_A08_2018092600.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_eye_A08/.vt/hist.dmp_20180926-000000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vt_1h_eye_A08_2018092600_wide.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_eye_A08/.vt/hist.dmp_20180926-120000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vt_1h_eye_A08_2018092612.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_eye_A08/.vt/hist.dmp_20180926-120000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vt_1h_eye_A08_2018092612_wide.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_eye_A08/.vt/hist.dmp_20180927-000000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vt_1h_eye_A08_2018092700.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_eye_A08/.vt/hist.dmp_20180927-000000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vt_1h_eye_A08_2018092700_wide.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_eye_A08/.vt/hist.dmp_20180927-120000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vt_1h_eye_A08_2018092712.pdf
gpview --wsn=2 --clrmap=4 --levels 0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0 --patterns 55999,60999,65999,70999,75999,80999,85999,90999,95999 1_output/1h_eye_A08/.vt/hist.dmp_20180927-120000.bin.dat_Moveave.nc@vt,t=^0,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vt_1h_eye_A08_2018092712_wide.pdf
#convert -trim dcl_0001.png DA_VT_DT6h_2018092612.png
#gpview --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 6h/.vt/hist.dmp_20180926-120000.bin.dat_Moveave_diff.nc@dvt,t=^0,t=^0,r=0.0:100000.0,z=0.0:20000.0
#convert -trim dcl_0001.png DVT_DT6h-12h_2018092600.png
#exit

gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye_A08/.vr/hist.dmp_20180926-000000.bin.dat_Moveave.nc@vr,t=^0,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vr_1h_eye_A08_2018092600.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye_A08/.vr/hist.dmp_20180926-000000.bin.dat_Moveave.nc@vr,t=^0,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vr_1h_eye_A08_2018092600_wide.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye_A08/.vr/hist.dmp_20180926-120000.bin.dat_Moveave.nc@vr,t=^0,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vr_1h_eye_A08_2018092612_.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye_A08/.vr/hist.dmp_20180926-120000.bin.dat_Moveave.nc@vr,t=^0,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vr_1h_eye_A08_2018092612_wide.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye_A08/.vr/hist.dmp_20180927-000000.bin.dat_Moveave.nc@vr,t=^0,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vr_1h_eye_A08_2018092700.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye_A08/.vr/hist.dmp_20180927-000000.bin.dat_Moveave.nc@vr,t=^0,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vr_1h_eye_A08_2018092700_wide.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye_A08/.vr/hist.dmp_20180927-120000.bin.dat_Moveave.nc@vr,t=^0,r=0.0:$rrange1,z=0.0:20000.0
mv -i dcl.pdf mean_vr_1h_eye_A08_2018092712.pdf
gpview --wsn=2 --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1_output/1h_eye_A08/.vr/hist.dmp_20180927-120000.bin.dat_Moveave.nc@vr,t=^0,r=0.0:$rrange2,z=0.0:20000.0
mv -i dcl.pdf mean_vr_1h_eye_A08_2018092712_wide.pdf
#convert -trim dcl_0001.png DA_VR_DT12h_2018092612.png
#gpview --clrmap=4 --levels -8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0 --patterns 15999,25999,35999,40999,50999,60999,70999,75999,85999,95999 1h/.vr/hist.dmp_20180926-120000.bin.dat_Moveave_diff.nc@dvr,t=^0,t=^0,r=0.0:100000.0,z=0.0:20000.0
#convert -trim dcl_0001.png DVR_VR_DT1h-12h_2018092600.png

#rm dcl_0001.png
