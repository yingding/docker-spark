#!/bin/sh
# Spark Master entrypoint.sh
# exec gosu $SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master
exec $SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master
