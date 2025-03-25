#!/home/z44533r/usr/local/CL_intel/bin/ruby
# [USAGE]: ruby draw_sprd.rb

require "~/irbrc_ggraph.rb"

wdir = ARGV[0]
#wdir = "../exp/testcase_1h_eye_A08/"
ens_num = 30
memf = ARGV[1]
#memf = "hist.d01_20180927-120000.000.pe00"
outfile = ARGV[2]
#outfile = "hist.mslp_20180927-120000.bin"
aval = [ "MSLP" ]  # ens_mean variable
axname = [ "x", "y", "time" ]
time_attr_replace = ["seconds", "hours"]
addax1_var = VArray.new( NArray.float(1), {"long_name"=>"level", "units" => "1"}, "z")

#-- analysis part
for i in 1..ens_num.to_i
   ens_dir = wdir + i.to_s.rjust(4,"0") + "/"

   if File.exist?("#{ens_dir}/#{outfile}.dat")
      system("rm #{ens_dir}/#{outfile}.dat")
      print("rm #{ens_dir}/#{outfile}.dat\n")
   end

   couple_flist = ""

   for j in 0..aval.size-1
      u_memv = GPhys::IO.open_multi(`ls #{ens_dir}/#{memf}*.nc`.split("\n"),aval[j])
      time_units = u_memv.axis(axname[2]).pos.get_att("units")
      time_units = time_units.gsub(time_attr_replace[0],time_attr_replace[1])
#p u_memv.axis(axname[2]).pos.val

      addax2_var = VArray.new( u_memv.axis(axname[2]).pos.val, {"long_name"=>u_memv.axis(axname[2]).pos.get_att("long_name"), "units" => time_units}, axname[2])

      #-- define the vertical
      xax = u_memv.axis(axname[0])
      yax = u_memv.axis(axname[1])
      zax = Axis.new().set_pos(addax1_var)
      tax = Axis.new().set_pos(addax2_var)
#p tax.pos.get_att("units")
      grid = Grid.new( xax, yax, zax, tax )

      #-- define VArrays
      u_var = VArray.new( NArrayMiss.float(xax.length,yax.length,zax.length,tax.length).fill(0.0), {"long_name" => u_memv.get_att("long_name"), "units" => u_memv.get_att("units")}, u_memv.name )
      for k in 0..tax.length-1
         u_var[0..xax.length-1,0..yax.length-1,0,k] = u_memv.val[0..xax.length-1,0..yax.length-1,k]
      end
   
      u_out = GPhys.new( grid, u_var )
      if File.exist?("#{ens_dir}/#{outfile}-tmp.bin.dat")
         system("rm #{ens_dir}/#{outfile}-tmp.bin.dat")
         print("rm #{ens_dir}/#{outfile}-tmp.bin.dat\n")
      end
      #GPhys::GrADS_IO.write("#{ens_dir}/#{outfile}",u_out,name=aval[j])
      GPhys::GrADS_IO.write("#{ens_dir}/#{outfile}-tmp.bin",u_out,name=aval[j])
      #system("mv #{ens_dir}/#{outfile}.dat tmp.bin")

      fbin = open("#{ens_dir}/#{outfile}-tmp.bin.dat", "rb")
      fsize = File.size("#{ens_dir}/#{outfile}-tmp.bin.dat")
      m = fbin.read(fsize)
      vsize = fsize / 8
      clist = "E" + vsize.to_s  # E = little endian 64bit
      bin_val = m.unpack(clist)
      puts bin_val[0]
      obin = open("#{ens_dir}/#{outfile}-tmp.#{aval[j]}.bin","wb")
      #obin = open("#{ens_dir}/#{outfile}.dat","wb")
      obin.write(bin_val.pack("g#{vsize.to_s}"))  # g = big endian 32bit
      fbin.close
      obin.close

      couple_flist = couple_flist + "#{ens_dir}/#{outfile}-tmp.#{aval[j]}.bin "
   end

   system("grads_couple #{ens_dir}/#{outfile}.dat #{vsize} 1 #{couple_flist}")
   puts "Output #{ens_dir}/#{outfile}.dat"
   system("rm #{ens_dir}/#{outfile}-tmp.bin.dat #{ens_dir}/#{outfile}-tmp.bin #{couple_flist}")

end

#ofile = NetCDF.create outfile
#GPhys::IO.write ofile, u_mean
#ofile.close

#tone du.cut("z"=>1000.0,"x"=>300000.0..550000.0,"y"=>550000.0..800000.0)
#tone du.cut("x"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "clr_max"=>56, "clr_min"=>15
#contour u_anal.cut("x"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "levels"=>[-10.0,-7.5,-5.0,0.0,5.0,7.5,10.0], "index"=>[26,23,22,21,22,23,26], "line_type"=>[2,2,2,1,1,1,1], "label"=>true
#contour u_mean.cut("x"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "levels"=>[-40.0,-20.0,0.0,20.0,40.0], "index"=>[56,53,51,53,56], "line_type"=>[2,2,2,1,1,1,1], "label"=>true
#DCLExt.color_bar("units"=>'m s\^{-1}')
