#!/bin/bash

option=$1
LOG_FILE=~/scripts/logs/tmp.log

#stop the containers first before running others	
killall lbm_base.amd64-m64-gcc43-nn
sleep 15 #wait for garbage collector to finish
echo 'now start lbm'

if [ "$option" == "b" ];
then 
	echo "Creating LBM on BW " >> $LOG_FILE
#	numactl --physcpubind=2,4,6,8,10 --membind=1 mbw -n 10000 -t0 -b 1000 700 | grep AVG &         
	numactl --physcpubind=2 --membind=1  -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm & 
	numactl --physcpubind=4 --membind=1  -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
	numactl --physcpubind=6 --membind=1  -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
	numactl --physcpubind=8 --membind=1  -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
#	numactl --physcpubind=10 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
elif [ "$option" == "c" ];                
then
	echo "Creating LBM on Cache " >> $LOG_FILE
	#numactl --physcpubind=3,5,7,9,11 --membind=0 mbw -n 10000 -t0 -b 1000 500 | grep AVG &
	numactl --physcpubind=3 --membind=0 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
	numactl --physcpubind=5 --membind=0 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
	numactl --physcpubind=7 --membind=0 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
	numactl --physcpubind=9 --membind=0 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
#	numactl --physcpubind=11 --membind=0 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm & 
elif [ "$option" == "a" ];                
then
	echo "Creating LBM on cache & BW " >> $LOG_FILE
	#numactl --physcpubind=3,5,7,9,11 --membind=1 mbw -n 10000 -t0 -b 1000 500 | grep AVG &
	numactl --physcpubind=3 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
	numactl --physcpubind=5 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
	numactl --physcpubind=7 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
	numactl --physcpubind=9 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
#	numactl --physcpubind=11 --membind=1 -- runspec --config nav-gcc43.cfg --noreportable --iterations=1 lbm &
fi
