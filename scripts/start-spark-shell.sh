#!bin/bash
#sleep for a little to make sure that the namenode starts up and exits safemode
sleep 30


hadoop fs -mkdir data
hadoop fs -put /data/enron-data.json.gz data/

spark-shell
