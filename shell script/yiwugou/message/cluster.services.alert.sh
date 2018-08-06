# SYSNOPSIS:
#       cluster.services.alert.sh [option]
# DESCRIPTION:
#
# History:
# 2018/04/03    zhangguangfa    first
cd `dirname $0`
DEPLOY_DIR=`pwd`
MSGJar=$DEPLOY_DIR/ymmsg-1.0.0.jar
STDOUT_FILE=$DEPLOY_DIR/msg.cluster.alert.log
HADOOP_NAMENODE=org.apache.hadoop.hdfs.server.namenode.NameNode
HADOOP_ZKFC=org.apache.hadoop.hdfs.tools.DFSZKFailoverController
HADOOP_JOURNAL=org.apache.hadoop.hdfs.qjournal.server.JournalNode
HADOOP_DATANODE=org.apache.hadoop.hdfs.server.datanode.DataNode
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
function start_process()
{
        ID=`ssh $1 $2`
	echo -e "restart service  [$2] of [$1] !!!" >> $STDOUT_FILE
	echo -e "restart log: [$ID]" >> $STDOUT_FILE
	echo -e "restart log: [$ID]"
}

function check_process()
{
	MESSAGE=""
        ID=`ssh $1 ps -ef | grep -n $2 | grep -v 'grep' | awk '{print $2}'`

        if [ "$ID" ];then
                echo -e  "the [$2] of [$1]  is running, id:[$ID]" >> $STDOUT_FILE
       	else
		MESSAGE=$MESSAGE" ["$1"] -  ["$2"] service is down!!!\n "
		echo -e  "the [$2] of [$1]  is down!!!" >> $STDOUT_FILE
		if [ -n "$3" ]; then
			MESSAGE=$MESSAGE"\n   ###   "`start_process "$1" "$3"`
		fi 
        fi
        echo -e $MESSAGE
	return 1
}
function start()
{
	echo "" >> $STDOUT_FILE
	date >> $STDOUT_FILE
	echo "------------------------------------------------------------------" >> $STDOUT_FILE
	MESSAGE=""
        #check and restart  hadoop name node
        MESSAGE=$MESSAGE" "`check_process node11 $HADOOP_NAMENODE "$START_HADOOP_NAMENODE"`;
        MESSAGE=$MESSAGE" "`check_process node15 $HADOOP_NAMENODE "$START_HADOOP_NAMENODE"`;

	#check hadoop zkfc
        MESSAGE=$MESSAGE" "`check_process node11 $HADOOP_ZKFC "$START_HADOOP_ZKFC"`;
        MESSAGE=$MESSAGE" "`check_process node15 $HADOOP_ZKFC "$START_HADOOP_ZKFC"`;

        #check hadoop journal node
        MESSAGE=$MESSAGE" "`check_process node11 $HADOOP_JOURNAL`;
        MESSAGE=$MESSAGE" "`check_process node12 $HADOOP_JOURNAL`;
        MESSAGE=$MESSAGE" "`check_process node15 $HADOOP_JOURNAL`;
        MESSAGE=$MESSAGE" "`check_process node16 $HADOOP_JOURNAL`;
        MESSAGE=$MESSAGE" "`check_process node17 $HADOOP_JOURNAL`;

	#check hadoop date node
	MESSAGE=$MESSAGE" "`check_process node12 $HADOOP_DATANODE`;
	MESSAGE=$MESSAGE" "`check_process node13 $HADOOP_DATANODE`;
	MESSAGE=$MESSAGE" "`check_process node14 $HADOOP_DATANODE`;
	MESSAGE=$MESSAGE" "`check_process node15 $HADOOP_DATANODE`;
	MESSAGE=$MESSAGE" "`check_process node16 $HADOOP_DATANODE`;
	MESSAGE=$MESSAGE" "`check_process node17 $HADOOP_DATANODE`;

        #check hbase master node
        MESSAGE=$MESSAGE" "`check_process node11 $HBase_MASTER`;
        #MESSAGE=$MESSAGE" "`check_process node14 $HBase_MASTER`;
        MESSAGE=$MESSAGE" "`check_process node16 $HBase_MASTER`;

        #check hbase data node
        MESSAGE=$MESSAGE" "`check_process node12 $HBase_REGION`;
        MESSAGE=$MESSAGE" "`check_process node13 $HBase_REGION`;
        MESSAGE=$MESSAGE" "`check_process node14 $HBase_REGION`;
        MESSAGE=$MESSAGE" "`check_process node15 $HBase_REGION`;
        MESSAGE=$MESSAGE" "`check_process node16 $HBase_REGION`;
        MESSAGE=$MESSAGE" "`check_process node17 $HBase_REGION`;

        #check redis 6379
        MESSAGE=$MESSAGE"   "`check_process node11 $REDIS_6379`;
        MESSAGE=$MESSAGE" "`check_process node12 $REDIS_6379`;
        MESSAGE=$MESSAGE" "`check_process node13 $REDIS_6379`;
        MESSAGE=$MESSAGE" "`check_process node14 $REDIS_6379`;
        MESSAGE=$MESSAGE" "`check_process node15 $REDIS_6379`;
        MESSAGE=$MESSAGE" "`check_process node16 $REDIS_6379`;
        MESSAGE=$MESSAGE" "`check_process node17 $REDIS_6379`; 

        #check redis 6380
        MESSAGE=$MESSAGE" "`check_process node11 $REDIS_6380`;
        MESSAGE=$MESSAGE" "`check_process node12 $REDIS_6380`;
        MESSAGE=$MESSAGE" "`check_process node13 $REDIS_6380`;
        MESSAGE=$MESSAGE" "`check_process node14 $REDIS_6380`;
        MESSAGE=$MESSAGE" "`check_process node15 $REDIS_6380`;
        MESSAGE=$MESSAGE" "`check_process node16 $REDIS_6380`;
        MESSAGE=$MESSAGE" "`check_process node17 $REDIS_6380`;  

	#check mysql 
	MESSAGE=$MESSAGE" "`check_process node11 $MYSQL`;

	#check rockmq name server
	MESSAGE=$MESSAGE" "`check_process node11 $ROCKETMQ_NAMESVR`;
	MESSAGE=$MESSAGE" "`check_process node12 $ROCKETMQ_NAMESVR`;

	#check rockmq broker
	MESSAGE=$MESSAGE" "`check_process node11 $ROCKETMQ_BROKER`;
	MESSAGE=$MESSAGE" "`check_process node12 $ROCKETMQ_BROKER`;

	#check kafka
	MESSAGE=$MESSAGE" "`check_process node11 $KAFKA`;
	MESSAGE=$MESSAGE" "`check_process node12 $KAFKA`;
	MESSAGE=$MESSAGE" "`check_process node13 $KAFKA`;
	MESSAGE=$MESSAGE" "`check_process node14 $KAFKA`;
	MESSAGE=$MESSAGE" "`check_process node15 $KAFKA`;
	MESSAGE=$MESSAGE" "`check_process node16 $KAFKA`;
	MESSAGE=$MESSAGE" "`check_process node17 $KAFKA`;

	#check zookeeper
        MESSAGE=$MESSAGE" "`check_process node11 $ZOOKEEPER`;
        MESSAGE=$MESSAGE" "`check_process node12 $ZOOKEEPER`;
        MESSAGE=$MESSAGE" "`check_process node13 $ZOOKEEPER`;
        MESSAGE=$MESSAGE" "`check_process node14 $ZOOKEEPER`;
        MESSAGE=$MESSAGE" "`check_process node15 $ZOOKEEPER`;

	echo $MESSAGE
	echo "------------------------------------------------------------------" >> $STDOUT_FILE
        exit
}
function sendmsg(){
	MESSAGE=`start $1`
	echo $MESSAGE
	if [ -n "$MESSAGE" ]; then
		echo "send message" >> $STDOUT_FILE
		/home/iprobe/program/jdk1.8.0_65/bin/java -jar $MSGJar --phone-numbers "15210311644" --message "$MESSAGE" >> $STDOUT_FILE
	fi
}
#echo `start_process "node15" "$START_HADOOP_NAMENODE"`
sendmsg
exit
