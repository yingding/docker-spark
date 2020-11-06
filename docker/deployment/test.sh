#!/bin/sh
# since using the default shell in Ubuntu is dash, the bash feature map
# Redirect <<< or < <
# https://stackoverflow.com/questions/10948849/bash-for-loop-with-multiline-output-from-a-command
# Array, mapfile
# https://stackoverflow.com/questions/11426529/reading-output-of-a-command-into-an-array-in-bash
# https://stackoverflow.com/questions/41345039/how-to-read-multiline-input-into-an-array-in-bash-shell-script
# are not available

COMPOSE_CONFIG_DIR=/home/analytics/docker-spark/docker/deployment
# TODO: change the name of your docker-compose xxx.yml config file
COMPOSE_FILE_NAME=docker-compose-standalone-server.yml

# generated absolute path to the docker-compose config file
COMPOSE_CONFIG_PATH=${COMPOSE_CONFIG_DIR}/${COMPOSE_FILE_NAME}
service_name="spark-worker"

while read LINE
do
  echo "$LINE"
done < <(`docker-compose -f $COMPOSE_CONFIG_PATH ps -q $service_name`)

#
# [ -z `docker ps -q --no-trunc | grep "$(docker-compose -f $COMPOSE_CONFIG_PATH ps -q $service_name)"` ] && echo "Isn't running" || echo "Running"
