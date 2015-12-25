#!/bin/bash


sudo ./stopMeasureCounters.sh
ps -ef | grep testboth.sh | grep -v grep | awk '{print $2}' | xargs kill -9
ps -ef | grep allboth.sh | grep -v grep | awk '{print $2}' | xargs kill -9

ps -ef | grep flink | grep -v grep | awk '{print $2}' | xargs kill -9
ps -ef | grep spark | grep -v grep | awk '{print $2}' | xargs kill -9

ps aux | grep run_base | grep -v grep | awk '{print $2}' | xargs kill


