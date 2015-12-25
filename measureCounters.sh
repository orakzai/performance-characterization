#!/bin/bash

resultsDir=$1

if [[ -z $resultsDir ]];
then
    resultsDir='~/scripts/results/counters/default/'
fi


cd ~/scripts/PMU-burst/
sudo python measure.py -cd $resultsDir &
cd ~/scripts/

#wait so that application has started already
sleep 5
