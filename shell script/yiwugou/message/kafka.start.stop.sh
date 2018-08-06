# SYSNOPSIS:
#       cluster.services.alert.sh [option]
# DESCRIPTION:
#
# History:
# 2018/04/03    zhangguangfa    first
cd `dirname $0`
DEPLOY_DIR=`pwd`
MSGJar=$DEPLOY_DIR/ymmsg-1.0.0.jar
STDOUT_FILE=$DEPLOY_DIR/msg.start.stop.service.log
HADOOP_NAMENODE=org.apache.hadoop.hdfs.server.namenode.NameNode
HADOOP_ZKFC=org.apache.hadoop.hdfs.tools.DFSZKFailoverController
HADOOP_JOURNAL=org.apache.hadoop.hdfs.qjournal.server.JournalNode
HBase_MASTER=org.apache.hadoop.hbase.master.HMaster
HBase_REGION=org.apache.hadoop.hbase.regionserver.HRegionServer
REDIS_6379="redis-server.*6379"
REDIS_6380="redis-server.*6380"
MYSQL=mysqld_safe
ROCKETMQ_BROKER="org.apache.rocketmq.broker.BrokerStartup"
ROCKETMQ_NAMESVR="org.apache.rocketmq.namesrv.NamesrvStartup"
KAFKA=kafka.Kafka
ZOOKEEPER=org.apache.zookeeper.server.quorum.QuorumPeerMain

START_HADOOP_NAMENODE="/home/iprobe/program/hadoop-2.7.0/sbin/hadoop-daemon.sh start namenode"
START_HADOOP_ZKFC="/home/iprobe/program/hadoop-2.7.0/sbin/hadoop-daemon.sh start zkfc"
START_KAFKA="/home/iprobe/program/kafka_2.10-0.8.2.1/bin/kafka-server-start.sh -daemon /home/iprobe/program/kafka_2.10-0.8.2.1/config/server.properties"
STOP_KAFKA="/home/iprobe/program/kafka_2.10-0.8.2.1/bin/kafka-server-stop.sh"

function process()
{
        ID=`ssh $1 $2`
	echo -e "service  [$2] of [$1] !!!" >> $STDOUT_FILE
	echo -e "log: [$ID]" >> $STDOUT_FILE
	echo -e "restart log: [$ID]"
}

function start()
{
	echo "" >> $STDOUT_FILE
	date >> $STDOUT_FILE
	echo "------------------------------------------------------------------" >> $STDOUT_FILE
	MESSAGE=""

	#check kafka
	MESSAGE=$MESSAGE" "`process node11 "$START_KAFKA"`;
	MESSAGE=$MESSAGE" "`process node12 "$START_KAFKA"`;
	#MESSAGE=$MESSAGE" "`process node13 $START_KAFKA`;
	#MESSAGE=$MESSAGE" "`process node14 $START_KAFKA`;
	#MESSAGE=$MESSAGE" "`process node15 $START_KAFKA`;
	#MESSAGE=$MESSAGE" "`process node16 $START_KAFKA`;
	#MESSAGE=$MESSAGE" "`process node17 $START_KAFKA`;

	echo $MESSAGE
	echo "------------------------------------------------------------------" >> $STDOUT_FILE
        exit
}

function stop()
{
        echo "" >> $STDOUT_FILE
        date >> $STDOUT_FILE
        echo "------------------------------------------------------------------" >> $STDOUT_FILE
        MESSAGE=""

        #check kafka
        MESSAGE=$MESSAGE" "`process node11 $STOP_KAFKA`;
        MESSAGE=$MESSAGE" "`process node12 $STOP_KAFKA`;
        MESSAGE=$MESSAGE" "`process node13 $STOP_KAFKA`;
        MESSAGE=$MESSAGE" "`process node14 $STOP_KAFKA`;
        MESSAGE=$MESSAGE" "`process node15 $STOP_KAFKA`;
        MESSAGE=$MESSAGE" "`process node16 $STOP_KAFKA`;
        MESSAGE=$MESSAGE" "`process node17 $STOP_KAFKA`;

        echo $MESSAGE
        echo "------------------------------------------------------------------" >> $STDOUT_FILE
        exit
}

#echo `start_process "node15" "$START_HADOOP_NAMENODE"`
if [ $1 == "start" ]; then echo $1 "start"; start; fi
if [ $1 == "stop" ]; then echo $1 "stop"; stop; fi
exit
