#!/home/z44533r/usr/local/CL_intel/bin/ruby
# [USAGE]: ruby draw_sprd.rb

require "~/irbrc_ggraph.rb"

wdir = ARGV[0]
#wdir = "../exp/testcase_1h_eye_A02/"
ens_num = 30
#memf = "hist.d01_20180927-120000.000.pe00"
memf = ARGV[1]
outfile = ARGV[2]
#outfile = "../exp/testcase_1h_eye_A02/mean_ruby/mean_dmp_20180927-120000.000.nc"
outsprdf = ARGV[3]
#outsprdf = "../exp/testcase_1h_eye_A02/mean_ruby/sprd_dmp_20180927-120000.000.nc"
aval = [ "MSLP" ]   # ens_mean variable
if ARGV.size == 3 then
   sprd_flag = false
elsif ARGV.size == 4 then
   sprd_flag = true
else
   puts "[USAGE]: ruby calc_ensmeansprd_xyzt.rb wdir memf outfile [outsprd]"
   exit
end

ofile = NetCDF.create outfile

if sprd_flag == true then
   sofile = NetCDF.create outsprdf
end

for k in 0..aval.size-1
   #-- analysis part
   ens_dir = wdir + "0001/"
   u_memv = GPhys::IO.open_multi(`ls #{ens_dir}/#{memf}*.nc`.split("\n"),aval[k])[true,true,0]  # ALl X,Y, and T=^0
   puts "Open for mean #{ens_dir}/#{memf}..."
   u_mean = u_memv

   for i in 2..ens_num.to_i
      ens_dir = wdir + i.to_s.rjust(4,"0") + "/"
      puts "Open for mean #{ens_dir}/#{memf}..."
      u_memv = GPhys::IO.open_multi(`ls #{ens_dir}/#{memf}*.nc`.split("\n"),aval[k])[true,true,0]  # ALl X,Y, and T=^0
      u_mean = u_mean + u_memv
   end

   u_mean = u_mean / ens_num.to_f

   GPhys::IO.write ofile, u_mean

   if sprd_flag == true then
      ens_dir = wdir + "0001/"
      u_memv = GPhys::IO.open_multi(`ls #{ens_dir}/#{memf}*.nc`.split("\n"),aval[k])[true,true,0]  # ALl X,Y, and T=^0
      puts "Open for sprd #{ens_dir}/#{memf}..."
      u_sprd = (u_memv - u_mean)**2
      for i in 2..ens_num.to_i
         ens_dir = wdir + i.to_s.rjust(4,"0") + "/"
         u_memv = GPhys::IO.open_multi(`ls #{ens_dir}/#{memf}*.nc`.split("\n"),aval[k])[true,true,0]  # ALl X,Y, and T=^0
         puts "Open for sprd #{ens_dir}/#{memf}..."
         u_sprd = u_sprd + (u_memv - u_mean)**2
      end
      u_sprd = u_sprd.sqrt / sqrt((ens_num.to_i - 1).to_f)

      GPhys::IO.write sofile, u_sprd
   end

   puts "Check #{aval[k]}."
end

ofile.close
puts "Output #{outfile}."
if sprd_flag == true then
   sofile.close
   puts "Output #{outsprdf}."
end
