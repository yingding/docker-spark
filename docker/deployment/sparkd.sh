#!/bin/sh
#
# init.d script with LSB support.
#
# Copyright (c) 2020 Yingding Wang <yingding.wang@lmu.de>
#
# This is free software; you may redistribute it and/or modify
# it under the terms of the GNU General Public License as
# published by the Free Software Foundation; either version 2,
# or (at your option) any later version.
#
# This is distributed in the hope that it will be useful, but
# WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License with
# the Debian operating system, in /usr/share/common-licenses/GPL;  if
# not, write to the Free Software Foundation, Inc., 59 Temple Place,
# Suite 330, Boston, MA 02111-1307 USA
#
### BEGIN INIT INFO
# Provides:          sparkd
# Required-Start:    $network $local_fs $remote_fs docker
# Required-Stop:     $network $local_fs $remote_fs docker
# Should-Start:      $named
# Should-Stop:
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Custom init.d script of Apache Spark Cluster for distributed computing residing in Docker Containers
# Description:       Custom init.d script using docker-compose to start/stop the pre-existing Apache Spark Cluster
#                    residing in docker containers
#
#                    * containers shall be created ahead
#
#
### END INIT INFO

DOCKER_ENGINE=docker
COMPOSE_BINARY=docker-compose
# path to the docker compose config file
COMPOSE_CONFIG_DIR=""
COMPOSE_CONFIG_PATH=${COMPOSE_CONFIG_DIR}/docker-compose-standalone-server.yml

DESC=engine
NAME=sparkd
# master service name in docker-compose file
SPARK_MASTER_NAME="spark-master"
SPARK_WORKERS_NAME="spark-worker"

# Test existing command/binary

# Reference: https://stackoverflow.com/questions/7522712/how-can-i-check-if-a-command-exists-in-a-shell-script/7522866#7522866
if ! type "$DOCKER_ENGINE" > /dev/null; then
  echo "Could not find $DOCKER_ENGINE"
  exit 0
fi

if ! type "$COMPOSE_BINARY" > /dev/null; then
  echo "Could not find $COMPOSE_BINARY"
  exit 0
fi

# test -x $program_binary # test if a program exists and is executable

# Test in console
# test ! -f "docker-compose-standalone-server.yml" && echo "not found" || echo "found"
#
# Test existing file
if test ! -f "$COMPOSE_CONFIG_PATH"; then
  echo "Could not find $COMPOSE_CONFIG_PATH"
  exit 0
fi

# use log functions
# https://stackoverflow.com/questions/46164021/how-to-use-init-functions
. /lib/lsb/init-functions

STARTTIME=1
DIETIME=10                  # Time to wait for the server to die, in seconds
                            # If this value is set too low you might not
                            # let some servers to die gracefully and
                            # 'restart' will not work

set -e

# more complicated way is to write a health check command:
# https://stackoverflow.com/questions/48994189/how-to-check-if-all-docker-compose-up-services-started-successfully
# https://docs.docker.com/engine/reference/builder/#healthcheck
running_container() {
  # init local variable with a Global Variable
  service_name=$1
  # https://serverfault.com/questions/789601/check-is-container-service-running-with-docker-compose/935674#935674
  # docker-compose ps -q <service_name> will display the container ID no matter it's running or not, as long as it was created.
  # docker ps shows only those that are actually running.
  [ -z `docker-compose ps -q $service_name` ] && return 1
  [ -z `docker ps -q --no-trunc | grep $(docker-compose ps -q $service_name)` ] && return 1
  return 0
    # use log_progress_msg this function will be called in running function and primarily in start option
    # echo "No, $service_name is not running."
    # 1 = false
    # return 1
  # else
    # echo "Yes, $service_name is running."
    # 0 = true
    # return 0
  # fi
}

running() {
  # Check if the docker containers is running
  # check if container is running, otherwise return false = 1
  running_container "$SPARK_MASTER_NAME" || return 1
  # running_container "SPARK_WORKERS_NAME" || return 1
  return 0
}

start_services() {
  # start service with docker-compose
  `docker-compose -f $COMPOSE_CONFIG_PATH start`
  errcode=$?
  return $errcode
}

stop_services() {
  # stop service with docker-compose
  `docker-compose -f $COMPOSE_CONFIG_PATH stop`
  errcode=$?
  return $errcode
}

case "$1" in
  start)
    log_daemon_msg "Starting $DESC" "$NAME"
    # Check if it's running first
    if running ; then
      log_progress_msg "apparently already running"
      log_end_msg 0
      exit 0
    fi
    if start_services ; then
      # NOTE: Some servers might die some time after they start,
      # this code will detect this issue if STARTTIME is set
      # to a reasonable value
      [ -n "$STARTTIME" ] && sleep $STARTTIME # Wait some time
      if  running ; then
        # It's ok, the server started and is running
        log_end_msg 0
      else
        log_progress_msg "not running after we did start"
        # It is not running after we did start
        log_end_msg 1
      fi
    else
      log_progress_msg "Either we could not start it"
      # Either we could not start it
      log_end_msg 1
    fi
    ;;
  stop)
    log_daemon_msg "Stopping $DESC" "$NAME"
    if running ; then
      # Only stop services if we see it running
      errcode=0
      stop_services || errcode=$?
      log_end_msg $errcode
    else
      # If it is not running don' do anything
      log_progress_msg "apparently not running"
      log_end_msg 0
      exit 0
    fi
    ;;
  status)
    log_daemon_msg "Checking status of $DESC" "$NAME"
    if running ; then
      log_progress_msg "running"
      log_end_msg 0
    else
      log_progress_msg "apparently not running"
      log_end_msg 1
      exit 1
    fi
    ;;
  *)
    N=/etc/init.d/$NAME
    echo "Usage: $N {start|stop|restart|status}" >&2
    exit 1
    ;;
esac

exit 0
