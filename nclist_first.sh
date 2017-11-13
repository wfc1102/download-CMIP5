#!/bin/bash
#---------------------------------------------------------------------------------
# input:
#    wget-20170607190759.sh wget-20170607200757.sh
# or
#    my_vo_wget-20170607190759.sh my_vo_wget-20170607200757.sh
#    my_so_wget-20170607190759.sh my_so_wget-20170607200757.sh
#---------------------------------------------------------------------------------
# output:
#    a.list:
#       wget-20170607190759.sh vo_Omon_MPI-ESM-MR_historical_r1i1p1_185701-185712.nc
#    sh.list:
#       wget-20170607190759.sh
#---------------------------------------------------------------------------------
# Instructions:
#    Different *wget-*.sh might include the same data due to from different websites
#    Or *wget-*.sh are the same experiment but are not intact and need each other.
#    This script is to shrink dupulicates into exclusives, list which .sh is needed
#       which is not. 
#---------------------------------------------------------------------------------
:>a.list
for sh in `ls wget-*.sh`; do
  cp ${sh} temp_${sh}
  num1=$( sed -n '/download_files=/=' temp_${sh} |head -n 1 )
  num2=$( sed -n '/EOF--dataset.file.url.chksum_type.chksum/=' temp_${sh} |tail -n 1 )
  ((num1++))
  head -n ${num1} temp_${sh}  > temp2_${sh}
  tail -n 1       temp2_${sh} > temp3_${sh}
  while read line
  do
     nc=`echo ${line} | cut -d "'" -f 2`
     flag=1
     for old in `cat a.list`;do
        [[ ${old##*.} == "sh" ]] && continue
        [[ -e ${nc} ]] && flag=0
        if [[ ${nc} == ${old} ]];then
           flag=0
        fi
     done
     [[ ${flag} == 1 ]] && echo "${sh} ${nc}" >> a.list
  done < temp3_${sh}
  rm -f temp*_${sh}
done
cat a.list
echo "===================================================================================================="
sleep 2

:>sh.list
  while read line
  do
     sh=`echo ${line} | cut -d " " -f 1`
     echo "${sh}" >> sh.list
  done < a.list
  sort -u sh.list -o sh.list
  cat sh.list
echo "===================================================================================================="
sleep 2
  for sh in `cat sh.list`;do
     chmod 755 ${sh}
     ./${sh}
  done
echo "===================================================================================================="
sleep 2
#  mv wget-*.sh scripts/

times
