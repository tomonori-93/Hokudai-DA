#!/home/z44533r/usr/local/CL_intel/bin/ruby
# [USAGE]: ruby draw_ens_pmin.rb

require "~/irbrc_ggraph.rb"

ensmem = 30
wdir = "../exp/testcase_1h/"
presf = "hist.d01_20180926-050000.000.pe00"
aval = "SFC_PRES"  # surface pressure
lonname = "lon"
latname = "lat"
pofile = "ens_point_05.dat"

pmin = NArray.sfloat(ensmem)
pmin_lon = NArray.sfloat(ensmem)
pmin_lat = NArray.sfloat(ensmem)

for i in 1..ensmem
   dir = wdir + i.to_s.rjust(4,"0")
#-- analysis part
   pres_val = GPhys::IO.open_multi(`ls #{dir}/#{presf}*.nc`.split("\n"),aval)[true,true,0]
   lon = GPhys::IO.open_multi(`ls #{dir}/#{presf}*.nc`.split("\n"),lonname)
   lat = GPhys::IO.open_multi(`ls #{dir}/#{presf}*.nc`.split("\n"),latname)
   pmin[i-1] = pres_val.min
   idx = pres_val.eq(pmin[i-1]).where
   idx_x = idx[0] % pres_val.coord(0).shape[0]  # idx が複数ある場合は最初をとる
   idx_y = idx[0] / pres_val.coord(0).shape[0]
   pmin_lon[i-1] = lon.val[idx_x,idx_y]
   pmin_lat[i-1] = lat.val[idx_x,idx_y]
   print "Pass [#{i.to_s.rjust(4,'0')}]\n"
end

string = "NNNN        Longitude         Latitude         Pres-min\n"
string = string + "NNNN          degrees          degrees               Pa\n"

for i in 1..ensmem
   string = string + (i-1).to_s.rjust(4,"0") + " " + sprintf("%16.8e",pmin_lon[i-1].to_f) + " " + sprintf("%16.8e",pmin_lat[i-1].to_f)+ " " + sprintf("%16.8e",pmin[i-1].to_f) + "\n"
end

f = open(pofile,"w")
f.write(string[0..-2])
f.close

print "Output: ", pofile, "\n"
#-- drawing part
#DCL.swpset('ldump',true)
#DCL.gropn(1)  # 1: PNG, 2: PDF (Not working)
#DCL.sgscmn(4)
#tone du.cut("xh"=>300000.0..550000.0,"y"=>550000.0..800000.0,"z"=>1000.0), true, "annotate"=>false, "clr_max"=>56, "clr_min"=>15
#contour u_anal.cut("xh"=>300000.0..550000.0,"y"=>550000.0..800000.0,"z"=>1000.0), false, "annotate"=>false, "levels"=>[-10.0,-7.5,-5.0,0.0,5.0,7.5,10.0], "index"=>[26,23,22,21,22,23,26], "line_type"=>[2,2,2,1,1,1,1], "label"=>true
#contour u_mean.cut("xh"=>300000.0..550000.0,"y"=>550000.0..800000.0,"z"=>1000.0), false, "annotate"=>false, "levels"=>[-40.0,-20.0,0.0,20.0,40.0], "index"=>[56,53,51,53,56], "line_type"=>[2,2,2,1,1,1,1], "label"=>true
#DCLExt.color_bar("units"=>"m s\^{-1}")

#-- graph ----
#DCL::grfrm

#DCL::usspnt(pmin_lon, pmin_lat)
#DCL::uspfit
#DCL::grstrf

#DCL::ussttl( 'Longitude', 'E', 'Latitude', 'N' )
#DCL::usdaxs

#DCL::uusmki(5)
#DCL::uusmks(0.015)
#DCL::uumrk(pmin_lon, pmin_lat)

#DCL::grcls
