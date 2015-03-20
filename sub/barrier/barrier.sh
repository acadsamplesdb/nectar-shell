#!/bin/bash -e

if [ -z "$CLUSTER" ] ; then
  echo "required environment: CLUSTER; skipping barrier"
  exit 0
fi

./barrier.py $CLUSTER
