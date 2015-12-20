#!/bin/bash

set -e -x

# database

systemctl start postgresql

# nginx

cp -f nginx.conf ca.pem samples.pem /etc/nginx

(umask 077 ; echo $HTTPS_KEY | base64 --decode > /etc/nginx/samples.key)

systemctl enable nginx

# prep

for fs in tmp samples; do
    zfs create data/$fs
    chown ubuntu:ubuntu /data/$fs
done

pip3 install virtualenv

# extraction

su -l ubuntu << EOF

createdb samples

cd /data/samples
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
