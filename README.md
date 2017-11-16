# download-CMIP5
#---------------------------------------------------------------------------------

while_read.sh

https://esgf-node.llnl.gov/search/cmip5/ provide wget.sh script for each run with all variables, not all of which are of our interests. Manually selecting become boring especially for downloading in patch. Here provides a script to select the variables you need automatically.

Lawrence Livermore National Laboratory（LLNL）提供了CMIP5模式数据的下载shell脚本，单个脚本（如：wget-20170123192335.sh）包含了某个模式的特定实验（如：CCSM4,historical，run1,海洋，1850-2005）下的所有变量（nc文件名示例：vo_Omon_MPI-ESM-MR_historical_r1i1p1_185701-185712.nc），但用户往往仅需要其中的少数几个变量（如：S、T、U和V），手动从shell脚本中删除不要的变量是事倍功半的，尤其是有多个shell脚本（如：不同模式、不同run、不同实验piCOntrol/historical/RCP）的情况下，就应该采用script来提取所需的变量。

#---------------------------------------------------------------------------------

nclist_first.sh

This script is a refine process based on while_read.sh. It's being reason is that 
(1) same experiment is stored in different severs, most of the time they are the same,
but sometimes they make up for each to be integrity, thus different *.sh might have 
same/complementary data. 

(2) we might get the same experiment wget.sh script from same sever but on different days.
they have different names due to the script is named according to its downloaded date. Thus
they are totally dupulicates

We don't need to execute each *.sh because sometimes it consumes time to judge whether file 
downloaded yet or not. Or, downloading speed depends on severs, also the responce process is 
different.

脚本nclist_first.sh是在while_read.sh的基础上，按需求定制的：不同的wget.sh脚本存在重复、互补的问题，
如：有100个sh脚本，但实际只需要其中的20个，经过refine后就可以省去无用脚本的执行、远程相应时间
（有时会请求数次，耗几个时仍未果）。user可以开多个后台从这20个脚本中选择以下载。

此外，在执行过程中，遇到响应慢的sh脚本，可以将其mv到别处：所需的nc文件在这个sh脚本（本质是sever）
中下载较慢，user择优而选。

最后，nclist_first.sh可以重复执行，已经下载到当前路径的nc文件不会再重复下载，直到a.list和sh.list
变为空文件。
