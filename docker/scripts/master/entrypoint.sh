#!/bin/bash
# Spark Master entrypoint.sh
# exec gosu $SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master

# Doesn't work
# exec $SPARK_HOME/sbin/start-master.sh --properties-file $SPARK_HOME/conf/spark-defaults.conf

# python config
# . "$SPARK_HOME/sbin/spark-config.sh"

# spark-class is loading spark env
# . "$SPARK_HOME/bin/load-spark-env.sh"

exec $SPARK_HOME/bin/spark-class org.apache.spark.deploy.master.Master
