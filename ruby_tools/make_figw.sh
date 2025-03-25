
gpview --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,75999,85999,95999 1h/.w/hist.dmp_20180926-120000.bin.dat_Moveave.nc@w,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DA_W_DT1h_2018092612.png
gpview --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,75999,85999,95999 12h/.w/hist.dmp_20180926-120000.bin.dat_Moveave.nc@w,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DA_W_DT12h_2018092612.png
gpview --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,75999,85999,95999 1h/.w/hist.dmp_20180926-120000.bin.dat_Moveave_diff.nc@dw,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DW_W_DT1h-12h_2018092612.png
gpview --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,75999,85999,95999 1h_upper/.w/hist.dmp_20180926-120000.bin.dat_Moveave.nc@w,t=^0,r=0.0:100000.0,z=0.0:20000.0
convert -trim dcl_0001.png DA_W_DT1h_upper_2018092612.png

#rm dcl_0001.png
