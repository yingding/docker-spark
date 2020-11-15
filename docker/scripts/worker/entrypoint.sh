#!/bin/sh
# Spark Worker entrypoint.sh
# exec gosu $SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker -c $CORES -m $MEMORY spark://$MASTER_CONTAINER_NAME:7077
# exec $SPARK_HOME/bin/spark-class org.apache.spark.deploy.worker.Worker -c $CORES -m $MEMORY --properties-file $SPARK_HOME/conf/spark-defaults.conf spark://${MASTER_CONTAINER_NAME}:${MASTER_CONTAINER_PORT}

exec $SPARK_HOME/sbin/start-slave.sh -c $CORES -m $MEMORY --properties-file $SPARK_HOME/conf/spark-defaults.conf spark://${MASTER_CONTAINER_NAME}:${MASTER_CONTAINER_PORT}
