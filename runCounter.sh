#!/bin/bash


ssh orak@sky2.it.kth.se ~/scripts/clbm.sh b &
#ssh orak@sky2.it.kth.se sudo ~/scripts/measureCounters.sh

i=22
ssh orak@sky2.it.kth.se sudo ~/scripts/measureCounters.sh "~/counters/$i" 
