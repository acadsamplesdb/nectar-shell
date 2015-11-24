#!/bin/sh -e

# timezone

echo Australia/Adelaide > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# init

cat >> /etc/rc.local << EOF
echo noop > /sys/block/vda/queue/scheduler
echo noop > /sys/block/vdb/queue/scheduler
EOF

# ntp

install -o 0 -g 0 ntp.conf /etc
