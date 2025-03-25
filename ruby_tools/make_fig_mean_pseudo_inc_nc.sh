
gpview --wsn=2 --clrmap=4 --levels -1.5,-1.0,-0.75,-0.5,-0.25,0.0,0.25,0.5,0.75,1.0,1.5 --patterns 12999,20555,32999,37999,42999,50999,62999,70999,73999,76999,86999,93999 1_output/1h_upper/.vt/anal.d01_20180927-120000.000.bin_Moveave_diff.nc@dvt,t=^0,r=0.0:150000.0,z=0.0:20000.0
mv -i dcl.pdf mean_pseudo_inc_vt_1h_upper_2018092712.pdf

gpview --wsn=2 --clrmap=4 --levels -1.5,-1.0,-0.75,-0.5,-0.25,0.0,0.25,0.5,0.75,1.0,1.5 --patterns 12999,20555,32999,37999,42999,50999,62999,70999,73999,76999,86999,93999 1_output/1h_upper/.vr/anal.d01_20180927-120000.000.bin_Moveave_diff.nc@dvr,t=^0,r=0.0:150000.0,z=0.0:20000.0
mv -i dcl.pdf mean_pseudo_inc_vr_1h_upper_2018092712.pdf

#rm dcl_0001.png
