#!/bin/bash

hadoop fs -rm -r /tmp
hadoop fs -mkdir /tmp
hadoop fs -chmod -R 1777 /tmp


hadoop fs -mkdir /tmp/hadoop-yarn/staging
hadoop fs -chmod -R 1777 /tmp/hadoop-yarn/staging
hadoop fs -mkdir /tmp/hadoop-yarn/staging/history/done_intermediate
hadoop fs -chmod -R 1777 /tmp/hadoop-yarn/staging/history/done_intermediate
hadoop fs -chown -R mapred:mapred /tmp/hadoop-yarn/staging
hadoop fs -mkdir /var/log/hadoop-yarn
hadoop fs -chown yarn:mapred /var/log/hadoop-yarn