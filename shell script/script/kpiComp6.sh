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
JOB_NAME="/home/iprobe/research/program/iProbe-service-1.0.0.jar"
parallelism=36
core=36
drivermemory=10g
executormemory=20g
SPARK_ARG="--class com.yiwugou.iProbe.dao.user.expe.BaseInfoLogMain6 --master spark://node18:7077 --conf spark.default.parallelism=$parallelism --total-executor-cores $core --driver-memory $drivermemory --executor-memory $executormemory"

if [ $# -ne 1 ]
then 
	echo "error input ! "
	echo "please input arg : start date and end date"
	echo "example ./xxx.sh 1012a"
	exit
fi

filename=$1

echo $SPARK_HOME
echo $JOB_NAME
dirstr=expe
filepre=log
File=$dirstr/$filepre$filename    
    echo "-------------------------start $logdate job-----------------------------" >>  ~/script/timer/logs/kpijob.log
    echo $File
#   submit job
    `($SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME $File &)` >>  ~/script/timer/logs/kpijob.log
    echo "$SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME $File" >>  ~/script/timer/logs/kpijob.log
    echo "-------------------------end $logdate job-----------------------------" >> ~/script/timer/logs/kpijob.log

echo "###########################################################################" >>  ~/script/timer/logs/kpijob.log
echo "all job is over!!" >>  ~/script/timer/logs/kpijob.log


