#!/usr/bin/ruby
# 各アンサンブルメンバーの各時刻での中心位置と True の中心位置を
# 水平分布図に点として描画するための tcenter_sub (dcl_sfc_map_mean*.nml で使用)
# を自動作成するスクリプト
# アンサンブルの時刻に対応する True の中心位置がなければ追加せずに
# アンサンブルメンバーのみで tcenter_sub を作成する.

if ARGV.size != 4 then
   puts "[USAGE]: ruby couple_tcenter_sub.rb ens_tcenter true_tcenter true_time out_file"
   exit
end

ens_tcenter  = ARGV[0]
true_tcenter = ARGV[1]
true_time    = ARGV[2]
out_file     = ARGV[3]

#itclon = 8  # lon
#itclat = 9  # lat
itclon = 6  # X
itclat = 7  # Y
itctim = 0
st_rel_opt = true  # true_tcenter から相対的な位置で出力する (true)

#-- true_tcenter からデータを抽出し, 列を入れ替えて out_file に追記
f_true = open(true_tcenter,"r").read.split("\n")
cres = ""
ref_lon = 0.0
ref_lat = 0.0

for i in 2..f_true.size-1
   ctmp = f_true[i].split
   ttime = ctmp[0].to_f.to_i
   if ttime == true_time.to_i then
      clon = ctmp[itclon]  # tclon
      clat = ctmp[itclat]  # tclat
      ctim = ctmp[itctim]  # tctim
      if st_rel_opt == true then
         ref_lon = clon.to_f
         ref_lat = clat.to_f
         clon = sprintf("%16.8E", 0.0)
         clat = sprintf("%16.8E", 0.0)
      end
      ctmp[3..9] = ctmp[1..7]
      ctmp[0..2] = [clon, clat, ctim + " 44 16 0.01"]
      cres = cres + ctmp.join("  ") + "\n"
      break
   end
   if i == f_true.size-1 then
      puts "*** MESSAGE (main) ***: true TC center is not found."
   end
end

#-- ens_tcenter からデータを入力し, 列を入れ替え
f_ens = open(ens_tcenter,"r").read.split("\n")
for i in 2..f_ens.size-1
   ctmp = f_ens[i].split
   clon = ctmp[itclon]  # tclon
   clat = ctmp[itclat]  # tclat
   ctim = ctmp[itctim]  # tctim
   if st_rel_opt == true then
      clon = sprintf("%16.8E", (clon.to_f - ref_lon))
      clat = sprintf("%16.8E", (clat.to_f - ref_lat))
   end
   ctmp[3..9] = ctmp[1..7]
   ctmp[0..2] = [clon, clat, ctim + " 14  1 0.01"]
   cres = cres + ctmp.join("  ") + "\n"
end

f_out = open(out_file,"w")
f_out.write(cres[0..-2])
f_out.close

puts "Output #{out_file}. Finish."
