#!/bin/sh -e

# timezone

echo Australia/Adelaide > /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

# init

for init in iosched ; do
    install $init.init /etc/init.d/$init
    update-rc.d $init defaults
done

# ntp

install -o 0 -g 0 ntp.conf /etc

# open the console for output

chmod a+w /dev/console

# supervisor workaround for init script being ignored on ubuntu 14.10
# (no points for elegance)

echo "service supervisor start" >> /etc/rc.local

# reporting api

echo "iptables -A PREROUTING -t nat -i eth0 -p tcp --dport 443 -j REDIRECT --to-port 8443" >> /etc/rc.local
