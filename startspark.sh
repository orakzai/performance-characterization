#!/bin/bash

SPARK_DIR=~/spark/spark-1.5.2-bin-hadoop2.6/sbin/
numactl --physcpubind=1 --membind=1 $SPARK_DIR/start-master.sh
numactl --physcpubind=1 --membind=1 $SPARK_DIR/start-slave.sh spark://130.237.212.71:7077

ssh orak@sky2.it.kth.se numactl --physcpubind=1 --membind=1 ${SPARK_DIR}/start-slave.sh spark://130.237.212.71:7077

