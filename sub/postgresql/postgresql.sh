#!/bin/bash -e

fs=data/postgresql
zfs create $fs
chown postgres:postgres /$fs
mv /var/lib/postgresql/* /$fs
rmdir /var/lib/postgresql
ln -s /$fs /var/lib/postgresql
