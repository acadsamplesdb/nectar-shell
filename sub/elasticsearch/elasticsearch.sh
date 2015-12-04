#!/bin/bash -e

# packages

wget -qO - https://packages.elastic.co/GPG-KEY-elasticsearch | apt-key add -
echo "deb http://packages.elastic.co/elasticsearch/1.7/debian stable main" >> /etc/apt/sources.list
apt-get update
apt-get -y install elasticsearch libgeos-c1v5

# config

cat >> /etc/elasticsearch/elasticsearch.yml << ES_EOF
script.disable_dynamic: true
network.host: 127.0.0.1
ES_EOF

systemctl daemon-reload
systemctl enable elasticsearch.service

# zfs

service elasticsearch stop

fs=data/elasticsearch
zfs create $fs
chown elasticsearch:elasticsearch /$fs
mv /var/lib/elasticsearch/* /$fs
rmdir /var/lib/elasticsearch
ln -s /$fs /var/lib/elasticsearch

# done

sysv-rc-conf elasticsearch off
service elasticsearch start
