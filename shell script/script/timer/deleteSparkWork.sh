#!/bin/bash  
dir="/home/iprobe/program/spark-2.2.0-bin-hadoop2.7/work/"  

find $dir -mtime 1 | grep stdout | cut -f7 -d "/" | awk {'print "'"$dir"'"$0'} | xargs rm -rf
