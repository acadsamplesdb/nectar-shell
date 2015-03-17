#!/bin/bash -e

if [ -z "$CLUSTER" ] ; then
  echo "required environment: CLUSTER; skipping zookeeper"
  exit 0
fi

zfs create data/zookeeper

../../render.py < zoo.cfg > /opt/zookeeper/conf/zoo.cfg

echo $CLUSTER | xargs -n 1 | cat -n | grep $HOST | awk '{print $1}' > /data/zookeeper/myid

chown -RH ubuntu:ubuntu /{opt,data}/zookeeper
