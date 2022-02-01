dir=/home/z43516n/usr/local

for i in conv_t2b_prepbuf.f90 conv_t2b_h08vt.f90
do
   ifort -assume byterecl -convert little_endian -I"$dir"/include $i -L"$dir"/lib -lstpk -o ${i%.f90}
   echo ifort -assume byterecl -convert little_endian -I"$dir"/include $i -L"$dir"/lib -lstpk -o ${i%.f90}
done
