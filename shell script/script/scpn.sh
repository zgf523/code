#!/bin/bash
#scp files to node12 node13 node14 node15
#./scpn filename dric [-r]
#xiaozhuojian
#history: 2016.2.22
FLAG=
node12=10.6.30.132
node13=10.6.30.133
node14=10.6.30.134
node15=10.6.30.135
node16=10.6.30.136
node17=10.6.30.137

function scpn()
{
	if [ $# -eq 3 ]; then
		FLAG=$3
		scp ${FLAG} $1 ${node12}:$2
		echo "---------------node12 ok----------------"
		scp ${FLAG} $1 ${node13}:$2
		echo "---------------node13 ok----------------"
		scp ${FLAG} $1 ${node14}:$2
		echo "---------------node14 ok----------------"
		scp ${FLAG} $1 ${node15}:$2
		echo "---------------node15 ok----------------"
                scp ${FLAG} $1 ${node16}:$2
                echo "---------------node16 ok----------------"
                scp ${FLAG} $1 ${node17}:$2
                echo "---------------node17 ok----------------"
	else
		scp $1 ${node12}:$2
		echo "---------------node12 ok----------------"
		scp $1 ${node13}:$2
		echo "---------------node13 ok----------------"
		scp $1 ${node14}:$2
		echo "---------------node14 ok----------------"
		scp $1 ${node15}:$2
		echo "---------------node15 ok----------------"
                scp ${FLAG} $1 ${node16}:$2
                echo "---------------node16 ok----------------"
                scp ${FLAG} $1 ${node17:$2
                echo "---------------node17 ok----------------"
	fi
}

scpn $1 $2 $3 
