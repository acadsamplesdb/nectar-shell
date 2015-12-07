#!/bin/sh -e

export DEBIAN_FRONTEND=noninteractive

export HOST=`hostname` HOSTNAME=`hostname`

if [ -z "$SUB" ] ; then
    SUB="ddns slack"
fi

top=$PWD
for sub in $SUB ; do
    echo -- $sub --
    cd $top/sub/$sub
    ./$sub.sh
done
cd $top

/sbin/reboot

sleep 60
