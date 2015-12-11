#!/bin/bash

for i in {12..24..1}
do
        echo 0 > /sys/devices/system/cpu/cpu$i/online
        echo "Thread "$i" is disabled"
done

