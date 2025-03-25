rsync -av --exclude "exp/" --exclude="fcst_exp/" --exclude="1_output/" --exclude="ruby_tools/" ~/data/scale/scale-5.2.6-satoki/letkf-H08VT/scale/run/ ./

for i in test testcase.test obs obs_UV
do
   rm -r $i
done

for i in upper eye+upper dummy
do
   rm -r obs_identicaltwin_UV/$i/*
done

rm a.out 
rm pseudo_H08UV_model  conv_t2b conv_t2b_prepbuf conv_t2b_h08vt 
for i in eye_R5m eye_dx6km
do
   rm obs_identicaltwin_UV/$i/obs_2018092*auto_*
done

rm log.run 
