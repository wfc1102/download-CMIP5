# download-CMIP5
https://esgf-node.llnl.gov/search/cmip5/ provide wget.sh script for each run with all variables, not all of which are of our interests. Manually selecting become boring especially for downloading in patch. Here provides a script to select the variables you need automatically.

Lawrence Livermore National Laboratory（LLNL）提供了CMIP5模式数据的下载shell脚本，单个脚本（如：wget-20170123192335.sh）包含了某个模式的特定实验（如：CCSM4,historical，run1,海洋，1850-2005）下的所有变量（nc文件名示例：vo_Omon_MPI-ESM-MR_historical_r1i1p1_185701-185712.nc），但用户往往仅需要其中的少数几个变量（如：S、T、U和V），手动从shell脚本中删除不要的变量是事倍功半的，尤其是有多个shell脚本（如：不同模式、不同run、不同实验piCOntrol/historical/RCP）的情况下，就应该采用script来提取所需的变量。


#---------------------------------------------------------------------------------
# input:
# wget-20170607190759.sh wget-20170607200757.sh
# (current directory, from https://esgf-node.llnl.gov/search/cmip5/)
#---------------------------------------------------------------------------------
# output:
# my_vo_wget-20170607190759.sh my_so_wget-20170607190759.sh 
# my_vo_wget-20170607200757.sh my_so_wget-20170607200757.sh 
#---------------------------------------------------------------------------------
# variable list, modify according to your need
for var in so thetao vo;do
#---------------------------------------------------------------------------------
