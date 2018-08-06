#!/bin/bash
# used to execute kafka producer
# history :
# 
# submit commond format : (cat ~/logdata/node/processing/ywsearch.log.2016-08-01 | bin/kafka-console-producer.sh --broker-list node11:9092 --topic node)


KAFKA_HOME=~/program/kafka_2.10-0.8.2.1
KAFKA_ARG="$KAFKA_HOME/bin/kafka-console-producer.sh --broker-list node11:9092 --topic search_log"
JAVA_HOME=/home/iprobe/program/jdk1.8.0_65
PATH=$PATH:$JAVA_HOME/bin

echo $KAFKA_HOME

dirstr=/home/data/ywsearch_log/*
filepre=ywsearch.log.


date=`date -d last-day +%Y-%m-%d`  
#yesterday='2016-08-01' 
File=$dirstr/$filepre$date

echo "-------------------------start $filename job-----------------------------" >>~/script/timer/logs/kafkaProducerJob.log 

echo $File

# `cat $File | $KAFKA_HOME/bin/kafka-console-producer.sh $KAFKA_ARG`

`/bin/cat $File \
	| $KAFKA_ARG` 

echo "all job is over!!" >>~/script/timer/logs/kafkaProducerJob.log


