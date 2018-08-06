#!/bin/bash
if [ $# -ne 2 ]
then
	echo "error !! input start date and end date : formate ./wgeturl start end"
	echo "eg: ./wgeturl 2017-01-01 2017-06-01"
	exit
fi
f [ $# -ge 1 ];
#echo "$#"
startdate=$1
enddate=$2
starttime=`date -d "$1" +%s`
endtime=`date -d "$2" +%s`
echo "start time : $starttime" 
echo "end time : $endtime" 
f=http://10.3.3.110:81/access1-
echo "This is printing $File"
for((i=$starttime;i<=$endtime;i+=86400)); do
    date=`date -d "@$i" "+%Y%m%d"`
    str=.log.gz
    File="$f""$date""$str"
    echo $File
    wget $File
done
