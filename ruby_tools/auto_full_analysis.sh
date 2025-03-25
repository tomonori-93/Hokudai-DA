#!/usr/bin/bash
# 解析のための基礎データ作成を行う一式のスクリプト
# cycle_FX1000.sh の終了後に実行する.

set -uvx
#------------- 環境設定 ---------------
ruby_=~/usr/local/CL_intel/bin/ruby
expname=$1  # 実験名 (testcase_ 抜き)
#expname=1h_eye_identicaltwin_UV  # 実験名 (testcase_ 抜き)
expdir=../exp/                       # pwd から見た実験結果のディレクトリの相対パス
wkdir=1_output/${expname}
wk_expdir=../../../exp/              # wkdir から見た実験結果のディレクトリ相対パス
frdir=1_output/48h                   # フリーランのディレクトリ
nr_dir=../obs_identicaltwin_UV/      # pwd から見た Nature run (nc) データのディレクトリ相対パス
wk_nr_dir=../../../obs_identicaltwin_UV/   # wkdir から見た Nature run (nc) データのディレクトリ相対パス
nr_file=("UV_.vt.grd.nc" "UV_.vr.grd.nc")  # Nature run のファイル名
nr_vars=("vt" "vr")                        # Nature run の変数名
ininame_yyyymm=201809
ininame_dd=26
ininame_hh=00
hist_geo_orig=../48h.org/hist.geo_20180926-000000.bin.dat
# (上): モデルの tcenter/asuca_z データ (テキスト) のコピー元 (wkdir から相対パス)
bst_geo_orig=GEO.grd
# (上): Nature run の tcenter/asuca_z データ (テキスト) のコピー元ファイル名
bst_geo_name=bst_T1824_identicaltwin_tot.dat
# (上): bst_geo_orig のコピー先ファイル名
tint=("26-00" "26-06" "26-12" "26-18" "27-00" "27-06" "27-12" "27-18" "28-00")  # 解析処理を行う時刻 (dd-hh)
tint_sec=("00000000" "00021600" "00043200" "00064800" "00086400" "00108000" "00129600" "00151200" "00172800")  # tint に対応する sec
#-- 描画に関すること
rrange=200000.0  # 動径方向描画範囲
zrange=20000.0   # 鉛直方向描画範囲
draw_vars=("vt" "vr" "w")
draw_levels=("0.0,10.0,20.0,30.0,40.0,50.0,60.0,70.0" \
             "-8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0" \
             "0.0,0.1,0.3,0.5,0.7,0.9")
draw_patterns=("55999,60999,65999,70999,78999,85999,90999,95999" \
               "15999,25999,35999,40999,50999,60999,70999,75999,85999,95999" \
               "50999,55999,60999,70999,77999,84999,95999")
ddraw_vars=("vt" "vr")  # 差分変数名は各コマンド行で適宜先頭に d をつける
ddraw_levels=("-15.0,-12.5,-10.0,-7.5,-5.0,-2.5,0.0,2.5,5.0,7.5,10.0,12.5,15.0" \
              "-8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0")
ddraw_patterns=("12999,20555,27999,32999,37999,42999,50999,62999,70999,73999,76999,81999,86999,93999" \
                "15999,25999,35999,40999,50999,60999,70999,75999,85999,95999")
idraw_vars=("vt" "vr")  # インクリメント変数名は各コマンド行で適宜先頭に d をつける
idraw_levels=("-1.5,-1.0,-0.75,-0.5,-0.25,0.0,0.25,0.5,0.75,1.0,1.5" \
              "-1.5,-1.0,-0.75,-0.5,-0.25,0.0,0.25,0.5,0.75,1.0,1.5")
idraw_patterns=("12999,20555,32999,37999,42999,50999,62999,70999,73999,76999,86999,93999" \
                "12999,20555,32999,37999,42999,50999,62999,70999,73999,76999,86999,93999")
#------------- 環境設定 ---------------

ulimit -s unlimited
export OMP_NUM_THREADS=1
module load intel netcdf netcdf-fortran

dbg=2
if [ ${dbg} -eq 0 ]; then

#-- ruby_tools/1_output 内に作業環境構築
pwd_=`pwd`
if [ -e ${wkdir} ]; then
   echo "Directory is found ${wkdir}"
   echo "Stop"
   exit
fi
rm -r ${expdir}/testcase_${expname}/mean_ruby
mkdir ${expdir}/testcase_${expname}/mean_ruby
mkdir ${wkdir}  # 新規作業ディレクトリ作成
mkdir ${wkdir}/.{vr,vt,w,p,pt}  # 新規作業ディレクトリ作成
cd    ${wkdir}  # ディレクトリ移動
# 実験結果ディレクトリからデータリンク
ln -s ${wk_expdir}/testcase_${expname}/0* ./
for i in 0*
do
   mv -i $i 0000$i
done
ln -s ${wk_expdir}/testcase_${expname}/mean ./
ln -s ${wk_expdir}/testcase_${expname}/mean_ruby ./
ln -s 00000001/hist.geo_${ininame_yyyymm}${ininame_dd}-${ininame_hh}0000.bin.dat
cp ${hist_geo_orig}.asuca_z hist.geo_${ininame_yyyymm}${ininame_dd}-${ininame_hh}0000.bin.dat.asuca_z
ln -s ${wk_nr_dir}/${bst_geo_orig}.asuca_z ${bst_geo_name}.asuca_z
ln -s ${wk_nr_dir}/${bst_geo_orig}.tcenter ${bst_geo_name}.tcenter
for tim in ${tint[@]}; do
   ln -s hist.geo_${ininame_yyyymm}${ininame_dd}-${ininame_hh}0000.bin.dat hist.geo_${ininame_yyyymm}${tim}0000.bin.dat
   ln -s hist.geo_${ininame_yyyymm}${ininame_dd}-${ininame_hh}0000.bin.dat.asuca_z hist.geo_${ininame_yyyymm}${tim}0000.bin.dat.asuca_z
done

cd $pwd_  # ディレクトリ移動

#---------- ここからは並列実行で問題ない -----------
#-- geo 出力
$ruby_ conv_ncmulti_grads_xy.rb ${expdir}/testcase_${expname}/ hist.d01_${ininame_yyyymm}${ininame_dd}-${ininame_hh}0000.000.pe00 hist.geo_${ininame_yyyymm}${ininame_dd}-${ininame_hh}0000.bin &

#-- mslp 出力
for tim in ${tint[@]}; do
   $ruby_ conv_ncmulti_grads_xyt.rb ${expdir}/testcase_${expname}/ hist.d01_${ininame_yyyymm}${tim}0000.000.pe00 hist.mslp_${ininame_yyyymm}${tim}0000.bin &
done

#-- dmp 出力
for tim in ${tint[@]}; do
   $ruby_ conv_ncmulti_grads_xyzt.rb ${expdir}/testcase_${expname}/ hist.d01_${ininame_yyyymm}${tim}0000.000.pe00 hist.dmp_${ininame_yyyymm}${tim}0000.bin &
done

#-- nc ファイルのアンサンブル平均
for i in ${!tint[@]}; do  # 要素番号でループする
   for mode in gues anal; do
      $ruby_ calc_ensmean_xyz.rb ${expdir}/testcase_${expname}/ ${mode}.d01_${ininame_yyyymm}${tint[$i]}0000.000.pe00 ${expdir}/testcase_${expname}/mean_ruby/mean_${mode}_${ininame_yyyymm}${tint[$i]}0000.${tint_sec[$i]}.nc &
   done
   $ruby_ calc_ensmean_xyzt.rb ${expdir}/testcase_${expname}/ hist.d01_${ininame_yyyymm}${tint[$i]}0000.000.pe00 ${expdir}/testcase_${expname}/mean_ruby/mean_dmp_${ininame_yyyymm}${tint[$i]}0000.${tint_sec[$i]}.nc &
done
#---------- ここまでは並列実行で問題ない -----------
wait  # 上のバックグラウンドプロセスを全て待つ

#---------- ここからは並列実行で問題ない -----------
#-- nc アンサンブル出力から anal/gues/dmp 出力
for i in ${!tint[@]}; do  # 要素番号でループする
   for mode in gues anal; do
      $ruby_ conv_nc_intrpUV_grads_xyz.rb ${expdir}/testcase_${expname}/mean_ruby/mean_${mode}_${ininame_yyyymm}${tint[$i]}0000.${tint_sec[$i]}.nc &
   done
   $ruby_ conv_nc_grads_xyz.rb ${wkdir}/mean_ruby/ mean_dmp_${ininame_yyyymm}${tint[$i]}0000.${tint_sec[$i]}.nc mean_dmp_${ininame_yyyymm}${tint[$i]}0000.${tint_sec[$i]}.bin &
done

#-- calc_TCenter 実行
nml=calc_TCenter.nml
for tim in ${tint[@]}; do
   dcl_nml_change.rb ${nml} hname "'${wkdir}/'"
   dcl_nml_change.rb ${nml} footname "'/hist.mslp_${ininame_yyyymm}"${tim}"0000.bin.dat'"
   dcl_nml_change.rb ${nml} grdname "'${wkdir}/hist.geo_${ininame_yyyymm}"${tim}"0000.bin.dat'"
   ./calc_TCenter < ${nml} &
   sleep 3
done
#---------- ここまでは並列実行で問題ない -----------
wait  # 上のバックグラウンドプロセスを全て待つ

#---------- ここからは並列実行で問題ない -----------
#-- calc_tangen_mean (hist.dmp) 実行
for j in 1 2 3 4; do
   nml=calc_tangen_mean_nc"$j".nml
   for tim in ${tint[@]}; do
      dcl_nml_change.rb ${nml} hname "'${wkdir}/'"
      dcl_nml_change.rb ${nml} footname "'/hist.dmp_${ininame_yyyymm}"${tim}"0000.bin.dat'"
      dcl_nml_change.rb ${nml} grdname "'${wkdir}/hist.geo_${ininame_yyyymm}"${tim}"0000.bin.dat'"
      ./calc_tangen_mean_nc < ${nml} &
      sleep 3
   done
done

#-- calc_tangen_mean (anal/gues/dmp) 実行
for j in 1 2; do
   for k in anal gues; do
      nml=calc_tangen_mean_nc_anal"$j".nml
      dcl_nml_change.rb ${nml} grdname "'${wkdir}/${bst_geo_name}'"
      for i in ${!tint[@]}; do  # 要素番号で実行
         dcl_nml_change.rb ${nml} hname "'${wkdir}/mean_ruby/mean_"$k"_"${ininame_yyyymm}""${tint[$i]}"0000.'"
         dcl_nml_change.rb ${nml} ininame ${tint_sec[$i]}
         dcl_nml_change.rb ${nml} footname "'.bin'"
         ./calc_tangen_mean_nc < ${nml} &
         sleep 3
      done
   done
   nml=calc_tangen_mean_nc_anal"$j".nml
   dcl_nml_change.rb ${nml} grdname "'${wkdir}/${bst_geo_name}'"
   for i in ${!tint[@]}; do  # 要素番号で実行
      dcl_nml_change.rb ${nml} hname "'${wkdir}/mean_ruby/mean_dmp_"${ininame_yyyymm}""${tint[$i]}"0000.'"
      dcl_nml_change.rb ${nml} ininame ${tint_sec[$i]}
      dcl_nml_change.rb ${nml} footname "'.bin'"
      ./calc_tangen_mean_nc < ${nml} &
      sleep 3
   done
done

#-- make_rot/div 実行
nml=make_rot_div_3d.nml
for k in anal gues; do
   for i in ${!tint[@]}; do  # 要素番号で実行
      dcl_nml_change.rb ${nml} hname "'${wkdir}/mean_ruby/mean_"$k"_"${ininame_yyyymm}""${tint[$i]}"0000.'"
      dcl_nml_change.rb ${nml} ininame ${tint_sec[$i]}
      ./make_rot_div_3d < ${nml} &
      sleep 3
   done
done

#-- 描画用の tcenter_sub ファイル作成
for k in anal gues; do
   for i in ${!tint[@]}; do  # 要素番号で実行
      ruby couple_tcenter_sub.rb ${wkdir}/hist.geo_${ininame_yyyymm}${tint[$i]}0000.bin.dat.tcenter ${wkdir}/${bst_geo_name}.tcenter ${tint_sec[$i]} ${wkdir}/mean_ruby/mean_"$k"_${ininame_yyyymm}${tint[$i]}0000.${tint_sec[$i]}.bin.tcenter_sub
   done
done
#---------- ここまでは並列実行で問題ない -----------
wait  # 上のバックグラウンドプロセスを全て待つ

#--------------- ここからは逐次実行 ----------------
#-- Nature run と anal (Nature run 中心のアンサンブル平均) 差作成
for i in ${!nr_vars[@]}; do
   for j in ${!tint[@]}; do
      $ruby_ make_nc_obs_diff.rb ${nr_dir}/${nr_file[$i]} ${wkdir}/mean_ruby/mean_anal_${ininame_yyyymm}${tint[$j]}0000..${nr_vars[$i]}.bin.nc ${nr_vars[$i]} ${wkdir}/mean_ruby/mean_anal_${ininame_yyyymm}${tint[$j]}0000..${nr_vars[$i]}.bin_obsdiff.nc ${expname} ${tint_sec[$j]}
   done
done

#-- anal - gues (解析インクリメント) 作成 (nc & grads)
for var in rot div; do  # grads
   for j in ${!tint[@]}; do
      bash make_diff_grads.sh ${wkdir}/mean_ruby/mean_anal_${ininame_yyyymm}${tint[$j]}0000.${tint_sec[$j]}.bin.${var} ${wkdir}/mean_ruby/mean_gues_${ininame_yyyymm}${tint[$j]}0000.${tint_sec[$j]}.bin.${var} ${wkdir}/mean_ruby/mean_anal_${ininame_yyyymm}${tint[$j]}0000.${tint_sec[$j]}.bin.${var}_diff
   done
done

for var in ${nr_vars[@]}; do  # nc
   for tim in ${tint[@]}; do
      bash make_diff_nc.sh ${wkdir}/mean_ruby/mean_anal_${ininame_yyyymm}${tim}0000..${var}.bin.nc ${wkdir}/mean_ruby/mean_gues_${ininame_yyyymm}${tim}0000..${var}.bin.nc ${wkdir}/mean_ruby/mean_anal_${ininame_yyyymm}${tim}0000..${var}.bin_diff.nc ${var} "difference of ${var} between anal and gues" "m s-1"
   done
done

#-- hist.dmp アンサンブル平均 (中心軸は各メンバーの台風中心)
for var in vt vr w p pt; do
   for tim in ${tint[@]}; do
      move_ave_nc ${wkdir}/.${var}/hist.dmp_${ininame_yyyymm}${tim}0000.bin.dat.nc 3 'r' 'z' 't' 't' 30 1 -999.0 ${var}
   done
done

#-- hist.dmp アンサンブル平均の DA-FR 差 (中心軸は各メンバーの台風中心)
for var in vt vr w; do
   for tim in ${tint[@]}; do
      fDA=${wkdir}/.${var}/hist.dmp_${ininame_yyyymm}${tim}0000.bin.dat_Moveave.nc
      fFR=${frdir}/.${var}/hist.dmp_${ininame_yyyymm}${tim}0000.bin.dat_Moveave.nc
      fdiff=${wkdir}/.${var}/hist.dmp_${ininame_yyyymm}${tim}0000.bin.dat_Moveave_diff.nc
      netcdf_calc_fast 'r' 'z' '' 't' "fDA==$fDA@${var}" "fFR==$fFR@${var}" "$fdiff" "d${var}" "'difference of ${var} between ${expname} and FR'" 'm s-1' '+missing_value' 'fDA' 'fFR' -
   done
done

#-- mean_dmp アンサンブル平均の DA-FR 差 (中心軸は Nature run の台風中心)
for var in vt vr w; do
   for tim in ${tint[@]}; do
      fDA=${wkdir}/mean_ruby/mean_dmp_${ininame_yyyymm}${tim}0000..${var}.bin.nc
      fFR=${frdir}/mean_ruby/mean_dmp_${ininame_yyyymm}${tim}0000..${var}.bin.nc
      fdiff=${wkdir}/mean_ruby/mean_dmp_${ininame_yyyymm}${tim}0000..${var}.bin_diff.nc
      netcdf_calc_fast 'r' 'z' '' 't' "fDA==$fDA@${var}" "fFR==$fFR@${var}" "$fdiff" "d${var}" "'difference of ${var} between ${expname} and FR'" 'm s-1' '+missing_value' 'fDA' 'fFR' -
   done
done

#--------------- ここまでは逐次実行 ----------------
wait  # 上のバックグラウンドプロセスを全て待つ
fi

if [ ${dbg} -eq 0 ] || [ ${dbg} -eq 2 ]; then
#--------------- ここからは逐次実行 ----------------
#-- 主に作図プログラム実行
#-- anal/gues 作図 (nc/grads)
for k in anal gues; do
   for i in ${!draw_vars[@]}; do
      for j in ${!tint[@]}; do
         gpview --wsn=2 --clrmap=4 --levels ${draw_levels[$i]} --patterns ${draw_patterns[$i]} ${wkdir}/mean_ruby/mean_"$k"_${ininame_yyyymm}${tint[$j]}0000..${draw_vars[$i]}.bin.nc@${draw_vars[$i]},t=^0,r=0.0:${rrange},z=0.0:${zrange}
         mv -i dcl.pdf mean_"$k"_${draw_vars[$i]}_${expname}_${ininame_yyyymm}${tint[$j]}.pdf
      done
   done
   for var in rot div; do
      nml=dcl_sfc_map_mean_${var}.nml
      for j in ${!tint[@]}; do
         #dd=${tint[$j]:0:2}
         #hh=${tint[$j]:3:2}
         dcl_nml_change.rb ${nml} iday ${ininame_dd}
         dcl_nml_change.rb ${nml} ihour ${ininame_hh}
         dcl_nml_change.rb ${nml} fix_val "-5.0, -2.5, -1.0, -0.5, 0.0, 0.5, 1.0, 2.5, 5.0"  # For lower
         #dcl_nml_change.rb ${nml} fix_val "-0.5, -0.25, -0.1, -0.05, 0.0, 0.05, 0.1, 0.25, 0.5"  # For upper
         dcl_nml_change.rb ${nml} sfhname "'${wkdir}/mean_ruby/mean_"$k"_${ininame_yyyymm}${tint[$j]}0000.'"
         dcl_nml_change.rb ${nml} sffname "'.bin.${var}'"
         dcl_nml_change.rb ${nml} hname "'${wkdir}/mean_ruby/mean_"$k"_${ininame_yyyymm}${tint[$j]}0000.'"
         dcl_nml_change.rb ${nml} footname "'.bin.${var}'"
         dcl_nml_change.rb ${nml} title_name "'${var} @ 2 km (x10\^{-3} s\^{-1})'"
         dcl_nml_change.rb ${nml} ininame "${tint_sec[$j]}"
         dcl_nml_change.rb ${nml} grdname "'${wkdir}/hist.geo_${ininame_yyyymm}${ininame_dd}-${ininame_hh}0000.bin.dat'"
         ./dcl_sfc_map < ${nml}
         mv -i dcl.pdf mean_"$k"_${var}_${expname}_${ininame_yyyymm}${tint[$j]}.pdf
      done
   done
done

#-- anal - Nature run (真値) 差の作図
for i in ${!ddraw_vars[@]}; do
   for tim in ${tint[@]}; do
      gpview --wsn=2 --clrmap=4 --levels ${ddraw_levels[$i]} --patterns ${ddraw_patterns[$i]} ${wkdir}/mean_ruby/mean_anal_${ininame_yyyymm}${tim}0000..${ddraw_vars[$i]}.bin_obsdiff.nc@d${ddraw_vars[$i]},r=0.0:${rrange},z=0.0:${zrange}
      mv -i dcl.pdf mean_obsdiff_${ddraw_vars[$i]}_${expname}_${ininame_yyyymm}${tim}.pdf
   done
done

#-- anal - gues (解析インクリメント) 作図 (nc & grads)
for var in rot div; do
   nml=dcl_sfc_map_mean_${var}.nml
   for j in ${!tint[@]}; do
      #dd=${tint[$j]:0:2}
      #hh=${tint[$j]:3:2}
      dcl_nml_change.rb ${nml} iday ${ininame_dd}
      dcl_nml_change.rb ${nml} ihour ${ininame_hh}
      dcl_nml_change.rb ${nml} fix_val "-5.0, -2.5, -1.0, -0.5, 0.0, 0.5, 1.0, 2.5, 5.0"  # For lower
      #dcl_nml_change.rb ${nml} fix_val "-0.5, -0.25, -0.1, -0.05, 0.0, 0.05, 0.1, 0.25, 0.5"  # For upper
      dcl_nml_change.rb ${nml} sfhname "'${wkdir}/mean_ruby/mean_anal_${ininame_yyyymm}${tint[$j]}0000.'"
      dcl_nml_change.rb ${nml} sffname "'.bin.${var}_diff'"
      dcl_nml_change.rb ${nml} hname "'${wkdir}/mean_ruby/mean_anal_${ininame_yyyymm}${tint[$j]}0000.'"
      dcl_nml_change.rb ${nml} footname "'.bin.${var}_diff'"
      dcl_nml_change.rb ${nml} title_name "'Δ${var} @ 2 km (x10\^{-3} s\^{-1})'"
      dcl_nml_change.rb ${nml} ininame "${tint_sec[$j]}"
      dcl_nml_change.rb ${nml} grdname "'${wkdir}/hist.geo_${ininame_yyyymm}${ininame_dd}-${ininame_hh}0000.bin.dat'"
      ./dcl_sfc_map < ${nml}
      mv -i dcl.pdf mean_incr_${var}_${expname}_${ininame_yyyymm}${tint[$j]}.pdf
   done
done
for i in ${!idraw_vars[@]}; do  # nc
   for tim in ${tint[@]}; do
      gpview --wsn=2 --clrmap=4 --levels ${idraw_levels[$i]} --patterns ${idraw_patterns[$i]} ${wkdir}/mean_ruby/mean_anal_${ininame_yyyymm}${tim}0000..${idraw_vars[$i]}.bin_diff.nc@d${idraw_vars[$i]},t=^0,r=0.0:${rrange},z=0.0:${zrange}
      mv -i dcl.pdf mean_incr_${idraw_vars[$i]}_${expname}_${ininame_yyyymm}${tim}.pdf
   done
done

#-- hist.dmp アンサンブル平均作図 (各メンバー台風中心の平均)
for i in ${!draw_vars[@]}; do
   for tim in ${tint[@]}; do
      gpview --wsn=2 --clrmap=4 --levels ${draw_levels[$i]} --patterns ${draw_patterns[$i]} ${wkdir}/.${draw_vars[$i]}/hist.dmp_${ininame_yyyymm}${tim}0000.bin.dat_Moveave.nc@${draw_vars[$i]},t=^0,r=0.0:${rrange},z=0.0:${zrange}
      mv -i dcl.pdf mean_${draw_vars[$i]}_${expname}_${ininame_yyyymm}${tim}.pdf
   done
done

#-- hist.dmp アンサンブル平均の DA-FR 差作図 (各メンバー台風中心の平均)
for i in ${!ddraw_vars[@]}; do
   for tim in ${tint[@]}; do
      gpview --wsn=2 --clrmap=4 --levels ${ddraw_levels[$i]} --patterns ${ddraw_patterns[$i]} ${wkdir}/.${ddraw_vars[$i]}/hist.dmp_${ininame_yyyymm}${tim}0000.bin.dat_Moveave_diff.nc@d${ddraw_vars[$i]},t=^0,r=0.0:${rrange},z=0.0:${zrange}
      mv -i dcl.pdf mean_diff_${ddraw_vars[$i]}_${expname}_${ininame_yyyymm}${tim}.pdf
   done
done

#-- mean_dmp アンサンブル平均作図 (Nature run 中心の平均)
for i in ${!draw_vars[@]}; do
   for tim in ${tint[@]}; do
      gpview --wsn=2 --clrmap=4 --levels ${draw_levels[$i]} --patterns ${draw_patterns[$i]} ${wkdir}/mean_ruby/mean_dmp_${ininame_yyyymm}${tim}0000..${draw_vars[$i]}.bin.nc@${draw_vars[$i]},t=^0,r=0.0:${rrange},z=0.0:${zrange}
      mv -i dcl.pdf mean_dmp_${draw_vars[$i]}_${expname}_${ininame_yyyymm}${tim}.pdf
   done
done

#-- mean_dmp アンサンブル平均の DA-FR 差作図 (Nature run 中心の平均)
for i in ${!ddraw_vars[@]}; do
   for tim in ${tint[@]}; do
      gpview --wsn=2 --clrmap=4 --levels ${ddraw_levels[$i]} --patterns ${ddraw_patterns[$i]} ${wkdir}/mean_ruby/mean_dmp_${ininame_yyyymm}${tim}0000..${ddraw_vars[$i]}.bin_diff.nc@d${ddraw_vars[$i]},t=^0,r=0.0:${rrange},z=0.0:${zrange}
      mv -i dcl.pdf mean_dmpdiff_${ddraw_vars[$i]}_${expname}_${ininame_yyyymm}${tim}.pdf
   done
done

#--------------- ここまでは逐次実行 ----------------
wait  # 上のバックグラウンドプロセスを全て待つ

fi
module unload intel netcdf netcdf-fortran
