#!/bin/bash
#ed to execute kafka producer
# history :
# 
# submit commond format : (cat ~/logdata/node/processing/ywsearch.log.2016-08-01 | bin/kafka-console-producer.sh --broker-list node11:9092 --topic node)


KAFKA_HOME=/home/iprobe/program/kafka_2.10-0.8.2.1
KAFKA_ARG="$KAFKA_HOME/bin/kafka-console-producer.sh --broker-list node11:9092 --topic search_log"
#JAVA_HOME=/home/iprobe/program/jdk1.8.0_65
#PATH=$PATH:$JAVA_HOME/bin

echo $KAFKA_HOME

if [ $# -ne 2 ]
then
        echo "error input ! "
        echo "please input arg : start date and end date"
        echo "example ./xxx.sh 20160726 20160727"
        exit

fi

dirstr=/home/data/ywsearch_log/*
filepre=ywsearch.log.

starttime=`date -d $1 +%s`
endtime=`date -d $2 +%s`

echo $starttime
echo $endtime

echo "-------------------------start $filename job-----------------------------" >>/script/timer/logs/kafkaProducerJob.log

#echo $File

for((i=$starttime;i<=$endtime;i+=86400)); do
    date=`date -d "@$i" "+%Y-%m-%d"`
    File=$dirstr/$filepre

    echo $date
    File=$File$date
    echo "-------------------------start $filename job-----------------------------" >> /script/timer/logs/kafkaProducerJob.log
    echo $File
#   submit job
    `cat $File | $KAFKA_ARG` >> /script/timer/logs/kafkaProducerJob.log

    echo "-------------------------end $filename job-----------------------------" >>/script/timer/logs/kafkaProducerJob.log
done

echo "all job is over!!" >>/script/timer/logs/kafkaProducerJob.log
