#!/bin/bash

set -e -x

# database

systemctl start postgresql

# prep

fs=data/samples

zfs create $fs
chown ubuntu:ubuntu /$fs

pip3 install virtualenv

# extraction

su -l ubuntu << EOF

createdb samples

cd /$fs
wget -qO - https://github.com/acadsamplesdb/acad_samples/archive/master.tar.gz | tar xzvf - --strip-components=1

virtualenv venv
. venv/bin/activate
pip3 install -r requirements.txt

EOF

# finalise runtime

cat >> /etc/rc.local << EOF

systemctl start elasticsearch
systemctl start postgresql

EOF
