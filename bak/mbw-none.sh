#!/bin/bash

memNode=1
echo "No Interference on Memory Subsystem"

for (( c=8; c<=13; c++ ))
do
	echo "Creating MBW on CPU $c "
	numactl --physcpubind=$c --membind=$memNode mbw -n 10000 -t0 -b 1000 500 | grep AVG &
done	
