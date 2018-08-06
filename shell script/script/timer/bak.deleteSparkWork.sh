#!/bin/bash  
today=`date -d "now" +%s`
direc="/home/iprobe/program/spark-2.2.0-bin-hadoop2.7/work/"  
  
for dir2del in $direc/* ; do
    if [[ $direc == *$today* ]]
     then
       echo $direc
    else   
        rm -rf $dir2del  
    fi  
    done 
