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

# Test existing command/binary
# Reference: https://stackoverflow.com/questions/7522712/how-can-i-check-if-a-command-exists-in-a-shell-script/7522866#7522866
if ! type "$DOCKER_ENGINE" > /dev/null; then
  echo "Could not find $DOCKER_ENGINE"
  exit 0
fi

# Test existing file existance
#if test ! -x $DOCKER_DAEMON; then
#  echo "Could not find $DOCKER_DAEMON"
#  exit 0
#fi

if ! type "$DOCKER_ENGINE" > /dev/null; then
  echo "Could not find $COMPOSE_BINARY"
  exit 0
fi




