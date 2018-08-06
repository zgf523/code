#!/bin/bash
if [ $# -ne 2 ]
then
        echo "error input ! "
        echo "please input arg : start date and end date"
        echo "example ./xxx.sh 20160726 20160727"
        exit
fi

starttime=`date -d $1 +%s`
endtime=`date -d $2 +%s`
#starttime=`date -d "yesterday" +%s`
#endtime=`date -d "yesterday" +%s`
echo "start time : $starttime" 
echo "end time : $endtime" 
wwwf=http://10.3.3.110:81/access1-
echo "This is printing $File"
for((i=$starttime;i<=$endtime;i+=86400)); do
    date=`date -d "@$i" "+%Y%m%d"`
    str=.log.gz
    wwwFile="$wwwf""$date""$str"
    echo $wwwFile
    wget $wwwFile
 done
for files in `ls ./*.gz`
  do
      gunzip $files
  done
for files in `ls ./*.log`
  do
      mv $files `echo "$files.www" `
  done
wapf=http://10.3.3.88:82/access1-
for((i=$starttime;i<=$endtime;i+=86400));
 do
    date=`date -d "@$i" "+%Y%m%d"`
    str=.log.gz
    wapFile="$wapf""$date""$str"
    echo $wapFile
    wget $wapFile
 done
for files in `ls ./*.gz`
  do
      gunzip $files
  done
for files in `ls ./*.log`
  do
        mv $files `echo "$files.wapp" `
  done
workf=http://10.3.3.112:82/access1-
for((i=$starttime;i<=$endtime;i+=86400)); 
do
    date=`date -d "@$i" "+%Y%m%d"`
    str=.log.gz
    workFile="$workf""$date""$str"
    echo $workFile
    wget $workFile
done
for files in `ls ./*.gz`
  do
      gunzip $files
  done
for files in `ls ./*.log`
  do
        mv $files `echo "$files.wwork" `
done
wapf=ftp://10.3.3.95/pub/wap.yiwugou.com.access-
for((i=$starttime;i<=$endtime;i+=86400));
 do
    date=`date -d "@$i" "+%Y%m%d"`
    str=.log.gz
    wapFile="$wapf""$date""$str"
    echo $wapFile
    wget $wapFile
done
for files in `ls ./*.gz`
  do
      gunzip $files
  done
for files in `ls ./wap.yiwugou.com.access-*`
  do
        mv $files `echo $files| sed 's/wap.yiwugou.com.access-/access1-/g'`
  done
for files in `ls ./*.log`
  do
        mv $files `echo "$files.wap"`
  done
whef=http://10.3.3.100:81/access1-
echo "This is printing $File"
for((i=$starttime;i<=$endtime;i+=86400)); do
    date=`date -d "@$i" "+%Y%m%d"`
    str=.log.gz
    wheFile="$whef""$date""$str"
    echo $wheFile
    wget $wheFile
 done
for files in `ls ./*.gz`
  do
      gunzip $files
  done
for files in `ls ./*.log`
  do
      mv $files `echo "$files.whe" `
  done
wenf=http://10.3.3.74:81/access1-
echo "This is printing $File"
for((i=$starttime;i<=$endtime;i+=86400)); do
    date=`date -d "@$i" "+%Y%m%d"`
    str=.log.gz
    wenFile="$wenf""$date""$str"
    echo $wenFile
    wget $wenFile
 done
for files in `ls ./*.gz`
  do
      gunzip $files
  done
for files in `ls ./*.log`
  do
      mv $files `echo "$files.wen" `
  done
HADOOP_HOME="/home/iprobe/program/hadoop-2.7.0"
FILE_HOME="/home/iprobe/script/timer/"
for((i=$starttime;i<=$endtime;i+=86400));
 do
  date=`date -d "@$i" "+%Y%m%d"`
  str=access1-
  wwwfile="$str""$date"".log.www"
  wappfile="$str""$date"".log.wapp"
  workfile="$str""$date"".log.wwork"
  wapfile="$str""$date"".log.wap"
  whefile="$str""$date"".log.whe"
  wenfile="$str""$date"".log.wen"
  month=${date:0:6}
$HADOOP_HOME/bin/hadoop fs -copyFromLocal $FILE_HOME$wwwfile  logdata/"$month"/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal $FILE_HOME$wappfile  logdata/"$month"/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal $FILE_HOME$workfile  logdata/"$month"/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal $FILE_HOME$wapfile  logdata/"$month"/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal $FILE_HOME$whefile  logdata/"$month"/
$HADOOP_HOME/bin/hadoop fs -copyFromLocal $FILE_HOME$wenfile  logdata/"$month"/
done
