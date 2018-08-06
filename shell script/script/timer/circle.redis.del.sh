
log="~/script/timer/logs/circle.log";

for i in {1..7}
do


curtime=`date +"%Y-%m-%d--%H:%M:%S"`
echo [$curtime]" server: node1"$i";port: 6379"  >> ~/script/timer/logs/circle.log;
echo "keys circle:recommend:* " |  
redis-cli -c -h node1$i -p 6379 |  
awk '$0!~/^$/ {print "echo \"ttl "$0"\" | redis-cli -c -h node1'$i' -p 6379 | awk '\''$0==-1  {cmd=\"echo \\\"del "$0"\\\" | redis-cli -c -h node1'$i' -p 6379\"; system(cmd); print \"['$curtime'] "$0"\"}'\'' "}' | bash >> ~/script/timer/logs/circle.log;


curtime=`date +"%Y-%m-%d--%H:%M:%S"`
echo [$curtime]" server: node1"$i";port: 6380"  >> ~/script/timer/logs/circle.log;
echo "keys circle:recommend:* " |
redis-cli -c -h node1$i -p 6380 |
awk '$0!~/^$/ {print "echo \"ttl "$0"\" | redis-cli -c -h node1'$i' -p 6380 | awk '\''$0==-1  {cmd=\"echo \\\"del "$0"\\\" | redis-cli -c -h node1'$i' -p 6380\"; system(cmd); print \"['$curtime'] "$0"\"}'\'' "}' | bash >> ~/script/timer/logs/circle.log;


done
