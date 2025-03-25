#!/home/z44533r/usr/local/CL_intel/bin/ruby
# [USAGE]: ruby draw_sprd.rb

require "~/irbrc_ggraph.rb"

wdir = ARGV[0]
#wdir = "1_output/1h_eye_identicaltwin_UV/mean_ruby/"
ifile = ARGV[1]
#ifile = "mean_dmp_20180927-000000.00086400.nc"
outfile = ARGV[2]
#outfile = "mean_dmp_20180927-000000.00086400.bin"
aval = [ "U", "V", "W" ]  # ens_mean variable
axname = [ "x", "y", "z" ]
time_attr_replace = ["seconds", "hours"]
#addax1_var = VArray.new( NArray.float(1), {"long_name"=>"level", "units" => "1"}, "z")
addax2_var = VArray.new( NArray.float(1), {"long_name"=>"time", "units" => "hours since 2018-09-26 00:00:00"}, "time")

if File.exist?("#{wdir}/#{outfile}.dat")
   system("rm #{wdir}/#{outfile}.dat")
   print("rm #{wdir}/#{outfile}.dat\n")
end

couple_flist = ""

for j in 0..aval.size-1
   u_memv = GPhys::IO.open("#{wdir}/#{ifile}",aval[j])

   #-- define the vertical
   xax = u_memv.axis(axname[0])
   yax = u_memv.axis(axname[1])
   zax = u_memv.axis(axname[2])
   tax = Axis.new().set_pos(addax2_var)
   grid = Grid.new( xax, yax, zax, tax )

   #-- define VArrays
   u_var = VArray.new( NArrayMiss.float(xax.length,yax.length,zax.length,tax.length).fill(0.0), {"long_name" => u_memv.get_att("long_name"), "units" => u_memv.get_att("units")}, u_memv.name )
   u_var[0..xax.length-1,0..yax.length-1,0..zax.length-1,0] = u_memv.val[0..xax.length-1,0..yax.length-1,0..zax.length-1]

   u_out = GPhys.new( grid, u_var )
   if File.exist?("#{wdir}/#{outfile}-tmp.bin.dat")
      system("rm #{wdir}/#{outfile}-tmp.bin.dat")
      print("rm #{wdir}/#{outfile}-tmp.bin.dat\n")
   end
   #GPhys::GrADS_IO.write("#{wdir}/#{outfile}",u_out,name=aval[j])
   GPhys::GrADS_IO.write("#{wdir}/#{outfile}-tmp.bin",u_out,name=aval[j])
   #system("mv #{wdir}/#{outfile}.dat tmp.bin")

   fbin = open("#{wdir}/#{outfile}-tmp.bin.dat", "rb")
   fsize = File.size("#{wdir}/#{outfile}-tmp.bin.dat")
   m = fbin.read(fsize)
   vsize = fsize / 8
   clist = "E" + vsize.to_s  # E = little endian 64bit
   bin_val = m.unpack(clist)
   puts bin_val[0]
   obin = open("#{wdir}/#{outfile}-tmp.#{aval[j]}.bin","wb")
   #obin = open("#{wdir}/#{outfile}.dat","wb")
   obin.write(bin_val.pack("g#{vsize.to_s}"))  # g = big endian 32bit
   fbin.close
   obin.close

   couple_flist = couple_flist + "#{wdir}/#{outfile}-tmp.#{aval[j]}.bin "
end

system("grads_couple #{wdir}/#{outfile} #{vsize} 1 #{couple_flist}")
puts "Output #{wdir}/#{outfile}"
system("rm #{wdir}/#{outfile}-tmp.bin.dat #{wdir}/#{outfile}-tmp.bin #{couple_flist}")

