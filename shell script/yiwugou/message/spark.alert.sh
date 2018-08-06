
cd `dirname $0`
DEPLOY_DIR=`pwd`
MSGJar=$DEPLOY_DIR/ymmsg-1.0.0.jar
STDOUT_FILE=$DEPLOY_DIR/msg.spark.alert.log
EXCLUDE_TASKS=('"recomOn"' )
#EXCLUDE_TASKS=('"recomOn1"'  '"recomOn2"')

function get_process_duration()
{
#start timestamp milisecond
duration=0
data=`curl -s http://node11:$1/api/v1/applications`
#echo "$data" >> $STDOUT_FILE
#`$data >> $STDOUT_FILE`
if [ -n "$data" ]; then 
	echo "$data" >> $STDOUT_FILE
	name=`echo $data | jq '.[0].name'`
	start=`echo $data | jq '.[].attempts' | jq '.[0].startTimeEpoch'`
	start=$((start/1000))
	#current timestamp second
	current=`date +%s`
	duration=$(((current-start)/60))
	#echo $start
	echo "spark task $name duration is $duration (minutes);" >> $STDOUT_FILE
	for task in ${EXCLUDE_TASKS[@]}; do
	#echo "$task" >> $STDOUT_FILE
	#if [ "$name" = '"recomOn"' -a $duration > 20 ]; then
	    if [ "$name" != "$task" -a $duration -gt 60 ]; then
		echo "spark task $name duration is $duration (minutes);"
	    fi
	done
fi
return 1
}

function get_process_by_name(){
for i in {4040..4050}
do
	message=$message" "`get_process_duration $i $1`
done
echo $message	
}

function sendmsg(){
echo "" >> $STDOUT_FILE
date >> $STDOUT_FILE
echo "------------------------------------------------------------------" >> $STDOUT_FILE
MESSAGE=`get_process_by_name $1`
echo "------------------------------------------------------------------" >> $STDOUT_FILE
if [ -n "$MESSAGE" ]; then
	#echo "send message" >> $STDOUT_FILE
/home/iprobe/program/jdk1.8.0_65/bin/java -jar $MSGJar --phone-numbers "15210311644" --message "$MESSAGE" >> $STDOUT_FILE
fi
}
#echo $result
sendmsg $1
exit
