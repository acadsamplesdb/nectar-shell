#!/bin/sh

if [ -z "$REF" ]; then
    REF=master
fi

curl --silent --location https://github.com/eResearchSA/nectar-shell/archive/$REF.tar.gz | tar xzvf -

cd nectar-shell-$REF

./setup.sh

# should not reach this point (setup will reboot)

/sbin/poweroff
