#!/usr/bin/ruby
# 1 時刻の全アンサンブルメンバーの台風中心位置情報を記録したテキストファイルから
# 各メンバーの指定時刻の台風中心位置情報を記録したテキストファイルに
# 変換するスクリプト.

require 'optparse'

memf = 30  # アンサンブルメンバー数
lskip = 2  # 入力ファイルのヘッダ読み飛ばし行数
onechar = 16  # 1 配列要素の文字数 (1PE16.8 なら 16)

#-- analysis main argument
if ARGV.size <= 2 then
   puts "[USAGE]: ruby conv_tcentertxt_mem2tim.rb --files --times wkdir outfilename"
   exit
end
wkdir = ARGV[-2]
outfile = ARGV[-1]

#-- OptParse part (https://qiita.com/kaz-uen/items/5ce9e5272e7792a81ae0)
# 1. define
options = {}  # define a hash
opt = OptionParser.new  # define OptionParser class

# 2. define each option
opt.on("--files=VAL", "--files VAL", "file names"){|f| options[:files] = f}
opt.on("--times=VAL", "--times VAL", "time steps"){|t| options[:times] = t}

# 3. analysis options
opt.parse(ARGV)

# 4. define variables from options
time_steps = options[:times].split(",") if options[:times]
file_names = options[:files].split(",") if options[:files]

nt = time_steps.size
outdir = Array.new(memf)
ficont = Array.new(nt)

for tim in 0..nt-1
   ficont[tim] = open(file_names[tim],"r").read.split("\n")
end
for i in 1..memf
   ocont = ficont[0][0..lskip-1].join("\n") + "\n"  # ヘッダ行を出力
   for tim in 0..nt-1
      # ファイルの第 1 列からメンバー数番号を取得
      repl_mem2tim = ficont[tim][lskip+(i-1)][0..onechar-1].to_f.to_i  # 実数文字列なので, 実数にしてから整数にする.
      if repl_mem2tim != i then
         puts "Warning: Expected array might be different from the ensemble member."
      end
      # メンバー数番号から相対時刻値に置き換え
      ficont[tim][lskip+(i-1)][0..onechar-1] = sprintf("%16.8e",time_steps[tim].to_f)
      ocont = ocont + ficont[tim][lskip+(i-1)] + "\n"
   end
   outdir[i] = i.to_s.rjust(8,"0")
   ofname = "#{wkdir}/#{outdir[i]}/#{outfile}"
   focont = open(ofname,"w")
   focont.write(ocont[0..-2])
   focont.close
   puts "Output: #{ofname}..."
end
