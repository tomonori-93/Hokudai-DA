#!/home/z44533r/usr/local/CL_intel/bin/ruby
# tcenter 処理済みファイル

wdir = ARGV[0]  # Working directory
#wdir = "../exp/testcase_1h_eye_dx2km/"
ens_num = 30
colnum = 16  # Fix
ifile = ["hist.geo_20180926-000000.bin.dat.tcenter", "hist.geo_20180926-120000.bin.dat.tcenter", "hist.geo_20180927-000000.bin.dat.tcenter", "hist.geo_20180927-120000.bin.dat.tcenter"]
#ifile = ["hist.geo_20180926-000000.bin.dat.tcenter", "hist.geo_20180926-060000.bin.dat.tcenter", "hist.geo_20180926-120000.bin.dat.tcenter", "hist.geo_20180926-180000.bin.dat.tcenter", "hist.geo_20180927-000000.bin.dat.tcenter", "hist.geo_20180927-060000.bin.dat.tcenter", "hist.geo_20180927-120000.bin.dat.tcenter", "hist.geo_20180927-180000.bin.dat.tcenter"]
outfile = ARGV[1]
#outfile = "hist.geo_20180926-000000.bin"  # ORG
cpcol = 11  # input column

if ARGV.size < 2 then
puts "STOP. Insufficient arguments."
exit
end

cont = ""
head1 = "'Timestep'       "
head2 = "'Timestep'       "

for i in 0..ifile.size-1
   tmpfile = wdir + "/" + ifile[i]
   f = open(tmpfile,"r").read.split("\n")
   if i == 0 then
      for j in 1..ens_num.to_i
         head1 = head1 + "'Ensemble#{i.to_s.rjust(3,'0')}'   "
         head2 = head2 + f[1][(cpcol.to_i-1)*colnum.to_i..(cpcol.to_i)*colnum.to_i-1]
      end
      cont = cont + head1 + "\n" + head2 + "\n"
   end
   cont = cont + i.to_s.rjust(8,'0') + "        "
   for j in 2..f.size-1
      cont = cont + f[j][(cpcol.to_i-1)*colnum.to_i..(cpcol.to_i)*colnum.to_i-1]
   end
   cont = cont + "\n"
end

of = open(wdir+outfile,"w")
of.write(cont[0..-2])
of.close
puts "Output: #{wdir+outfile}"
