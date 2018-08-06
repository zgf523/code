
IP_LIST="node12 node13 node14 node15 node16 node17"

######## delete spark temp file
work_dir="/home/iprobe/program/spark-2.2.0-bin-hadoop2.7/work/"
log_dir="/home/iprobe/program/spark-2.2.0-bin-hadoop2.7/logs/"
log_file="/home/iprobe/script/deleteTmpFile.log"

for ip in $IP_LIST
do

curTime=`date "+%Y-%m-%d %H:%M:%S"`
echo "start deleting [spark] temp file at [ $curTime ] [ $ip ]"

ssh $ip find $work_dir -mtime +0 | grep stdout | cut -f7 -d "/" | awk {'print "'"[ $curTime ] [ $ip ] $work_dir"'"$0'} >> $log_file
ssh $ip find $log_dir -mtime +1 | grep "spark.log" | awk {'print "'"[ $curTime ] [ $ip ] "'" $0'} >> $log_file

ssh $ip find $work_dir -mtime +0 | grep stdout | cut -f7 -d "/" | awk {'print "'"$work_dir"'"$0'} | xargs ssh $ip rm -rf
ssh $ip find $log_dir -mtime +1 | grep "spark.log" | xargs ssh $ip rm -f

done

######## delete kafka temp file
kafka_log="/home/iprobe/program/kafka_2.10-0.8.2.1/logs"
kafka_log_pattern="state-change.log|server.log|controller.log"

for ip in $IP_LIST
do

curTime=`date "+%Y-%m-%d %H:%M:%S"`
echo "start deleting [kafka] temp file at [ $curTime ] [ $ip ]"

ssh $ip find $kafka_log -mtime +6 | grep -E $kafka_log_pattern | awk {'print "'"[ $curTime ] [ $ip ] "'"$0'} >> $log_file
ssh $ip find $kafka_log -mtime +6 | grep -E $kafka_log_pattern | xargs ssh $ip rm -f

done

######## delete spark temp file from hdfs
HADOOP_URL="hdfs://10.6.30.131:9000/checkpoint/ hdfs://10.6.30.138:9000/checkpoint/"
curDate=`date "+%Y%m%d"`

for url in $HADOOP_URL
do
	curTime=`date "+%Y-%m-%d %H:%M:%S"`
	echo "start deleting [spark] temp file from [hdfs] at [ $curTime ] [ $url ]"
	for i in $(hadoop fs -ls $url | grep $url  | awk '{print $6"#"$8}' ); 
	do 
		itemDate=`echo $i | cut -d "#" -f 1 |awk -F "-" '{print  $1$2$3}'`
		itemDir=`echo $i | cut -d "#" -f 2`
		if [ $curDate -gt $itemDate ]
		then
			hadoop fs -rm -r $itemDir
			#echo $itemDir
			echo "[ $curTime ] "$i >> $log_file
		fi

	done
done 


