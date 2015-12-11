#!/bin/bash

SPARK_DIR=~/spark/spark-1.5.2-bin-hadoop2.6/sbin/
$SPARK_DIR/stop-master.sh
$SPARK_DIR/stop-slave.sh spark://130.237.212.71:7077

ssh orak@sky2.it.kth.se ${SPARK_DIR}/stop-slave.sh spark://130.237.212.71:7077

