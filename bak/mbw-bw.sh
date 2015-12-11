#!/bin/bash

cores=$1
memNode=0
echo " Interference on BW"
count=0

for (( c=8; c<=13; c++ ))
do
count=$((count+1))
        if [ $count -gt  $cores ];
        then
                break
        else
                echo "Creating MBW on CPU $c "
                numactl --physcpubind=$c --membind=$memNode mbw -n 10000 -t0 -b 1000 700 | grep AVG &
        fi
done	
