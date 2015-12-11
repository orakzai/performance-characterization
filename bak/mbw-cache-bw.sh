#!/bin/bash

cores=$1
memNode=0
count=0

for (( c=2; c<=5; c++ ))
do
count=$((count+1))
        if [ $count -gt  $cores ];
        then
                break
        else
                echo "Creating MBW on CPU $c "
                numactl --physcpubind=$c --membind=$memNode mbw -n 10000 -t0 -b 1000 500 | grep AVG &
        fi
done	
