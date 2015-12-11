
#!/bin/bash

option=$1

tests=4
runsPerTest=1 #change parameter to increase the runs
totalTests=$tests*$runsPerTest
SPARK_DIR=~/spark/spark-1.5.2-bin-hadoop2.6
RESULTS_DIR=~/scripts/results/
RESULTS_FILE=$RESULTS_DIR 
HADOOP_DIR=~/hadoop/bin/
if [ "$option" == "w" ];    
then 
    RESULTS_FILE="${RESULTS_FILE}SPARKwords.txt"
elif [ "$option" == "p" ];
then
    RESULTS_FILE="${RESULTS_FILE}SPARKpagerank.txt"
fi	

 declare -A runtime

#stop spark job manager  
#./build-target/bin/stop-local.sh
outputIP=hdfs://130.237.212.71:54310/user/orak/wordcount/output
outputDir=/user/orak/wordcount/output
inputDir=hdfs://130.237.212.71:54310/user/orak/wordcount
inputFile="$inputDir/README.txt"

#empty the output directory
$HADOOP_DIR/hadoop fs -rm -r  $outputDir/*
#ssh orak@sky2.it.kth.se $HADOOP_DIR/hadoop fs rm -r $outputDir/*


#echo "Running MASTER "
#	numactl --physcpubind=1 --membind=1 ./build-target/bin/start-local.sh
#	sleep 10

echo "Running Application on Spark"
for (( i=0; i<$totalTests; i++))
do
    if (($i/$runsPerTest == 0))
    then
        #run normally no interference	
        echo "No interference"
        ./cmbw.sh
        ssh orak@sky2.it.kth.se 'bash -s'  < cmbw.sh 
    elif (($i/$runsPerTest == 1))
    then
        #interference on bw
        ./cmbw.sh b
        ssh orak@sky2.it.kth.se 'bash -s'  < cmbw.sh b
    elif (($i/$runsPerTest == 2))
    then
        #interference on cache
        ./cmbw.sh c
        ssh orak@sky2.it.kth.se 'bash -s'  < cmbw.sh c
    elif (($i/$runsPerTest == 3))
    then
        #interference on bw + cache
        ./cmbw.sh a
        ssh orak@sky2.it.kth.se 'bash -s'  < cmbw.sh a
    fi

    echo "...Instance $i..."
    start=$(date +%s.%N)

    if [ "$option" == "w" ];
    then 
        numactl --physcpubind=1 --membind=1 $SPARK_DIR/bin/spark-submit --master spark://130.237.212.71:7077 --class WordCount ~/wordcount/target/wordcount-1.0.jar $inputFile  $outputIP/$i
    elif [ "$option" == "p" ];
    then
         numactl --physcpubind=1 --membind=1 $SPARK_DIR/bin/spark-submit --master spark://130.237.212.71:7077.. $inputDir/nodes.txt $inputDir/links.txt $outputDir/$i
    fi	
    end=$(date +%s.%N)
    runtime[$i]=$(echo "$end - $start" | bc)

done


#Print formatted times
avgNormal=0.0
avgBw=0.0
avgCache=0.0
avgCacheBw=0.0

for ((r=0; r<$totalTests; r++))
do
     if (($r/$runsPerTest == 0))
    then
        #run normally no interference	
        avgNormal=$(bc <<< "scale=6;$avgNormal + ${runtime[$r]}")
    elif (($r/$runsPerTest == 1))
    then
        #interference on bw
        avgBw=$(bc <<< "scale=6;$avgBw + ${runtime[$r]}")
    elif (($r/$runsPerTest == 2))
    then
        #interference on cache
        avgCache=$(bc <<< "scale=6;$avgCache + ${runtime[$r]}")
    elif (($r/$runsPerTest == 3))
    then
        #interference on bw + cache
        avgCacheBw=$(bc <<< "scale=6;$avgCacheBw + ${runtime[$r]}")
    fi

  printf "Execution time $r: %.6f seconds\n" ${runtime[$r]} >> $RESULTS_FILE
done

avgNormal=$(bc <<< "scale=6;$avgNormal/$runsPerTest")
avgBw=$(bc <<< "scale=6;$avgBw/$runsPerTest")
avgCache=$(bc <<< "scale=6;$avgCache/$runsPerTest")
avgCacheBw=$(bc <<< "scale=6;$avgCacheBw/$runsPerTest")

printf "==========================\n" >> $RESULTS_FILE
printf "Average Execution Times:\n" >> $RESULTS_FILE
printf "Normal:\t %.2f seconds\n" $avgNormal >> $RESULTS_FILE
printf "BW:\t %.2f seconds\n" $avgBw >> $RESULTS_FILE
printf "Cache:\t %.2f seconds\n" $avgCache >> $RESULTS_FILE
printf "CacheBW:\t%.2f seconds\n" $avgCacheBw  >> $RESULTS_FILE
printf "==========================\n" >> $RESULTS_FILE

printf "Average Degradation:\n" >> $RESULTS_FILE
printf "Normal:\t %.2f %%\n"  $(bc <<< "scale=6;($avgNormal-$avgNormal)*100/$avgNormal") >> $RESULTS_FILE
printf "BW:\t %.0f %%\n" $(bc <<< "scale=6;($avgBw-$avgNormal)*100/$avgNormal") >> $RESULTS_FILE
printf "Cache:\t %.2f %%\n" $(bc <<< "scale=6;($avgCache-$avgNormal)*100/$avgNormal") >> $RESULTS_FILE
printf "CacheBW:\t%.2f %%\n" $(bc <<< "scale=6;($avgCacheBw-$avgNormal)*100/$avgNormal") >> $RESULTS_FILE
printf "==========================\n" >> $RESULTS_FILE



