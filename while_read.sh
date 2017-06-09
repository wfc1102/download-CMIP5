#!/bin/bash
#---------------------------------------------------------------------------------
# input:
# wget-20170607190759.sh wget-20170607200757.sh
# (current directory, from https://esgf-node.llnl.gov/search/cmip5/)
#---------------------------------------------------------------------------------
# output:
# my_vo_wget-20170607190759.sh my_so_wget-20170607190759.sh 
# my_vo_wget-20170607200757.sh my_so_wget-20170607200757.sh 
#---------------------------------------------------------------------------------
# follow-up:
# download.sh
# for sh in `ls my_*_wget-*.sh`;do
#  ./${sh}
# done
# or arrange your downloading order according to models runs or variables
#---------------------------------------------------------------------------------
# tips:
# if connection fails, just run download.sh again. 
# may mv those all-ready-done my_wget.sh to other directory.
#---------------------------------------------------------------------------------

#  some oceanic variables
#for var in msftbarot msftmrhoz msftmrhozba msftmyz msftmyzba msftyrhoz msftyrhozba msftyyz msftyyzba zos sos tos uo vo so thetao wmo evs evspsbl friver hfbasin hfbasinba hfbasindiff hfds hfls hfss hfx hfxba hfxdiff hfy hfyba hfydiff htovgyre htovovrt  masscello masso mfo mlotst pbo pr prc psl rhopoto rlds rldscs rlus rlut rlutcs rsds rsdscs rsdt rsntds rsus rsuscs rsut rsutcs soga ta tas tauuo tauvo thetaoga thkcello volo vsf vsfcorr; do
#for var in so;do
#---------------------------------------------------------------------------------
for var in so thetao vo;do

  echo "======================= Now the script is: [${var}] ======================="
for sh in `ls wget-*.sh`; do
  echo "----------------------- Now the script is: [${sh}] -----------------------"
  cp ${sh} temp_${sh}
  count=$( grep "${var}_" temp_${sh} | wc -l)
  if (($count==0)); then
    continue
  fi

  grep "${var}_" temp_${sh} > temp_${var}.sh
  sort -u temp_${var}.sh -o temp_${var}.sh
  sed -i '/\.nc/d' temp_${sh}
  num1=$( sed -n '/download_files=/=' temp_${sh} |head -n 1 )
  num2=$( cat temp_${sh} |wc -l )
  head -n ${num1} temp_${sh} > myhead_${var}.sh
  tail -n $((num2-num1)) temp_${sh} > mytail_${var}.sh
  cat myhead_${var}.sh temp_${var}.sh mytail_${var}.sh > ${var}_${sh}
  chmod 755 ${var}_${sh}
  rm -f  myhead_${var}.sh temp_${var}.sh mytail_${var}.sh
  mv ${var}_${sh} my_${var}_${sh}
done

#exit

done

times
