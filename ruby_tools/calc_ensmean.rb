#!/home/z44533r/usr/local/CL_intel/bin/ruby
# [USAGE]: ruby draw_sprd.rb

require "~/irbrc_ggraph.rb"

wdir = "../exp/testcase_1h/"
ens_num = 30
memf = "hist.d01_20180927-000000.000.pe00"
outfile = "./mean_u_20180927-000000.000.nc"
aval = "U"  # ens_mean variable

#-- analysis part
ens_dir = wdir + "0001/"
u_memv = GPhys::IO.open_multi(`ls #{ens_dir}/#{memf}*.nc`.split("\n"),aval)
u_mean = u_memv

for i in 2..ens_num.to_i
   ens_dir = wdir + i.to_s.rjust(4,"0") + "/"
   u_memv = GPhys::IO.open_multi(`ls #{ens_dir}/#{memf}*.nc`.split("\n"),aval)
   u_mean = u_mean + u_memv
end

u_mean = u_mean / ens_num.to_f

ofile = NetCDF.create outfile
GPhys::IO.write ofile, u_mean
ofile.close

#tone du.cut("z"=>1000.0,"x"=>300000.0..550000.0,"y"=>550000.0..800000.0)
#tone du.cut("x"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "clr_max"=>56, "clr_min"=>15
#contour u_anal.cut("x"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "levels"=>[-10.0,-7.5,-5.0,0.0,5.0,7.5,10.0], "index"=>[26,23,22,21,22,23,26], "line_type"=>[2,2,2,1,1,1,1], "label"=>true
#contour u_mean.cut("x"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "levels"=>[-40.0,-20.0,0.0,20.0,40.0], "index"=>[56,53,51,53,56], "line_type"=>[2,2,2,1,1,1,1], "label"=>true
#DCLExt.color_bar("units"=>'m s\^{-1}')
