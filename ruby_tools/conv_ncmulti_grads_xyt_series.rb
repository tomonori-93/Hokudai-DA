#!/home/z44533r/usr/local/CL_intel/bin/ruby
# [USAGE]: ruby draw_sprd.rb

require "~/irbrc_ggraph.rb"
require "time"

wdir = ARGV[0]
#wdir = "../exp/testcase_1h_eye_A08/"
ens_num = 30
memf = ARGV[1]
#memf = "hist.d01_20180927-120000.000.pe00"
outfile_head = ARGV[2]
#outfile = "hist.mslp_"
outfile_foot = ".bin"
aval = [ "MSLP" ]  # ens_mean variable
axname = [ "x", "y", "time" ]
time_attr_replace = ["seconds", "hours"]
time_scale = 3600.0  # scale factor to convert sec to hour
addax1_var = VArray.new( NArray.float(1), {"long_name"=>"level", "units" => "1"}, "z")

#-- analysis part
for i in 1..ens_num.to_i
   ens_dir = wdir + i.to_s.rjust(4,"0") + "/"

   #-- Loop for varibles
   for j in 0..aval.size-1
      u_memv = GPhys::IO.open_multi(`ls #{ens_dir}/#{memf}*.nc`.split("\n"),aval[j])
      time_units = u_memv.axis(axname[-1]).pos.get_att("units")
      time_units = time_units.gsub(time_attr_replace[0],time_attr_replace[1])
#p u_memv.axis(axname[2]).pos.val

      addax2_var = VArray.new( u_memv.axis(axname[2]).pos.val, {"long_name"=>u_memv.axis(axname[2]).pos.get_att("long_name"), "units" => time_units}, axname[2])

      #-- define the vertical
      xax = u_memv.axis(axname[0])
      yax = u_memv.axis(axname[1])
      zax = Axis.new().set_pos(addax1_var)
      tax = Axis.new().set_pos(addax2_var)
#p tax.pos.get_att("units")

      if j == 0 then
         couple_flist = Array.new(tax.length)
         rm_flist = Array.new(tax.length)
         out_flist = Array.new(tax.length)
      end

      #-- Loop for time
      for k in 0..tax.length-1
         #-- define VArrays
         grid = Grid.new( xax, yax, zax, tax[k..k] )
         u_var = VArray.new( NArrayMiss.float(xax.length,yax.length,zax.length,1).fill(0.0), {"long_name" => u_memv.get_att("long_name"), "units" => u_memv.get_att("units")}, u_memv.name )
         u_var[0..xax.length-1,0..yax.length-1,0,0] = u_memv.val[0..xax.length-1,0..yax.length-1,k]
         u_out = GPhys.new( grid, u_var )
         ctime = Time.parse(tax.pos.get_att("units").gsub("hours since ",""))
         ctime = ctime + tax.pos.val[k].to_i  # sum by second
         outfile = outfile_head + ctime.year.to_s.rjust(4,"0") + ctime.month.to_s.rjust(2,"0") + ctime.day.to_s.rjust(2,"0") \
                                + "-" + ctime.hour.to_s.rjust(2,"0") + ctime.min.to_s.rjust(2,"0") + ctime.sec.to_s.rjust(2,"0") + outfile_foot
         if j == 0 then
            if File.exist?("#{ens_dir}/#{outfile}.dat")
               system("rm #{ens_dir}/#{outfile}.dat")
               print("rm #{ens_dir}/#{outfile}.dat\n")
            end
            out_flist[k] = outfile
         end
         if File.exist?("#{ens_dir}/#{out_flist[k]}-tmp.bin.dat")
            system("rm #{ens_dir}/#{out_flist[k]}-tmp.bin.dat")
            print("rm #{ens_dir}/#{out_flist[k]}-tmp.bin.dat\n")
         end
         #GPhys::GrADS_IO.write("#{ens_dir}/#{out_flist[k]}",u_out,name=aval[j])
         GPhys::GrADS_IO.write("#{ens_dir}/#{out_flist[k]}-tmp.bin",u_out,name=aval[j])
         #system("mv #{ens_dir}/#{out_flist[k]}.dat tmp.bin")

         fbin = open("#{ens_dir}/#{out_flist[k]}-tmp.bin.dat", "rb")
         fsize = File.size("#{ens_dir}/#{out_flist[k]}-tmp.bin.dat")
         m = fbin.read(fsize)
         vsize = fsize / 8
         clist = "E" + vsize.to_s  # E = little endian 64bit
         bin_val = m.unpack(clist)
         puts bin_val[0]
         obin = open("#{ens_dir}/#{out_flist[k]}-tmp.#{aval[j]}.bin","wb")
         #obin = open("#{ens_dir}/#{out_flist[k]}.dat","wb")
         obin.write(bin_val.pack("g#{vsize.to_s}"))  # g = big endian 32bit
         fbin.close
         obin.close

         if j == 0 then
            couple_flist[k] = "#{ens_dir}/#{out_flist[k]}-tmp.#{aval[j]}.bin "
         else
            couple_flist[k] = couple_flist[k] + "#{ens_dir}/#{out_flist[k]}-tmp.#{aval[j]}.bin "
         end
      end
   
   end

   if tax.length == 1 then
      for k in 0..tax.length-1
         system("mv #{couple_flist[k]} #{ens_dir}/#{out_flist[k]}.dat")
         puts "Output #{ens_dir}/#{out_flist[k]}.dat"
         system("rm #{ens_dir}/#{out_flist[k]}-tmp.bin.dat #{ens_dir}/#{out_flist[k]}-tmp.bin #{couple_flist[k]}")
      end
   else
      for k in 0..tax.length-1
         system("grads_couple #{ens_dir}/#{out_flist[k]}.dat #{vsize} 1 #{couple_flist[k]}")
         puts "Output #{ens_dir}/#{out_flist[k]}.dat"
         system("rm #{ens_dir}/#{out_flist[k]}-tmp.bin.dat #{ens_dir}/#{out_flist[k]}-tmp.bin #{couple_flist[k]}")
      end
   end

end

#ofile = NetCDF.create outfile
#GPhys::IO.write ofile, u_mean
#ofile.close

