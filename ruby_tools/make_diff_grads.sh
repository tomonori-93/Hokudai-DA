ulimit -s unlimited

#-- ensmean
f1=$1
fref=$2
fdiff=$3
#f1=1h_eye_R050/.vt/hist.dmp_20180926-120000.bin.dat.nc
#fref=48h/.vt/hist.dmp_20180926-120000.bin.dat_diff.nc
#fdiff=1h_eye_R050/.vt/hist.dmp_20180926-120000.bin.dat_diff.nc
nx=640
ny=720
nz=36
grads_calc_fast $nx $ny $nz -1.0e35 "vt6h_V01==$f1" "vt12h==$fref" "$fdiff" 'vt6h_V01' 'vt12h' -
