#!/home/z44533r/usr/local/CL_intel/bin/ruby
# [USAGE]: ruby draw_sprd.rb

require "~/irbrc_ggraph.rb"

wdir = "../exp/testcase_1h/"
analf = "sprd/anal.d01_20180926-120000.000.pe00"
guesf = "sprd/gues.d01_20180926-120000.000.pe00"
meanf = "mean/gues.d01_20180926-120000.000.pe00"
aval = "MOMX"  # momentum in X

#-- analysis part
u_gues = GPhys::IO.open_multi(`ls #{wdir}/#{guesf}*.nc`.split("\n"),aval)
u_anal = GPhys::IO.open_multi(`ls #{wdir}/#{analf}*.nc`.split("\n"),aval)
u_mean = GPhys::IO.open_multi(`ls #{wdir}/#{meanf}*.nc`.split("\n"),aval)
du = u_anal - u_gues

#-- drawing part
DCL.swpset('ldump',true)
DCL.sgiset( 'ifont', 1 )
DCL.swlset( 'lsysfnt', true )
DCL.gropn(1)  # 1: PNG, 2: PDF (Not working)
DCL.swcset('fontname', 'Nimbus Sans 12')
DCL.sgscmn(4)
#tone du.cut("z"=>1000.0,"xh"=>300000.0..550000.0,"y"=>550000.0..800000.0)
tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "clr_max"=>56, "clr_min"=>15
contour u_anal.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "levels"=>[-10.0,-7.5,-5.0,0.0,5.0,7.5,10.0], "index"=>[26,23,22,21,22,23,26], "line_type"=>[2,2,2,1,1,1,1], "label"=>true
contour u_mean.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "levels"=>[-40.0,-20.0,0.0,20.0,40.0], "index"=>[56,53,51,53,56], "line_type"=>[2,2,2,1,1,1,1], "label"=>true
DCLExt.color_bar("units"=>'m s\^{-1}')
#exit

#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0)
#tone u_anal.cut("xh"=>450000.0,"y"=>550000.0..800000.0)
#color_bar
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0)
#tone nil, true, "help"=>true
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0), "xcoord"=>"y" "ycoord"=>"z"
#tone nil, true, "help"=>true
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0), "annotate"=>false
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0).annotate(false)
#tone nil, true, "help"=>true
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0), true, "annotate"=>false
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0), true, "annotate"=>false, "xcoord"=>"y", "ycoord"=>"z"
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0), true, "annotate"=>false, true, "xcoord"=>"y", true, "ycoord"=>"z"
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0), true, "xcoord"=>"y"
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"xcoord"=>"y"), true, "annotate"=>false
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0), true, "annotate"=>false
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=0.0..15000.0), true, "annotate"=>false
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false
#color_bar
#GGraph.color_bar("help"=>true)
#color_bar(4)
#GGraph.map("help"=>true)
#GGraph.cmap("help"=>true)
#startup_options
#startup_options("colormap")
#startup_options("help"=>)
#startup_options("help"=>true)
#GGraph.startup_options("help"=>true)
#color_bar("colormap"=>4)
#GGraph.color_bar("colormap"=>4)
#DCL.sgscmn(4)
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false
#color_bar
#tone nil, true, "help"=>true
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "xcoord"=>"y" 
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "xcoord"=>"z" 
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "xcoord"=>"y" 
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "ycoord"=>"z"
#tone nil, true, "help"=>true
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "xcoord"=>"Y-axis"
#tone nil, true, "help"=>true
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "clr_max"=>55, "clr_min"=>95
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "clr_max"=>55, "clr_min"=>15
#color_bar
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "clr_max"=>56, "clr_min"=>15
#color_bar
#ubar=GPhys::IO.open_multi(`ls ../mean/gues.d01_20180926-120000.000.pe0000*`.split("\n"),aval)
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "clr_max"=>56, "clr_min"=>15
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true
#contour nil, true, "help"=>true
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "index"=>24
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "clr_max"=>56, "clr_min"=>15
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "index"=>24
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "index"=>[24]
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "index"=>24
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "index"=>34
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "index"=>44
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "line_type"=>44
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "line_type"=>1
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "index"=>44
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "index"=>4
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "index"=>2
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "index"=>24000
#contour nil, true, "help"=>true
#contour nil, true, "help"=>true
#GPhys::contour nil, true, "help"=>true
#GGraph.contour nil, true, "help"=>true
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "levels"=>[-40.0,-20.0,0.0,20.0,40.0], "index"=>[24,24,24,24,24]
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "levels"=>[-40.0,-20.0,0.0,20.0,40.0], "index"=>[24,24,24,24,24], "line_type"=>[2,2,1,1,1]
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "levels"=>[-40.0,-20.0,0.0,20.0,40.0], "index"=>[24,24,24,24,24], "line_type"=>[2,2,1,1,1], "label"=>true
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "clr_max"=>56, "clr_min"=>[15]
#tone du.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), true, "annotate"=>false, "transpose"=>true, "clr_max"=>56, "clr_min"=>15
#contour ubar.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "levels"=>[-40.0,-20.0,0.0,20.0,40.0], "index"=>[24,24,24,24,24], "line_type"=>[2,2,1,1,1], "label"=>true
#contour u_anal.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "levels"=>[-10.0,-5.0,2.0,0.0,2.0,5.0,10.0], "index"=>[54,54,54,54,54,54,54], "line_type"=>[2,2,2,1,1,1,1], "label"=>true
#color_bar
DCL.grcls
