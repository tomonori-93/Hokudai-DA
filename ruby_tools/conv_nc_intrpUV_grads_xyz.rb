#!/home/z44533r/usr/local/CL_intel/bin/ruby
# [USAGE]: ruby draw_sprd.rb

require "~/irbrc_ggraph.rb"

####### setting variables #########
rhoc = "DENS"
ivals = ["MOMX", "MOMY", "RHOT"]
ovals = ["U", "V", "PT"]
majax = [["xh","y"], ["x","yh"], ["x","y"]]  # orig ax for MOMX, MOMY, RHOT
itpax = ["x", "y", "z"]  # interpolated ax for all variables
#ifile = "../exp/testcase_1h_eye_A02/mean_ruby/mean_anal_20180926-120000.00000000.nc"  # ORG
ifile = ARGV[0]
ofile = ifile[0..-4] + ".bin"  #<- .nc を .bin に変換して出力
####### setting variables #########

addax2_var = VArray.new( NArray.float(1), {"long_name"=>"time", "units" => "hours since 2018-09-26 00:00:00"}, "time")
t_ax = Axis.new().set_pos(addax2_var)

bin_val = Array.new(ovals.size)

#-- analysis part
if File.exist?("#{ofile}")
   system("rm #{ofile}")
   print("rm #{ofile} \n")
end

for j in 0..ovals.size-1
   if File.exist?("#{ofile}-tmp.#{ovals[j]}")
      system("rm #{ofile}-tmp.#{ovals[j]} #{ofile}-tmp.#{ovals[j]}.dat")
      print("rm #{ofile}-tmp.#{ovals[j]} #{ofile}-tmp.#{ovals[j]}.dat\n")
   end
end

# define the interpolated axes
dens = GPhys::IO.open(ifile,rhoc)
x_ref = dens.coord(itpax[0])
y_ref = dens.coord(itpax[1])
x_ax = dens.axis(itpax[0])
y_ax = dens.axis(itpax[1])
z_ax = dens.axis(itpax[2])

# Interpolation for u
uxrho = GPhys::NetCDF_IO.open(ifile,ivals[0]).copy  # copy により, メモリ上に NetCDF データを読み込み (gphys オブジェクト uxrho への書き込みを可能にする.)
# 以下, uxrho の補間座標の次元名 ("xh": VArray.name) を dens ("x") と一致させるための処理, ただし座標値は半格子ずれている.
uxrho.axis(majax[0][0]).pos.name = itpax[0]  # 1. uxrho の Axis オブジェクトの格子点情報 VArray の名称を xh -> x へ.
x_origax = uxrho.grid_copy  # 2. uxrho の Grid オブジェクトを新しく x_origax にコピー
uxrho = GPhys.new( x_origax, uxrho.data )  # 3. uxrho を新しい Grid オブジェクトで更新
p  uxrho.axnames, uxrho.axis(1), x_origax
u_itp = uxrho.interpolate(x_ref) / dens
u_itp.name = ovals[0]

# Interpolation for v
vxrho = GPhys::NetCDF_IO.open(ifile,ivals[1]).copy
# uxrho と同様の置き換え
vxrho.axis(majax[1][1]).pos.name = itpax[1]  # 1. vxrho の Axis オブジェクトの格子点情報 VArray の名称を xh -> x へ.
y_origax = vxrho.grid_copy  # 2. vxrho の Grid オブジェクトを新しく x_origax にコピー
vxrho = GPhys.new( y_origax, vxrho.data )  # 3. vxrho を新しい Grid オブジェクトで更新
v_itp = vxrho.interpolate(y_ref) / dens
v_itp.name = ovals[1]

# Interpolation for pt
# pt は dens と同じ座標系なので, 単純な割り算
ptxrho = GPhys::NetCDF_IO.open(ifile,ivals[2]).copy
pt_itp = ptxrho / dens
pt_itp.name = ovals[2]

grid = Grid.new( x_ax[2..-3], y_ax[2..-3], z_ax, t_ax )

# Make GrADS file for u
u_var = VArray.new( NArrayMiss.float(x_ax[2..-3].length,y_ax[2..-3].length,z_ax.length,t_ax.length).fill(0.0), {"long_name" => u_itp.get_att("long_name"), "units" => u_itp.get_att("units")}, u_itp.name )
for i in 0..z_ax.length-1
   u_var[0..x_ax[2..-3].length-1,0..y_ax[2..-3].length-1,i,0] = u_itp.val[i,2..-3,2..-3]
end
u_out = GPhys.new( grid, u_var )
GPhys::GrADS_IO.write("#{ofile}-tmp.#{ovals[0]}",u_out,name=ovals[0])

# Make GrADS file for v
v_var = VArray.new( NArrayMiss.float(x_ax[2..-3].length,y_ax[2..-3].length,z_ax.length,t_ax.length).fill(0.0), {"long_name" => v_itp.get_att("long_name"), "units" => v_itp.get_att("units")}, v_itp.name )
for i in 0..z_ax.length-1
   v_var[0..x_ax[2..-3].length-1,0..y_ax[2..-3].length-1,i,0] = v_itp.val[i,2..-3,2..-3]
end
v_out = GPhys.new( grid, v_var )
GPhys::GrADS_IO.write("#{ofile}-tmp.#{ovals[1]}",v_out,name=ovals[1])

# Make GrADS file for pt
pt_var = VArray.new( NArrayMiss.float(x_ax[2..-3].length,y_ax[2..-3].length,z_ax.length,t_ax.length).fill(0.0), {"long_name" => pt_itp.get_att("long_name"), "units" => pt_itp.get_att("units")}, pt_itp.name )
for i in 0..z_ax.length-1
   pt_var[0..x_ax[2..-3].length-1,0..y_ax[2..-3].length-1,i,0] = pt_itp.val[i,2..-3,2..-3]
end
v_out = GPhys.new( grid, pt_var )
GPhys::GrADS_IO.write("#{ofile}-tmp.#{ovals[2]}",v_out,name=ovals[2])

# Couple all GrADS files
twsize = 0
for j in 0..ovals.size-1
   fbin = open("#{ofile}-tmp.#{ovals[j]}.dat", "rb")
   fsize = File.size("#{ofile}-tmp.#{ovals[j]}.dat")
   m = fbin.read(fsize)
   wsize = fsize / 8  # = word size
   twsize = twsize + wsize
   bin_val[j] = m.unpack("E#{wsize.to_s}")  # E = little endian 64bit
   puts bin_val[j][0]
   fbin.close
   system("rm #{ofile}-tmp.#{ovals[j]} #{ofile}-tmp.#{ovals[j]}.dat")
   print("rm #{ofile}-tmp.#{ovals[j]} #{ofile}-tmp.#{ovals[j]}.dat\n")
end
obin = open(ofile,"wb")
#obin = open("#{ens_dir}/#{outfile}.dat","wb")
obin.write(bin_val.flatten.pack("g#{twsize.to_s}"))  # g = big endian 32bit
obin.close

puts "Output #{ofile}"

