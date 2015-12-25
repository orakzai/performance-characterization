#!/bin/bash

resultsDir=$1

if [[ -z $resultsDir ]];
then
    resultsDir='~/scripts/results/counters/default/'
fi


cd ~/scripts/PMU-burst/
sudo python processplot.py -cd $resultsDir &
cd ~/scripts/

