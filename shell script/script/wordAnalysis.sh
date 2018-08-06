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
JOB_NAME="/home/iprobe/program/exec/iProbe/ojiao/paper/iProbeShop-timer-1.0.0.jar"
SPARK_ARG="--class com.yiwugou.iProbeShop.timer.sparkService.WordTimerTaskMain --master spark://node11:7077 --driver-memory 20g --executor-memory 50g"

#   submit job
    `($SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME &)` >>~/script/timer/logs/timerShopJob.log
    echo "$SPARK_HOME/bin/spark-submit $SPARK_ARG $JOB_NAME" >>~/script/timer/logs/timerShopJob.log
    echo "-------------------------end $filename job-----------------------------" >>~/script/timer/logs/timerShopJob.log

echo "###########################################################################" >>~/script/timer/logs/timerShopJob.log
echo "all job is over!!" >>~/script/timer/logs/timerShopJob.log


