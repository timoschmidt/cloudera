#!/bin/bash

hadoop fs -rm -r /tmp
hadoop fs -mkdir /tmp
hadoop fs -chmod -R 1777 /tmp


hadoop fs -mkdir /var
hadoop fs -mkdir /var/lib
hadoop fs -mkdir /var/lib/hadoop-hdfs
hadoop fs -mkdir /var/lib/hadoop-hdfs/cache
hadoop fs -mkdir /var/lib/hadoop-hdfs/cache/mapred
hadoop fs -mkdir /var/lib/hadoop-hdfs/cache/mapred/mapred
hadoop fs -mkdir /var/lib/hadoop-hdfs/cache/mapred/mapred/staging
hadoop fs -chmod 1777 /var/lib/hadoop-hdfs/cache/mapred/mapred/staging
hadoop fs -chown -R mapred /var/lib/hadoop-hdfs/cache/mapred