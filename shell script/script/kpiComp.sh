#!/bin/bash

# used to submit spark job 
# history :
# xiaozhuojian 20160726 first commit
# submit commond format : (spark-submit --class com.yiwugou.iProbe.dao.service.BaseInfoLogMain  \ 
#                                       --master spark://node11:7077 \
#                                       --driver-memory 40g \ 
#                                       --executor-memory 50g \
#                                       /home/iprobe/program/exec/iProbe/zmf/iProbe-dao-1.0.0.jar logdata/201607/access1-20160711.log.* &)


SPARK_HOME=/home/iprobe/program/spark-2.2.0-bin-hadoop2.7
JOB_NAME="/home/iprobe/program/exec/iProbe/zmf/iprobe/iProbe-service-1.0.0.jar"
parallelism=90
cores=90
drivermemory=30g
executormemory=30g
SPARK_ARG="--class com.yiwugou.iProbe.hbaseImport.service.LogToHBaseMain --master spark://node11:7077 --conf spark.default.parallelism=$parallelism --total-executor-cores $cores --driver-memory $drivermemory --executor-memory $executormemory"

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
for((i=$starttime;i<=$endtime;i+=86400)); do
    logdate=`date -d "@$i" "+%Y%m%d"`
    File=$logdate
    echo "-------------------------start $logdate job-----------------------------" >>  ~/script/timer/logs/kpijob.log
    echo $File
#   submit job
    `($SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME $File &)` >>  ~/script/timer/logs/kpijob.log
    echo "$SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME $File" >>  ~/script/timer/logs/kpijob.log
    echo "-------------------------end $logdate job-----------------------------" >> ~/script/timer/logs/kpijob.log
done

echo "###########################################################################" >>  ~/script/timer/logs/kpijob.log
echo "all job is over!!" >>  ~/script/timer/logs/kpijob.log


