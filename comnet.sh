#!/bin/bash

option=$1

#stop the containers first before running others	
killall omnetpp_base.amd64-m64-gcc43-nn
#./killspec.sh
sleep 15 # wait for garbage collector to finish

if [ "$option" == "b" ];
then 
	echo "Creating omnet on BW "
#	numactl --physcpubind=2,4,6,8,10 --membind=1 mbw -n 10000 -t0 -b 1000 700 | grep AVG &         
	numactl --physcpubind=2 --membind=1  -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet & 
	numactl --physcpubind=4 --membind=1  -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=6 --membind=1  -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=8 --membind=1  -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=10 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
elif [ "$option" == "c" ];                
then
	echo "Creating omnet on Cache "
	#numactl --physcpubind=3,5,7,9,11 --membind=0 mbw -n 10000 -t0 -b 1000 500 | grep AVG &
	numactl --physcpubind=3 --membind=0 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=5 --membind=0 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=7 --membind=0 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=9 --membind=0 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=11 --membind=0 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet & 
elif [ "$option" == "a" ];                
then
	echo "Creating omnet on cache & BW "
	#numactl --physcpubind=3,5,7,9,11 --membind=1 mbw -n 10000 -t0 -b 1000 500 | grep AVG &
	numactl --physcpubind=3 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=5 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=7 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=9 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
	numactl --physcpubind=11 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 omnet &
fi
