#/bin/bash!
month=`date +%Y%m`
HADOOP_HOME="/home/iprobe/program/hadoop-2.7.0"
$HADOOP_HOME/bin/hadoop fs -mkdir  logdata/"$month"/
