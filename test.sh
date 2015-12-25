#!/bin/bash


totalTests=4
tests=4
#declare -A runtimeSuccess

runtimeSuccess[0]="success"
runtimeSuccess[1]="success"
runtimeSuccess[2]='success'
runtimeSuccess[3]='success'

declare -A runtime

runtime[0]='12.2'
runtime[1]='42.2'
runtime[2]='4.2'
runtime[3]='4.2'


#Print formatted times
avgNormal=0.0
avgBw=0.0
avgCache=0.0
avgBwCache=0.0

successNormal=0
successBw=0
successCache=0
successBwCache=0

for ((r=0; r<$totalTests; r++))
do
    interference="no"
     if (( $r%$tests == 0 )) && (( "${runtimeSuccess[$r]}" == 'success' ));
    # if [[ $r%$tests == 0 ]] && [[ "${runtimeSuccess[$r]}" == "success" ]];
    then
        #run normally no interference	
        interference="no"
        avgNormal=$(bc <<< "scale=6;$avgNormal + ${runtime[$r]}")
        successNormal=$successNormal + 1
        echo 'hol1 1'
    elif [[ $r%$tests == 1 ]] && [[ "${runtimeSuccess[$r]}" == 'success' ]];
    then
        #interference on bw
        interference="bw"
        avgBw=$(bc <<< "scale=6;$avgBw + ${runtime[$r]}")
        successBw=$successBw + 1
        echo 'hol1 2'
    elif [[ $r%$tests == 2 ]] && [[ "${runtimeSuccess[$r]}" == 'success' ]];
    then
        #interference on cache
        interference="cache"
        avgCache=$(bc <<< "scale=6;$avgCache + ${runtime[$r]}")
        successCache=$successCache + 1
        echo 'hol1 3'
    elif [[ $r%$tests == 3 ]] && [[ "${runtimeSuccess[$r]}" == 'success' ]];
    then
        #interference on bw + cache
        interference="bwcache"
        avgBwCache=$(bc <<< "scalej;=6;$avgBwCache + ${runtime[$r]}")
        successBwCache=$successBwCache + 1
        echo 'hol1 4'
    fi
echo $interference
   # printf "${FRAMEWORK},${APP_NAME},${CORUNNER},${interference},${runtimeSuccess[$r]},%.6f \n" ${runtime[$r]}   >> ${RESULTS_CSV}.bkp
  #printf "${FRAMEWORK},${APP_NAME},${CORUNNER},${interference},${runtimeSuccess[$r]}\t\t\t - Execution time $r: %.6f seconds\n" ${runtime[$r]} >> $RESULTS_FILE
done


