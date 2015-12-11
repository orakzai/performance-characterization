#!/bin/bash

option=$1

#stop the containers first before running others	
lxc-stop -n mbw-container1 -k
lxc-stop -n mbw-container2 -k
lxc-stop -n mbw-container3 -k
lxc-stop -n mbw-container4 -k
lxc-stop -n mbw-container5 -k

if [ "$option" == "b" ];
then 
	echo "Creating MBW on BW "
#	numactl --physcpubind=2,4,6,8,10 --membind=1 mbw -n 10000 -t0 -b 1000 700 | grep AVG &         
	numactl --physcpubind=2 --membind=1 lxc-start -n mbw-container1 -d -- mbw -n 10000 -t0 -b 1000 500
	numactl --physcpubind=4 --membind=1 lxc-start -n mbw-container2 -d -- mbw -n 10000 -t0 -b 1000 500
	numactl --physcpubind=6 --membind=1 lxc-start -n mbw-container3 -d -- mbw -n 10000 -t0 -b 1000 500
	numactl --physcpubind=8 --membind=1 lxc-start -n mbw-container4 -d -- mbw -n 10000 -t0 -b 1000 500 
	numactl --physcpubind=10 --membind=1 lxc-start -n mbw-container5 -d -- mbw -n 10000 -t0 -b 1000 500 
elif [ "$option" == "c" ];                
then
	echo "Creating MBW on Cache "
	#numactl --physcpubind=3,5,7,9,11 --membind=0 mbw -n 10000 -t0 -b 1000 500 | grep AVG &
	numactl --physcpubind=3 --membind=0  lxc-start -n mbw-container1 -d -- mbw -n 10000 -t0 -b 1000 500
	numactl --physcpubind=5 --membind=0  lxc-start -n mbw-container2 -d -- mbw -n 10000 -t0 -b 1000 500
	numactl --physcpubind=7 --membind=0  lxc-start -n mbw-container3 -d -- mbw -n 10000 -t0 -b 1000 500
	numactl --physcpubind=9 --membind=0  lxc-start -n mbw-container4 -d -- mbw -n 10000 -t0 -b 1000 500 
	numactl --physcpubind=11 --membind=0  lxc-start -n mbw-container5 -d -- mbw -n 10000 -t0 -b 1000 500 
elif [ "$option" == "a" ];                
then
	echo "Creating MBW on cache & BW "
	#numactl --physcpubind=3,5,7,9,11 --membind=1 mbw -n 10000 -t0 -b 1000 500 | grep AVG &
	numactl --physcpubind=3 --membind=1  lxc-start -n mbw-container1 -d -- mbw -n 10000 -t0 -b 1000 500 
	numactl --physcpubind=5 --membind=1  lxc-start -n mbw-container2 -d -- mbw -n 10000 -t0 -b 1000 500
	numactl --physcpubind=7 --membind=1  lxc-start -n mbw-container3 -d -- mbw -n 10000 -t0 -b 1000 500 
	numactl --physcpubind=9 --membind=1  lxc-start -n mbw-container4 -d -- mbw -n 10000 -t0 -b 1000 500 
	numactl --physcpubind=11 --membind=1  lxc-start -n mbw-container5 -d -- mbw -n 10000 -t0 -b 1000 500 
fi
