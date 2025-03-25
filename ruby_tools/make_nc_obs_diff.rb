#!/usr/bin/ruby
# Differing two NetCDF (fname1-fname2)
# [NOTE]: the twn files are required that the grid numbers of r and z are identical to each other.

require "~/irbrc_ggraph.rb"

if ARGV.size < 6 then
   puts "[USAGE]: ruby make_nc_obs_diff.rb refncname ncname vname outname expname reftime"
   exit
end

#fname1 = "../obs/T1824.2km.NCEP.03.dmp.vt.united.bin_SCALE.nc"
#fname1 = "../obs/T1824.2km.NCEP.03.dmp.vt.united.bin_SCALE_r100.nc"
fname1 = ARGV[0]  # reference obs data
fname2 = ARGV[1]  # ensmean data
#fname2 = "1_output/1h_upper_rotspeed_R030/.vt/hist.dmp_20180926-120000.bin.dat_Moveave.nc"
vname1 = ARGV[2]
vname2 = vname1
outname = ARGV[3]  # Output file name
#outname = "1_output/1h_upper_rotspeed_R030/.vt/hist.dmp_20180926-120000.bin.dat_Moveave_obsdiff.nc"  # Output file name
outvname = "d" + vname1
expname = ARGV[4]
outlname = "Difference in " + vname1 + " between " + expname + " and OBS"
#outlname = "Difference in vt between 1h_upper_rotspeed_R030 and OBS"
rname1 = "r"
rname2 = "r"
zname1 = "z"
zname2 = "z"
tname1 = "t"
tname2 = "t"
trange1 = ARGV[5].to_f
#trange1 = ARGV[4].to_f
# identical twin
#trange1 = 129600.0  # 2018/09/27 12Z for obs file
#trange1 = 86400.0  # 2018/09/27 00Z for obs file
#trange1 = 43200.0  # 2018/09/26 12Z for obs file
# non-identical twin
#trange1 = 518400.0  # 2018/09/27 12Z for obs file
#trange1 = 475200.0  # 2018/09/27 00Z for obs file
#trange1 = 432000.0  # 2018/09/26 12Z for obs file
trange2 = ARGV[5].to_f  # ensmean for ensemble file
#trange2 = 0.0  # ensmean for ensemble file

gp1 = GPhys::IO.open(fname1,vname1).cut(tname1=>trange1)
gp2 = GPhys::IO.open(fname2,vname2).cut(tname2=>trange2)
diff = gp2 - gp1
diff.name=(outvname)
diff.long_name=(outlname)

# output
ofform = NetCDF.create(outname)
GPhys::NetCDF_IO.write(ofform,diff)
ofform.close
puts "Output #{outname}"
