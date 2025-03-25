#!/home/z44533r/usr/local/CL_intel/bin/ruby
# [USAGE]: ruby draw_sprd.rb

require "~/irbrc_ggraph.rb"
require 'optparse'

#-- analysis main argument
main_arg = ARGV[-1]
ncf_in = main_arg.split("@")[0]  # NetCDF file name
ncf_opt = main_arg.split("@")[1]  # Drawing ranges after "@"
val_in = ncf_opt.split(",")  # varname, axesname
if val_in.size > 1 then
   ax_in = val_in[1..-1]
else
   ax_in = ""
end

#-- read variables
val_gp = GPhys::IO.open(ncf_in,val_in[0])

#-- OptParse part (https://qiita.com/kaz-uen/items/5ce9e5272e7792a81ae0)
# 1. define
options = {}  # define a hash
opt = OptionParser.new  # define OptionParser class

# 2. define each option
opt.on("--anim=VAL", "--anim VAL", "time varname"){|a| options[:anim] = a}
opt.on("--wsn=VAL", "--wsn VAL", "windows number"){|w| options[:wsn] = w}
opt.on("--clrmap=VAL", "--clrmap VAL", Integer, "color map"){|clr| options[:clrmap] = clr}
opt.on("--levels=VAL", "--levels VAL", "contour levels"){|clev| options[:levels] = clev}
opt.on("--patterns=VAL", "--patterns VAL", "shade patterns"){|slev| options[:patterns] = slev}
opt.on("--aspect=VAL", "--aspect VAL", Float, "aspect ratio"){|asp| options[:aspect] = asp}
opt.on("--units=VAL", "--units VAL", "variable unit"){|uni| options[:units] = uni}

# 3. analysis options
opt.parse(ARGV)

# 4. define variables from options
time_opt = ""
time_opt = options[:anim] if options[:anim]
wsn_opt = 1
wsn_opt = options[:wsn] if options[:wsn]
clr_opt = 1
clr_opt = options[:clrmap] if options[:clrmap]
clev_opt = options[:levels] if options[:levels]
slev_opt = options[:patterns] if options[:patterns]
asp_opt = 2.0
asp_opt = options[:aspect] if options[:aspect]
uni_opt = val_gp.get_att("units")
uni_opt = options[:units] if options[:units]

#-- Convert units (m -> km)
for i in 0..val_gp.rank-1
   if val_gp.axis(i).pos.get_att("units") == "m" then
      prev_uni = val_gp.axis(i).pos
      post_uni = prev_uni.convert_units("km")
      val_gp.axis(i).set_pos(post_uni)
   end
end

#-- analysis drawing range
val_min = NArray.new(Float,val_gp.rank)
val_max = NArray.new(Float,val_gp.rank)
for i in 0..val_gp.rank-1  # Set default values
   val_min[i] = val_gp.axis(i).pos.val[0]
   val_max[i] = val_gp.axis(i).pos.val[-1]
end
if ax_in.size != 0  # Replace the default values with options
   for j in 0..ax_in.size-1
      axname,axrange = ax_in[j].split("=")
      for i in 0..val_gp.rank-1
         if val_gp.axis(i).name == axname then
            if axrange.include?(":") == true then
               if axrange[0] == "^"  # specifying grid number
                  aximin,aximax = axrange.gsub("^","").split(":")
                  val_min[i] = val_gp.axis(i).pos.val[aximin.to_i]
                  val_max[i] = val_gp.axis(i).pos.val[aximax.to_i]
               else
                  val_min[i],val_max[i] = axrange.split(":").map{|b| b.to_f}
               end
            else
               if axrange[0] == "^"  # specifying grid number
                  aximin = axrange.gsub("^","")
                  val_min[i] = val_gp.axis(i).pos.val[aximin.to_i]
               else
                  val_min[i] = axrange.to_f
               end
               val_max[i] = val_min[i]
            end
         end
      end
   end
end

#-- drawing part
#DCL.swpset('ldump',true)
DCL.sgiset( 'ifont', 1 )
DCL.swlset( 'lsysfnt', true )
DCL.gropn(wsn_opt)  # 1: PNG, 2: PDF (Not working)
DCL.swcset('fontname', 'Nimbus Sans 12')
DCL.sgscmn(clr_opt)
DCL.udlset('lmsg', false)

clev = clev_opt.split(",").map{|b| b.to_f}
slev = slev_opt.split(",").map{|b| b.to_i}

if time_opt != "" then
   for it in 0..val_gp.axis(-1).pos.val.size-1
      tmp_time = val_gp.axis(-1).pos.val[it]
      if tmp_time >= val_min[-1] && tmp_time <= val_max[-1] then
         tone val_gp.cut(val_gp.axis(0).name=>val_min[0]..val_max[0],val_gp.axis(1).name=>val_min[1]..val_max[1],val_gp.axis(-1).name=>tmp_time), true, "annotate"=>false, "transpose"=>false, "levels"=>clev, "patterns"=>slev
         contour val_gp.cut(val_gp.axis(0).name=>val_min[0]..val_max[0],val_gp.axis(1).name=>val_min[1]..val_max[1],val_gp.axis(-1).name=>tmp_time), false, "annotate"=>false, "transpose"=>false, "levels"=>clev, "index"=>1, "line_type"=>1, "label"=>true
         vxmin,vxmax,vymin,vymax = DCL.sgqvpt()
         DCL.sgtxzv(vxmax+0.01,vymax+0.01,val_gp.axis(-1).name+"= "+tmp_time.to_i.to_s+val_gp.axis(-1).pos.get_att("units"),0.015,0,-1,12)
         DCLExt.color_bar("units"=>uni_opt)
      end
   end
else
   if val_min[-1] == val_max[-1] then  # one time step
      tone val_gp.cut(val_gp.axis(0).name=>val_min[0]..val_max[0],val_gp.axis(1).name=>val_min[1]..val_max[1],val_gp.axis(-1).name=>val_min[-1]), true, "annotate"=>false, "transpose"=>false, "levels"=>clev, "patterns"=>slev
      contour val_gp.cut(val_gp.axis(0).name=>val_min[0]..val_max[0],val_gp.axis(1).name=>val_min[1]..val_max[1],val_gp.axis(-1).name=>val_min[-1]), false, "annotate"=>false, "transpose"=>false, "levels"=>clev, "index"=>1, "line_type"=>1, "label"=>true
   else  # time series
      tone val_gp.cut(val_gp.axis(0).name=>val_min[0]..val_max[0],val_gp.axis(1).name=>val_min[1]..val_max[1],val_gp.axis(-1).name=>val_min[-1]..val_max[-1]), true, "annotate"=>false, "transpose"=>false, "levels"=>clev, "patterns"=>slev
      contour val_gp.cut(val_gp.axis(0).name=>val_min[0]..val_max[0],val_gp.axis(1).name=>val_min[1]..val_max[1],val_gp.axis(-1).name=>val_min[-1]..val_max[-1]), false, "annotate"=>false, "transpose"=>false, "levels"=>clev, "index"=>1, "line_type"=>1, "label"=>true
   end
   DCLExt.color_bar("units"=>uni_opt)
end

DCL.grcls
