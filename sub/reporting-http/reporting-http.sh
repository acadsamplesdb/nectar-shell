#!/bin/bash -e

if [ -z "$CLUSTER" ] ; then
  echo "required environment: CLUSTER; skipping reporting-http"
  exit 0
fi

fs=data/http

zfs create $fs
chown ubuntu:ubuntu /$fs

wget -O - $REPORTING_URL | openssl $REPORTING_CIPHER -d -pass pass:$REPORTING_PASSWORD | tar xvf - -C /$fs

../../render.py < config.yaml > /$fs/config.yaml

cp http.conf /etc/supervisor/conf.d
