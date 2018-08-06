cd `dirname $0`
DEPLOY_DIR=`pwd`
MSGJar=$DEPLOY_DIR/ymmsg-1.0.0.jar
STDOUT_FILE=$DEPLOY_DIR/msg.netstat.50070.log
IP_LIST="node11"

function check_port(){
    MESSAGE=`netstat -tnlpa | grep 50070 | awk -v host=$1 '{ print "["strftime("%Y-%m-%d %H:%M:%S",systime())"] [" host "] " $0"\n"}'` 
    if [ -n "$MESSAGE" ]; then
	echo $MESSAGE >> $STDOUT_FILE
    fi
}

for IP in $IP_LIST; do
    check_port $IP
done
