
gpview --wsn=2 --anim t --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,75999,85999,95999 1h/.w/hist.dmp_20180926-120000.bin.dat.nc@w,t=^0:29,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_w_1h_eye.pdf
gpview --wsn=2 --anim t --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,75999,85999,95999 1h_upper/.w/hist.dmp_20180926-120000.bin.dat.nc@w,t=^0:29,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_w_1h_upper.pdf
gpview --wsn=2 --anim t --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,75999,85999,95999 1h_eye+upper/.w/hist.dmp_20180926-120000.bin.dat.nc@w,t=^0:29,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_w_1h_eye+upper.pdf
gpview --wsn=2 --anim t --clrmap=4 --levels 0.0,0.1,0.3,0.5,0.7,0.9 --patterns 50999,55999,60999,70999,75999,85999,95999 12h/.w/hist.dmp_20180926-120000.bin.dat.nc@w,t=^0:29,r=0.0:100000.0,z=0.0:20000.0
mv -i dcl.pdf ens_w_12h.pdf
