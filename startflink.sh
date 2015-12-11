#!/bin/bash

FLINK_DIR=~/flink/bin
numactl --physcpubind=1 --membind=1 $FLINK_DIR/jobmanager.sh start cluster batch
numactl --physcpubind=1 --membind=1 $FLINK_DIR/taskmanager.sh start batch

ssh orak@sky2.it.kth.se numactl --physcpubind=1 --membind=1 ${FLINK_DIR}/taskmanager.sh start batch

