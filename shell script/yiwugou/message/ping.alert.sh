
cd `dirname $0`
DEPLOY_DIR=`pwd`
MSGJar=$DEPLOY_DIR/ymmsg-1.0.0.jar
STDOUT_FILE=$DEPLOY_DIR/msg.ping.alert.log
IP_LIST="node11 node12 node13 node14 node15 node16 node17 node18 node19 node20 node116 node117 node118 ubuntu195"

function ping_process()
{
    if ping -c 1 $1 >> /dev/null; then
        echo "$1 Ping is successful." >> $STDOUT_FILE
        continue
    fi
    #echo $MESSAGE
    return 1
}

function sendmsg(){
echo "" >> $STDOUT_FILE
date >> $STDOUT_FILE
echo "------------------------------------------------------------------" >> $STDOUT_FILE
for IP in $IP_LIST; do
    ping_process $IP
    ping_process $IP
    ping_process $IP
    MESSAGE=$MESSAGE"$IP Ping is failure!!!   "
done
echo "------------------------------------------------------------------" >> $STDOUT_FILE
if [ -n "$MESSAGE" ]; then
	#echo "send message" >> $STDOUT_FILE
/home/iprobe/program/jdk1.8.0_65/bin/java -jar $MSGJar --phone-numbers "15210311644" --message "$MESSAGE" >> $STDOUT_FILE
fi
}
#echo $result
#sendmsg $1
sendmsg
exit
