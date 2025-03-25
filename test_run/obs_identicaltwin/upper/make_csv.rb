#!/usr/bin/ruby
# [USAGE]: ruby make_csv.rb


tcenter = "../GEO.grd.tcenter"
lskip = 2  # tcenter ヘッダ部の行数
flist = ["obs_2018092600.csv", "obs_2018092601.csv", "obs_2018092602.csv", "obs_2018092603.csv", "obs_2018092604.csv", "obs_2018092605.csv", "obs_2018092606.csv", "obs_2018092607.csv", "obs_2018092608.csv", "obs_2018092609.csv", "obs_2018092610.csv", "obs_2018092611.csv", "obs_2018092612.csv", "obs_2018092613.csv", "obs_2018092614.csv", "obs_2018092615.csv", "obs_2018092616.csv", "obs_2018092617.csv", "obs_2018092618.csv", "obs_2018092619.csv", "obs_2018092620.csv", "obs_2018092621.csv", "obs_2018092622.csv", "obs_2018092623.csv", "obs_2018092700.csv", "obs_2018092701.csv", "obs_2018092702.csv", "obs_2018092703.csv", "obs_2018092704.csv", "obs_2018092705.csv", "obs_2018092706.csv", "obs_2018092707.csv", "obs_2018092708.csv", "obs_2018092709.csv", "obs_2018092710.csv", "obs_2018092711.csv", "obs_2018092712.csv", "obs_2018092713.csv", "obs_2018092714.csv", "obs_2018092715.csv", "obs_2018092716.csv", "obs_2018092717.csv", "obs_2018092718.csv", "obs_2018092719.csv", "obs_2018092720.csv", "obs_2018092721.csv", "obs_2018092722.csv", "obs_2018092723.csv", "obs_2018092800.csv"]
fstep = [1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, 49] # 各 flist は tcenter の何列目の時刻に対応するか

tcont = open(tcenter,"r").read.split("\n")

for i in 0..flist.size-1

   ifile = flist[i]
   step = fstep[i]

   icont = open(ifile,"r").read.split("\n")

   ocont = ""
   otime = tcont[(step-1)+lskip][2..17]
   oll = tcont[(step-1)+lskip][8*16..10*16]

   for j in 0..icont.size-1
      tmpc = icont[j]
      ocont = ocont + tmpc[0..3] + oll + tmpc[37..-17] + otime + "\n"
   end

   ofile = ifile + ".autout"
   ofcont = open(ofile,"w")
   ofcont.write(ocont[0..-2])
   ofcont.close

   puts "Output #{ofile}."

end
