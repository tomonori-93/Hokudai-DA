#!/home/z44533r/usr/local/CL_intel/bin/ruby
# [USAGE]: ruby draw_sprd.rb

require "~/irbrc_ggraph.rb"

#wdir = "../exp/testcase_1h_eye_A02/"  # ORG
wdir = ARGV[0]  # for loop
ens_num = 30
#memf = "gues.d01_20180926-120000.000.pe00"  # ORG
memf = ARGV[1]  # for loop
#outfile = "../exp/testcase_1h_eye_A02/mean_ruby/mean_gues_20180926-120000.000.nc"  # ORG
outfile = ARGV[2]  # for loop
aval = [ "MOMX", "MOMY", "MOMZ", "DENS", "RHOT" ]   # ens_mean variable

ofile = NetCDF.create outfile

for k in 0..aval.size-1
   #-- analysis part
   ens_dir = wdir + "0001/"
   u_memv = GPhys::IO.open_multi(`ls #{ens_dir}/#{memf}*.nc`.split("\n"),aval[k])  # ALl X,Y,Z
   u_mean = u_memv

   for i in 2..ens_num.to_i
      ens_dir = wdir + i.to_s.rjust(4,"0") + "/"
      u_memv = GPhys::IO.open_multi(`ls #{ens_dir}/#{memf}*.nc`.split("\n"),aval[k])  # ALl X,Y,Z
      u_mean = u_mean + u_memv
   end

   u_mean = u_mean / ens_num.to_f

   GPhys::IO.write ofile, u_mean

   puts "Check #{aval[k]}."
end

ofile.close
puts "Output #{outfile}."
