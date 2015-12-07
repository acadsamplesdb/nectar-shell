#!/bin/bash -e

fs=data/elasticsearch
zfs create $fs
chown elasticsearch:elasticsearch /$fs
rmdir /var/lib/elasticsearch
ln -s /$fs /var/lib/elasticsearch
