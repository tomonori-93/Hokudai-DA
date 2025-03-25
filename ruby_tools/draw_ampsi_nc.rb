#!/home/z44533r/usr/local/CL_intel/bin/ruby
# Drawing R-Z figure for AAM and Psi

require "~/irbrc_ggraph.rb"

if ARGV.size < 2 then
   puts "[USAGE]: ruby draw_amvt_nc.rb amfile psifile"
   exit
end

amfile = ARGV[0]
#amfile = "1_output/1h_eye+upper/.ubar_budget/hist.dmp_20180927-120000.bin.dat.nc"
psifile = ARGV[1]
#psifile = "1_output/1h_eye+upper/.vt/hist.dmp_20180927-120000.bin.dat.nc"
amval = "am"
psival = "psi"

#-- analysis part
val1 = GPhys::IO.open(amfile,amval)
val1 = val1 * 1.0e-6
val2 = GPhys::IO.open(psifile,psival)
val2 = val2 * 1.0e-9

#-- drawing part
DCL.swpset('ldump',true)
DCL.sgiset( 'ifont', 1 )
DCL.swlset( 'lsysfnt', true )
DCL.gropn(2)  # 1: PNG, 2: PDF (Not working)
DCL.swcset('fontname', 'Nimbus Sans 12')
DCL.sgscmn(4)

tnum = val1.axis(2).length.to_i  # 時間方向データ数 (アンサンブル数) 取得

for i in 1..tnum
   set_fig "viewport"=>[0.1,0.9,0.3,0.7]
   #tone du.cut("z"=>1000.0,"xh"=>300000.0..550000.0,"y"=>550000.0..800000.0)
#   tone val1.cut("r"=>0.0..200000.0,"z"=>0.0..17000.0,"t"=>i), true, "annotate"=>true, "transpose"=>false, "clr_max"=>95, "clr_min"=>15, "levels" => [0.0,0.5,1.0,1.5,2.0,3.0,4.0,5.0,6.0,8.0,10.0]
   tone val1.cut("r"=>0.0..100000.0,"z"=>0.0..17000.0,"t"=>i), true, "annotate"=>true, "transpose"=>false, "clr_max"=>95, "clr_min"=>15, "levels" => [0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5,5.0]
#   contour val2.cut("r"=>0.0..200000.0,"z"=>0.0..17000.0,"t"=>i), false, "annotate"=>false, "transpose"=>false, "levels"=>[0.0,0.5,1.0,1.5,2.0,2.5,3.0,3.5,4.0,4.5], "index"=>[34,32,34,32,34,32,34,32,34,32], "line_type"=>[1,1,1,1,1,1,1,1,1,1], "label"=>true
   contour val2.cut("r"=>0.0..100000.0,"z"=>0.0..17000.0,"t"=>i), false, "annotate"=>false, "transpose"=>false, "levels"=>[0.0,0.1,0.2,0.3,0.4,0.5,0.6,0.7,0.8,0.9,1.0], "index"=>[14,12,12,12,12,14,12,12,12,12,14], "line_type"=>[1,1,1,1,1,1,1,1,1,1,1], "label"=>true
   #contour u_mean.cut("xh"=>450000.0,"y"=>550000.0..800000.0,"z"=>0.0..15000.0), false, "annotate"=>false, "transpose"=>true, "levels"=>[-40.0,-20.0,0.0,20.0,40.0], "index"=>[56,53,51,53,56], "line_type"=>[2,2,2,1,1,1,1], "label"=>true
   DCLExt.color_bar("units"=>'(x10\^{6} m\^{2} s\^{-1})',"landscape"=>true)
#exit
end

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
