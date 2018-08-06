#!/bin/bash
# used to submit spark job 
# history :
# xiaozhuojian 20160726 first commit
# submit commond format : (spark-submit --class com.yiwugou.iProbe.dao.service.BaseInfoLogMain  \ 
#                                       --master spark://node11:7077 \
#                                       --driver-memory 40g \ 
#                                       --executor-memory 50g \
#                                       /home/iprobe/program/exec/iProbe/zmf/iProbe-dao-1.0.0.jar logdata/201607/access1-20160711.log.* &)


SPARK_HOME=/home/iprobe/program/spark-1.6.0-bin-hadoop2.6
JOB_NAME="/home/iprobe/research/program/iProbe-service-1.0.0.jar"
SPARK_ARG="--class com.yiwugou.iProbe.dao.user.expe.BaseInfoLogMain4 --master spark://node11:7077 --driver-memory 10g --executor-memory 30g"

if [ $# -ne 2 ]
then 
	echo "error input ! "
	echo "please input arg : start date and end date"
	echo "example ./xxx.sh 20160726 20160727"
	exit
fi

starttime=`date -d $1 +%s`
endtime=`date -d $2 +%s`

echo $SPARK_HOME
echo $JOB_NAME
echo $starttime
echo $endtime
dirstr=logdata/
filepre=access1-
filesuf=.log.*
for((i=$starttime;i<=$endtime;i+=86400)); do
    dirname=`date -d "@$i" "+%Y%m"`
    filename=`date -d "@$i" "+%Y%m%d"`
    File=$dirstr$dirname/$filepre$filename$filesuf
    echo "-------------------------start $logdate job-----------------------------" >>  ~/script/timer/logs/kpijob.log
    echo $File
#   submit job
    `($SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME $File &)` >>  ~/script/timer/logs/kpijob.log
    echo "$SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME $File" >>  ~/script/timer/logs/kpijob.log
    echo "-------------------------end $logdate job-----------------------------" >> ~/script/timer/logs/kpijob.log
done

echo "###########################################################################" >>  ~/script/timer/logs/kpijob.log
echo "all job is over!!" >>  ~/script/timer/logs/kpijob.log


