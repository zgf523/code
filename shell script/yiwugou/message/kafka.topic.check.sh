source /home/iprobe/.bash_profile

cd `dirname $0`
DEPLOY_DIR=`pwd`
MSGJar=$DEPLOY_DIR/ymmsg-1.0.0.jar
STDOUT_FILE=$DEPLOY_DIR/msg.kafka.topic.check.log
KAFKA_PATH="/home/iprobe/program/kafka_2.10-0.8.2.1/bin"
BROKER_LIST="node11:9092,node11:9092,node12:9092,node13:9092,node14:9092,node15:9092,node16:9092,node17:9092"
TOPIC_LIST="flume-kafka-test flume-kafka-test-app flume-kafka-test-en flume-kafka-test-hjh"

TOPIC_NUM=`echo $TOPIC_LIST | wc -w`

function sendmsg(){

curTime=`date "+%Y-%m-%d--%H:%M:%S"`

for line in $(tail -n $TOPIC_NUM $STDOUT_FILE)
do

topic=`echo $line | cut -d "#" -f 2`
priorData=`echo $line | cut -d "#" -f 3`
curData=`$KAFKA_PATH/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list $BROKER_LIST --topic $topic  --time -1 | cut -d ":" -f 3 | tr '\n' ','`
if [ "$curData" = "$priorData" ]
then
	MESSAGE=$MESSAGE" "$topic" lost data!"
fi

done


for topic in $TOPIC_LIST
do

curData=`/home/iprobe/program/kafka_2.10-0.8.2.1/bin/kafka-run-class.sh kafka.tools.GetOffsetShell --broker-list $BROKER_LIST --topic $topic  --time -1 | cut -d ":" -f 3 | tr '\n' ','`
echo "[$curTime]#$topic#$curData" >> $STDOUT_FILE

done


if [ -n "$MESSAGE" ]; then
	#echo "123"
	#echo "send message" >> $STDOUT_FILE
	/home/iprobe/program/jdk1.8.0_65/bin/java -jar $MSGJar --phone-numbers "15210311644" --message "$MESSAGE"
fi
}

sendmsg
exit
