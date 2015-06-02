#!/bin/bash -e

if [ -z "$CLUSTER" ] ; then
  echo "required environment: CLUSTER; skipping kafka"
  exit 0
fi

zfs create -o compression=gzip-9 data/kafka

export KAFKA_BROKER=`echo $CLUSTER | xargs -n 1 | cat -n | grep $HOST | awk '{print $1}'`

../../render.py < server.properties > /opt/kafka/config/server.properties

cp kafka.conf /etc/supervisor/conf.d

chown -RH ubuntu:ubuntu /{opt,data}/kafka
