#!/usr/bin/bash
# SCALE 予報実験結果から一通りの解析を行い, 描画までするスクリプト.
# 実験ディレクトリを指定するだけ.
# どのような解析を行うかをコメントつきで列挙するので, 逐次追加可能.
# 利用するスクリプトや設定ファイルはあらかじめ実験用に値を設定しておくこと.
# このスクリプトでは値の設定などは自動実行しない.

set -e -x
dbg=1  # デバッグモード
only_draw=0  # 描画のみ (0: true, 1: false)
only_anal=0  # 解析のみ (0: true, 1: false)

#-- 実験結果ディレクトリの指定
#exp_name="1h_eye_identicaltwin_UV"
#res_dir="../fcst_exp/testcase_${exp_name}/"
#wkdir="1_output/fcst_${exp_name}/"
exp_name="1h_eye_A08_identicaltwin"
res_dir="../exp/testcase_${exp_name}/"
wkdir="1_output/${exp_name}/"
rev_dir="../../"  # wkdir からみた cur_dir 相対パス
ref_dir="1_output/48h/"  # フリーランのディレクトリ
obs_file=("../obs_identicaltwin/UV_.vt.grd.nc" "../obs_identicaltwin/UV_.vr.grd.nc")  # 観測に用いた true run (anl_var の vt, vr に順番を合わせる)
anl_day="201809"  # 解析月 yyyymm
#anl_time=("27-12" "27-13" "27-14" "27-15" "27-16" "27-17" "27-18" "27-19" "27-20" "27-21" "27-22" "27-23" "28-00" "28-01" "28-02" "28-03" "28-04" "28-05" "28-06" "28-07" "28-08" "28-09" "28-10" "28-11" "28-12")  # 解析時刻
#tru_time=("00129600" "00133200" "00136800" "00140400" "00144000" "00147600" "00151200" "00154800" "00158400" "00162000" "00165600" "00169200" "00172800" "00176400" "00180000" "00183600" "00187200" "00190800" "00194400" "00198000" "00201600" "00205200" "00208800" "00212400" "00216000")  # 解析時刻 8 桁 (true run の経過秒数基準)
anl_time=("26-00" "26-06" "26-12" "26-18" "27-00" "27-06" "27-12") #"27-18" "28-00" "28-06" "28-12")  # 解析時刻
tru_time=("00000000" "00021600" "00043200" "00064800" "00086400" "00108000" "00129600") #"00151200" "00172800" "00194400" "00216000")  # 解析時刻 8 桁 (true run の経過秒数基準)
anl_var=("vt" "vr" "w" "pt" "p")  # 解析する変数 (NetCDF の変数名)
drw_var=("vt" "vr" "w" "pt_pert" "p")  # 描画する変数 (NetCDF の変数名)
anl_vun=("m s-1" "m s-1" "m s-1" "K" "Pa")  # anl_var の単位
asucaz_file="1_output/48h/hist.geo_201809${anl_time[0]}0000.bin.dat.asuca_z"  # 鉛直格子点高度情報ファイル
truetc_file="bst_T1824_identicaltwin_tot.dat.tcenter"  # true run の tcenter ファイルをアンサンブルメンバーの格子点で置き換えた (calc_nearest_latlon 適用後の tcenter ファイル)
truetc_orgdir="1_output/48h/"  # truetc_file のオリジナルデータの所在ディレクトリ
#-- 以下は描画関連の変数設定
var_levels=("0.0,10.0,20.0,30.0,40.0,45.0,50.0,60.0,70.0" \
            "-8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0" \
            "0.0,0.1,0.3,0.5,0.7,0.9" \
            "-8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0")  # drw_var の順番で gpview --levels の設定
var_pattns=("55999,60999,65999,70999,75999,80999,85999,90999,95999" \
            "15999,25999,35999,40999,50999,60999,70999,75999,85999,95999" \
            "50999,55999,60999,70999,77999,84999,95999" \
            "15999,25999,35999,40999,50999,60999,70999,75999,85999,95999")  # drw_var の順番で gpview --patterns の設定
dvar_levels=("-8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0" \
             "-8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0" \
             "0.0,0.1,0.3,0.5,0.7,0.9" \
             "-8.0,-6.0,-4.0,-2.0,0.0,2.0,4.0,6.0,8.0")  # anl_var の順番で gpview --levels の設定 (diff 描画)
dvar_pattns=("15999,25999,35999,40999,50999,60999,70999,75999,85999,95999" \
             "15999,25999,35999,40999,50999,60999,70999,75999,85999,95999" \
             "50999,55999,60999,70999,77999,84999,95999" \
             "15999,25999,35999,40999,50999,60999,70999,75999,85999,95999")  # anl_var の順番で gpview --patterns の設定 (diff 描画)
rrange="0.0:200.0"  # 描画する距離範囲の設定
zrange="0.0:17.0"  # 描画する高度範囲の設定

module load intel netcdf netcdf-fortran
ulimit -s unlimited
export OMP_NUM_THREADS=1
export OMP_STACKSIZE=512000
cur_dir=`pwd`
ruby_="/home/z44533r/usr/local/CL_intel/bin/ruby"
gpview_="${ruby_} draw_val.rb"

if [ $dbg != 1 ]; then  # デバッグするために計算をスキップさせたい箇所をこの if fi 内に入れる.
   echo "Nothing to do"

# (0) 実験結果の解析場所作成
if [ ! -e $wkdir ]; then mkdir $wkdir; fi
cd $wkdir
if [ -e 00000001 ]; then rm 00*; fi
ln -s "$rev_dir"/"$res_dir"/0* ./
for i in 0*; do
   mv $i 0000$i
done
if [ ! -e mean_ruby ]; then mkdir mean_ruby; fi

cd $cur_dir

if [ ! -e ${res_dir}/mean_ruby ]; then
   mkdir ${res_dir}/mean_ruby
fi
echo "Pass 0: prepare $wkdir"

#if [ $only_anal == 0 ]; then
################## (a1) geography データをバイナリ出力
if [ ${wkdir} != ${ref_dir} ]; then
   cp $asucaz_file $wkdir
   rm -f $wkdir/$truetc_file
   cp -i ${truetc_orgdir}/$truetc_file $wkdir
fi
$ruby_ conv_ncmulti_grads_xy.rb $res_dir hist.d01_"$anl_day""${anl_time[0]}"0000.000.pe00 hist.geo_"$anl_day""${anl_time[0]}"0000.bin
cd $wkdir
ln -sf ${rev_dir}/$asucaz_file ${truetc_file%.tcenter}.asuca_z  # true run tcenter で軸対称平均するときの SCALE の鉛直座標データを hist.geo.asuca_z からリンク
ln -sf 00000001/hist.geo_"$anl_day""${anl_time[0]}"0000.bin.dat ./
for i in "${!anl_time[@]}"; do
   if [ $i != 0 ]; then
      ln -sf hist.geo_"$anl_day""${anl_time[0]}"0000.bin.dat hist.geo_"$anl_day""${anl_time[$i]}"0000.bin.dat
      ln -sf hist.geo_"$anl_day""${anl_time[0]}"0000.bin.dat.asuca_z hist.geo_"$anl_day""${anl_time[$i]}"0000.bin.dat.asuca_z
   fi
done
cd $cur_dir
echo "Pass a1: produce hist.geo data"

################## (a2) 各時刻のアンサンブルメンバー台風中心位置計算
################## (a2.1) 海面気圧データ変換
# fcst の場合は hist データが連続時刻で格納されている.
$ruby_ conv_ncmulti_grads_xyt_series.rb $res_dir hist.d01_"${anl_day}${anl_time[0]}"0000.000.pe00 hist.mslp_
echo "Waiting process..."
echo "Pass a2.1: produce hist.mslp data"

################## (a2.2) calc_TCenter 実行
dcl_nml_change.rb calc_TCenter.nml hname "'"$wkdir"/'"
for i in ${anl_time[@]}; do
   dcl_nml_change.rb calc_TCenter.nml footname "'/hist.mslp_${anl_day}${i}0000.bin.dat'"
   dcl_nml_change.rb calc_TCenter.nml grdname "'${wkdir}/hist.geo_${anl_day}${i}0000.bin.dat'"
   ./calc_TCenter < calc_TCenter.nml &
   sleep 5
done
echo "Pass a2.2: produce tcenter data"  # ${wkdir}/hist.geo_${anl_day}${i}0000.bin.dat.tcenter が作成
fi  # <- if [ $dbg != 1 ]; then

################## (a2.3) tcenter データを各メンバーディレクトリに時系列データとして格納
# https://yabutan.com/posts/201116_bash_how_to_join_array に従い, 
# anl_time, tru_time をスペースからカンマ区切り + join する
anl_time_join=$(printf ",${wkdir}/hist.geo_${anl_day}%s0000.bin.dat.tcenter" "${anl_time[@]}")  # (a2.2) で作成した tcenter ファイルを連ねる
tru_time_join=$(printf ",%s" "${tru_time[@]}")  # anl_time_join に対応した相対時間をカンマ区切りで定義
anl_time_join=${anl_time_join:1}  # 先頭文字がカンマになってしまうのを 1 文字ずらして再定義
tru_time_join=${tru_time_join:1}  # 先頭文字がカンマになってしまうのを 1 文字ずらして再定義
ruby conv_tcentertxt_mem2tim.rb --files=${anl_time_join} --times=${tru_time_join} ${wkdir} hist.mslp_time.dat.tcenter

exit
# -> draw_time_series_tot.nml 描画へ (これは自動化させずに微調整して手動描画)

################## (a3) 各メンバーの軸対称平均 + 軸対称場のアンサンブル平均
################## (a3.1) hist.dmp データ変換
wait_array=()  # バックグラウンドで並列実行する場合に, wait 同期用の PID をこれに入れる.
for i in ${anl_time[@]}; do
   $ruby_ conv_ncmulti_grads_xyzt.rb $res_dir hist.d01_"${anl_day}${i}"0000.000.pe00 hist.dmp_"${anl_day}${i}"0000.bin &
   wait_array+=($!)  # 直前のバックグラウンドジョブを wait_array の最後に追加していく
done
echo "Waiting process..."
wait ${wait_array[@]}  # 上で追記されたバックグラウンドの PID 全ての終了同期待ち
echo "Pass a3.1: produce hist.dmp data"

################## (a3.2) calc_tangen_mean_nc 実行
for i in vt vr w pt p pt_pert
do
   if [ ! -e $wkdir/.$i ]; then mkdir $wkdir/.$i; fi
done

wait_array=()  # バックグラウンドで並列実行する場合に, wait 同期用の PID をこれに入れる.
for j in calc_tangen_mean_nc{1,2,3,4}.nml; do
   dcl_nml_change.rb $j hname "'"$wkdir"/'"
   for i in ${anl_time[@]}; do
      dcl_nml_change.rb $j footname "'/hist.dmp_${anl_day}${i}0000.bin.dat'"
      dcl_nml_change.rb $j grdname "'${wkdir}/hist.geo_${anl_day}${i}0000.bin.dat'"
      ./calc_tangen_mean_nc < $j &
      sleep 5
   done
done
echo "Waiting process..."
wait ${wait_array[@]}  # 上で追記されたバックグラウンドの PID 全ての終了同期待ち

for i in ${anl_time[@]}; do  # pt は外側半径でアノマリーを計算しておく
   $ruby_ netcdf_envanom.rb $wkdir/.pt/hist.dmp_${anl_day}${i}0000.bin.dat.nc $wkdir/.pt_pert/hist.dmp_${anl_day}${i}0000.bin.dat.nc
done
echo "Pass a3.2: produce hist.dmp.nc data"

################## (a3.3) アンサンブル平均実行
for j in vt vr w pt p pt_pert; do
   for i in ${anl_time[@]}; do
      bash make_mean_nc.sh $wkdir/.$j/hist.dmp_${anl_day}${i}0000.bin.dat.nc ${j%_pert}  # _pert のみ, 読み込み変数名は pt と同じなので, _pert 除外しておく (他の変数には影響なし)
   done
done
echo "Pass a3.3: produce hist.dmp_Moveave.nc data"

################## (a3.4) アンサンブル平均場の差を作成
if [ ${wkdir} != ${ref_dir} ]; then  # フリーランデータの処理時はこの操作はしない
   for j in "${!anl_var[@]}"; do  # "!" で anl_var の添え字のリストになっているので, j には 0~ 整数が入る
      for i in ${anl_time[@]}; do
         bash make_diff_nc.sh ${wkdir}/.${anl_var[$j]}/hist.dmp_${anl_day}${i}0000.bin.dat_Moveave.nc ${ref_dir}/.${anl_var[$j]}/hist.dmp_${anl_day}${i}0000.bin.dat_Moveave.nc ${wkdir}/.${anl_var[$j]}/hist.dmp_${anl_day}${i}0000.bin.dat_Moveave_diff.nc ${anl_var[$j]} "difference of ${anl_var[$j]} between DA and NoDA" "${anl_vun[$j]}"
      done
   done
fi
echo "Pass a3.4: produce hist.dmp_Moveave_diff.nc data"

################## (a3.5) アンサンブル平均場と true run の差
for i in "${!anl_time[@]}"; do  # "!" で anl_var の添え字のリストになっているので, j には 0~ 整数が入る
   $ruby_ make_nc_obs_diff.rb ${obs_file[0]} ${wkdir}/.${anl_var[0]}/hist.dmp_${anl_day}${anl_time[$i]}0000.bin.dat_Moveave.nc ${anl_var[0]} ${wkdir}/.${anl_var[0]}/hist.dmp_${anl_day}${anl_time[$i]}0000.bin.dat_Moveave_obsdiff.nc ${exp_name} ${tru_time[$i]}
   $ruby_ make_nc_obs_diff.rb ${obs_file[1]} ${wkdir}/.${anl_var[1]}/hist.dmp_${anl_day}${anl_time[$i]}0000.bin.dat_Moveave.nc ${anl_var[1]} ${wkdir}/.${anl_var[1]}/hist.dmp_${anl_day}${anl_time[$i]}0000.bin.dat_Moveave_obsdiff.nc ${exp_name} ${tru_time[$i]}
done
echo "Pass a3.5: produce hist.dmp_Moveave_obsdiff.nc data"
fi  # <- [only_anal == 0]

if [ $only_draw == 0 ]; then
################## (d3) 軸対象場関連の作図
################## (d3.1) 軸対象アンサンブル各メンバーの作図
for i in 0 1 2; do  # 0: vt, 1: vr, 2: w
   for j in ${anl_time[@]}; do
      $gpview_ --anim t --wsn=2 --clrmap=4 --levels ${var_levels[$i]} --patterns ${var_pattns[$i]} ${wkdir}/.${drw_var[$i]}/hist.dmp_${anl_day}${j}0000.bin.dat.nc@${drw_var[$i]},r=${rrange},z=${zrange}
      mv dcl.pdf ens_${drw_var[$i]}_${exp_name}_${anl_day}${j/-/}.pdf  # ${j/-/} は anl_time に含まれるハイフンを除去する処理
   done
done
echo "Pass d3.1: produce ensmean figures"

################## (d3.2) 軸対象アンサンブル平均場の作図
for i in 0 1 3; do  # 0: vt, 1: vr, 3: pt_pert
   for j in ${anl_time[@]}; do
      $gpview_ --wsn=2 --clrmap=4 --levels ${var_levels[$i]} --patterns ${var_pattns[$i]} ${wkdir}/.${drw_var[$i]}/hist.dmp_${anl_day}${j}0000.bin.dat_Moveave.nc@${drw_var[$i]%_pert},t=^0,r=${rrange},z=${zrange}
      mv dcl.pdf mean_${drw_var[$i]%_pert}_${exp_name}_${anl_day}${j/-/}.pdf  # ${j/-/} は anl_time に含まれるハイフンを除去する処理
   done
done
echo "Pass d3.2: produce ensmean figures"

################## (d3.3) 軸対象アンサンブル平均場と true run の差の作図
for i in 0 1; do  # 0: vt, 1: vr
   for j in ${anl_time[@]}; do
      $gpview_ --wsn=2 --clrmap=4 --levels ${dvar_levels[$i]} --patterns ${dvar_pattns[$i]} ${wkdir}/.${anl_var[$i]}/hist.dmp_${anl_day}${j}0000.bin.dat_Moveave_obsdiff.nc@d${anl_var[$i]},r=${rrange},z=${zrange}
      mv dcl.pdf mean_obsdiff_${anl_var[$i]}_${exp_name}_${anl_day}${j/-/}.pdf  # ${j/-/} は anl_time に含まれるハイフンを除去する処理
   done
done
echo "Pass d3.3: produce obsdiff ensmean figures"

################## (d3.4) 軸対象アンサンブル平均場とフリーランの差の作図
if [ ${wkdir} != ${ref_dir} ]; then  # フリーランデータの処理時はこの操作はしない
   for i in 0 1 3; do  # 0: vt, 1: vr, 3: pt
      for j in ${anl_time[@]}; do
         $gpview_ --wsn=2 --clrmap=4 --levels ${dvar_levels[$i]} --patterns ${dvar_pattns[$i]} ${wkdir}/.${anl_var[$i]}/hist.dmp_${anl_day}${j}0000.bin.dat_Moveave_diff.nc@d${anl_var[$i]},t=^0,r=${rrange},z=${zrange}
         mv dcl.pdf mean_diff_${anl_var[$i]}_${exp_name}_${anl_day}${j/-/}.pdf  # ${j/-/} は anl_time に含まれるハイフンを除去する処理
      done
   done
   echo "Pass d3.4: produce diff ensmean figures"
fi
fi  # <- only_draw == 0

if [ ${wkdir} = ${ref_dir} ]; then
   echo "Finished normally."
   module unload intel netcdf netcdf-fortran
   exit
fi # フリーランデータの処理時は以下の処理を行わずここで終了.

if [ $only_anal == 0 ]; then
################## (a4) NetCDF ファイル{anal,gues} データアンサンブル平均+バイナリ変換
################## (a4.1) NetCDF ファイルのアンサンブル平均
wait_array=()  # バックグラウンドで並列実行する場合に, wait 同期用の PID をこれに入れる.
for i in "${!anl_time[@]}"; do
   if [ $i != 0 ]; then
      for j in anal gues; do
         $ruby_ calc_ensmean_xyz.rb $res_dir ${j}.d01_"${anl_day}${anl_time[$i]}"0000.000.pe00 ${res_dir}/mean_ruby/mean_${j}_"${anl_day}${anl_time[$i]}"0000.000.nc &
         wait_array+=($!)  # 直前のバックグラウンドジョブを wait_array の最後に追加していく
      done
   fi
done
echo "Waiting process..."
wait ${wait_array[@]}  # 上で追記されたバックグラウンドの PID 全ての終了同期待ち
echo "Pass a4.1: produce mean_anal/gues.nc data"

################## (a4.2) アンサンブル平均した NetCDF ファイルのバイナリ変換
wait_array=()  # バックグラウンドで並列実行する場合に, wait 同期用の PID をこれに入れる.
for i in "${!anl_time[@]}"; do
   if [ $i != 0 ]; then
      for j in anal gues; do
         $ruby_ conv_nc_intrpUV_grads_xyz.rb ${res_dir}/mean_ruby/mean_${j}_"${anl_day}${anl_time[$i]}"0000.000.nc &
         wait_array+=($!)  # 直前のバックグラウンドジョブを wait_array の最後に追加していく
      done
   fi
done
echo "Waiting process..."
wait ${wait_array[@]}  # 上で追記されたバックグラウンドの PID 全ての終了同期待ち
echo "Pass a4.2: produce mean_anal/gues.bin data"

################## (a4.3) バイナリデータから渦度・発散の計算
wait_array=()  # バックグラウンドで並列実行する場合に, wait 同期用の PID をこれに入れる.
for j in anal gues; do
   dcl_nml_change.rb make_rot_div_3d.nml hname "'"${res_dir}"/mean_ruby/mean_"${j}"_'"
   for i in "${!anl_time[@]}"; do
      if [ $i != 0 ]; then
         day=${anl_time[$i]:0:2}  # anl_time(=i) の先頭から 2  文字分抽出
         hour=${anl_time[$i]:2:3}  # anl_time(=i) の 3 文字目から 3  文字分抽出
         dcl_nml_change.rb make_rot_div_3d.nml footname "'${hour}0000.000.bin'"
         dcl_nml_change.rb make_rot_div_3d.nml ininame ${anl_day}${day}
         ./make_rot_div_3d < make_rot_div_3d.nml &
         sleep 5
      fi
   done
done
echo "Waiting process..."
wait ${wait_array[@]}  # 上で追記されたバックグラウンドの PID 全ての終了同期待ち
echo "Pass a4.2: produce rot/div data"

################## (a4.3) anal/gues バイナリデータを軸対称平均
cd $wkdir/mean_ruby
for i in "${!anl_time[@]}"; do  # "!" で anl_var の添え字のリストになっているので, j には 0~ 整数が入る
   if [ $i != 0 ]; then
      for j in anal gues; do
         ln -sf ../$rev_dir/$res_dir/mean_ruby/mean_${j}_${anl_day}${anl_time[$i]}0000.000.bin mean_${j}_${anl_day}${anl_time[$i]}0000.000.bin${tru_time[$i]}
      done
   fi
done
cd $cur_dir

wait_array=()  # バックグラウンドで並列実行する場合に, wait 同期用の PID をこれに入れる.
for j in calc_tangen_mean_nc_anal{1,2}.nml; do
   dcl_nml_change.rb $j grdname "'${wkdir}/${truetc_file%.tcenter}'"
   for i in "${!anl_time[@]}"; do  # "!" で anl_var の添え字のリストになっているので, j には 0~ 整数が入る
      if [ $i != 0 ]; then
         for k in anal gues; do
            dcl_nml_change.rb $j hname "'"$wkdir"/mean_ruby/mean_"$k"_${anl_day}${anl_time[$i]}0000.000.bin'"
            dcl_nml_change.rb $j ininame ${tru_time[$i]}
            ./calc_tangen_mean_nc < $j &
            sleep 5
         done
      fi
   done
done
echo "Waiting process..."
wait ${wait_array[@]}  # 上で追記されたバックグラウンドの PID 全ての終了同期待ち

for i in "${!anl_time[@]}"; do  # pt は外側半径でアノマリーを計算しておく
   if [ $i != 0 ]; then
      for k in anal gues; do
         $ruby_ netcdf_envanom.rb $wkdir/mean_ruby/mean_"$k"_${anl_day}${anl_time[$i]}0000.000.bin.pt.nc $wkdir/mean_ruby/mean_"$k"_${anl_day}${anl_time[$i]}0000.000.bin.pt_pert.nc
      done
   fi
done
echo "Pass a4.3: produce mean_{anal/gues}.bin.nc data"

################## (a4.4) 解析インクリメント (anal-gues) を計算
for i in "${!anl_time[@]}"; do  # 3 次元バイナリデータ
   if [ $i != 0 ]; then
      for j in rot div; do
         bash make_diff_grads.sh $wkdir/mean_ruby/mean_anal_${anl_day}${anl_time[$i]}0000.bin.dat.$j $wkdir/mean_ruby/mean_gues_${anl_day}${anl_time[$i]}0000.bin.dat.$j $wkdir/mean_ruby/mean_anal_${anl_day}${anl_time[$i]}0000.bin.dat.${j}_diff
      done
   fi
done

for i in "${!anl_time[@]}"; do  # "!" で anl_var の添え字のリストになっているので, j には 0~ 整数が入る
   if [ $i != 0 ]; then
      for j in 0 1 3; do  # 2 次元軸対象データ (0: vt, 1: vr, 3: pt)
         bash make_diff_nc.sh ${wkdir}/mean_ruby/mean_anal_${anl_day}${anl_time[$i]}0000.000.bin.${anl_var[$j]}.nc ${wkdir}/mean_ruby/mean_gues_${anl_day}${anl_time[$i]}0000.000.bin.${anl_var[$j]}.nc ${wkdir}/mean_ruby/mean_anal_${anl_day}${anl_time[$i]}0000.000.bin.${anl_var[$j]}_diff.nc ${anl_var[$j]} "difference of ${anl_var[$j]} between anal and gues" "${anl_vun[$j]}"
      done
   fi
done
echo "Pass a4.4: produce anal-gues data"

################## (a4.5) アンサンブル平均場と true run の差
for i in "${!anl_time[@]}"; do  # "!" で anl_var の添え字のリストになっているので, j には 0~ 整数が入る
   if [ $i != 0 ]; then
      for j in 0 1; do  # 0: vt, 1: vr
         $ruby_ make_nc_obs_diff.rb ${obs_file[$j]} ${wkdir}/mean_ruby/mean_anal_${anl_day}${anl_time[$i]}0000.000.bin.${anl_var[$j]}.nc ${anl_var[$j]} ${wkdir}/mean_ruby/mean_anal_${anl_day}${anl_time[$i]}0000.000.bin.${anl_var[$j]}_obsdiff.nc ${exp_name} ${tru_time[$i]}
      done
   fi
done
echo "Pass a4.5: produce mean_anal_obsdiff.nc data"
fi  # <- only_calc == 0

if [ $only_draw == 0 ]; then
################## (d4.1) 軸対象アンサンブル平均場の作図
for j in "${!anl_time[@]}"; do  # "!" で anl_var の添え字のリストになっているので, j には 0~ 整数が入る
   if [ $j != 0 ]; then
      for i in 0 1 3; do  # 0: vt, 1: vr, 3: pt_pert
         for k in anal gues; do
            $gpview_ --wsn=2 --clrmap=4 --levels ${var_levels[$i]} --patterns ${var_pattns[$i]} ${wkdir}/mean_ruby/mean_${k}_${anl_day}${anl_time[$j]}0000.000.bin.${drw_var[$i]}.nc@${drw_var[$i]%_pert},t=^0,r=${rrange},z=${zrange}
            mv dcl.pdf mean_${k}_${drw_var[$i]}_${exp_name}_${anl_day}${anl_time[$j]/-/}.pdf  # ${j/-/} は anl_time に含まれるハイフンを除去する処理
         done
      done
   fi
done
echo "Pass d4.1: produce ensmean anal/gues figures"

################## (d4.2) 軸対象アンサンブル平均場の解析インクリメント (anal-gues)
for j in "${!anl_time[@]}"; do  # "!" で anl_var の添え字のリストになっているので, j には 0~ 整数が入る
   if [ $j != 0 ]; then
      for i in 0 1 3; do  # 0: vt, 1: vr, 3: pt
         $gpview_ --wsn=2 --clrmap=4 --levels ${dvar_levels[$i]} --patterns ${dvar_pattns[$i]} ${wkdir}/mean_ruby/mean_anal_${anl_day}${anl_time[$j]}0000.000.bin.${anl_var[$i]}_diff.nc@d${anl_var[$i]},t=^0,r=${rrange},z=${zrange}
         mv dcl.pdf mean_incr_${anl_var[$i]}_${exp_name}_${anl_day}${anl_time[$j]/-/}.pdf  # ${j/-/} は anl_time に含まれるハイフンを除去する処理
      done
   fi
done
echo "Pass d4.2: produce mean diff between anal and gues"

################## (d4.3) 軸対象アンサンブル平均場と true run の差の作図
for j in "${!anl_time[@]}"; do
   if [ $j != 0 ]; then
      for i in 0 1; do  # 0: vt, 1: vr
         $gpview_ --wsn=2 --clrmap=4 --levels ${dvar_levels[$i]} --patterns ${dvar_pattns[$i]} ${wkdir}/mean_ruby/mean_anal_${anl_day}${anl_time[$j]}0000.000.bin.${anl_var[$i]}_obsdiff.nc@d${anl_var[$i]},r=${rrange},z=${zrange}
         mv dcl.pdf mean_analobsdiff_${anl_var[$i]}_${exp_name}_${anl_day}${anl_time[$j]/-/}.pdf  # ${j/-/} は anl_time に含まれるハイフンを除去する処理
      done
   fi
done
echo "Pass d4.3: produce diff ensmean figures"

################## (d5.1) true run の作図
for j in "${!tru_time[@]}"; do
   for i in 0 1; do  # 0: vt, 1: vr
      $gpview_ --wsn=2 --clrmap=4 --levels ${var_levels[$i]} --patterns ${var_pattns[$i]} ${obs_file[$i]}@${drw_var[$i]},r=${rrange},z=${zrange},t=${tru_time[$j]}
      mv dcl.pdf mean_${drw_var[$i]}_obs_${anl_day}${anl_time[$j]/-/}.pdf  # ${j/-/} は anl_time に含まれるハイフンを除去する処理, tru_time と anl_time が要素番号で同じ時刻を表すことを利用
   done
done
echo "Pass d5.1: produce true run figures"
fi  # <- only_draw == 0

module unload intel netcdf netcdf-fortran
echo "Finished normally."
