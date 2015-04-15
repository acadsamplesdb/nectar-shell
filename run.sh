#!/bin/sh

version=master

curl --silent --location https://github.com/eResearchSA/nectar-shell/archive/$version.tar.gz | tar xzvf -

cd nectar-shell-$version

./setup.sh

# should not reach this point

/sbin/poweroff
