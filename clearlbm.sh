#!/bin/bash

LOG_FILE=logs/tmp.log
FRAMEWORK='flink'
CORUNNER='clbm.sh'
totalTests=2
tests=4

for (( i=0; i<$totalTests; i++))
do
    #echo "[$(date)] - Starting ${FRAMEWORK}" >> $LOG_FILE
    #./$START_FRAMEWORK
    #echo "[$(date)] - Started ${FRAMEWORK}" >> $LOG_FILE
    echo '===================================' >> $LOG_FILE
    echo "[$(date)] - Starting ${CORUNNER}" >> $LOG_FILE

    interference='no'

    if (($i%($tests) == 5))
    then
        #run normally no interference	
        echo "[$(date)] - no interference local" >> $LOG_FILE
        $CORUNNER
        echo "[$(date)] - no interference sky2" >> $LOG_FILE
        #ssh -n orak@sky2.it.kth.se  -- "nohup /bin/bash -l \"${CORUNNER}\" &"
        ssh -n orak@sky2.it.kth.se -- "nohup /bin/bash -l $CORUNNER  &"
        interference='no'
    elif (($i%($tests) == 1))
    then
        #interference on bw
        echo "[$(date)] - bw local" >> $LOG_FILE
        #./$CORUNNER b
        echo "[$(date)] - bw remote" >> $LOG_FILE
        ssh -n -f orak@sky2.it.kth.se "sh -c 'cd /home/orak/scripts/; nohup ./$CORUNNER b > foo.out 2>foo.err < /dev/null &'"
        #ssh -n -f orak@sky2.it.kth.se "sh -c 'cd /home/orak/scripts/; nohup ./clbm.sh b > /dev/null 2>&1 &'"
#        ssh -f orak@sky2.it.kth.se "nohup /bin/bash -l /home/orak/scripts/clbm.sh b"
        #ssh -n orak@sky2.it.kth.se -- "nohup /bin/bash -l $CORUNNER b &"
       # ssh -n orak@sky2.it.kth.se -- "nohup /bin/bash -l \"/home/orak/scripts/clbm.sh\" b &"
        #ssh orak@sky2.it.kth.se 'bash -s'  < $CORUNNER b
        interference='bw'
    elif (($i%($tests) == 2))
    then
        #interference on cache
        echo "[$(date)] - cache local" >> $LOG_FILE
        $CORUNNER c
        echo "[$(date)] - cache remote" >> $LOG_FILE
        #ssh orak@sky2.it.kth.se 'bash -s'  < $CORUNNER c
        ssh -n orak@sky2.it.kth.se -- "nohup /bin/bash -l $CORUNNER c &"
        interference='cache'
    elif (($i%($tests) == 3))
    then
        #interference on bw + cache
        echo "[$(date)] - bwcache local" >> $LOG_FILE
        $CORUNNER a
        echo "[$(date)] - bwcache remote" >> $LOG_FILE
        #ssh orak@sky2.it.kth.se 'bash -s'  < $CORUNNER a
        ssh -n orak@sky2.it.kth.se -- "nohup /bin/bash -l $CORUNNER a &"
        interference='bwcache'
    fi
    echo "[$(date)] - Finished Started ${CORUNNER}" >> $LOG_FILE
        
    sleep 10 # wait here for framework and corrunners to properly start
done
