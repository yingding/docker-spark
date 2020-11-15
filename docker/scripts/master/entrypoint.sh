#!/bin/sh
# Spark Master entrypoint.sh
# exec gosu $SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master
exec $SPARK_HOME/sbin/start-master.sh --properties-file $SPARK_HOME/conf/spark-defaults.conf
# exec $SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master
