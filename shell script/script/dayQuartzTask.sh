#!/bin/bash
# history :
# xiaozhuojian 20160726 first commit
# submit commond format : (spark-submit --class com.yiwugou.iProbe.dao.service.BaseInfoLogMain  \ 
#                                       --master spark://node11:7077 \
#                                       --driver-memory 40g \ 
#                                       --executor-memory 50g \
#                                       /home/iprobe/program/exec/iProbe/zmf/iProbe-dao-1.0.0.jar logdata/201607/access1-20160711.log.* &)

let YEAR=$(date "+%Y")
let MONTH=$(date "+%m")

if [ $MONTH -eq 1 ]
then
  let YEAR=YEAR-1
  LASTYM=$(printf "%d-%.2d\n" $YEAR 12)
else
  let MONTH=MONTH-1
  LASTYM=$(printf "%d-%.2d\n" $YEAR $MONTH)
fi

echo $LASTYM
SPARK_HOME=/home/iprobe/program/spark-1.6.0-bin-hadoop2.6
JOB_NAME="/home/iprobe/program/exec/iProbe/zmf/iProbe-dao-1.0.0.jar"
SPARK_ARG="--class com.yiwugou.iProbe.dao.service.QuartzMonthTaskMain --master spark://node11:7077 --driver-memory 5g --executor-memory 10g"

echo $SPARK_HOME
echo $JOB_NAME
echo $lastmonth
#   submit job
    `($SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME $LASTYM &)` >> monthQuartzJob
    echo "$SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME $LASTYM" >>monthQuartzJob
    echo "-------------------------end $month job-----------------------------" >> monthQuartzJob
done

echo "###########################################################################" >> monthQuartzJob
echo "all job is over!!" >> monthQuartzJob.log
