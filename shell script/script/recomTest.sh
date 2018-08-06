#!/bin/bash

SPARK_HOME=/home/iprobe/program/spark-2.2.0-bin-hadoop2.7
JOB_NAME="/home/iprobe/program/exec/iProbe/hc/recom/iRecom-timer-1.0.0.jar"
SPARK_ARG=" --class com.yiwugou.iRecom.timer.off.SparkTestMain2 --master spark://node18:7077 --driver-memory 10g --executor-memory 50g"

data=`date +%Y%m%d`
#echo $data
$SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME $data  >> ~/script/test/logs/recomJob.log
