#!/bin/bash

if ! [ $(id -u) = 0  ]; then
    echo "Please run it as root."
    exit 1
fi

useradd --system --shell=/bin/nologin --no-create-home dmonitor

mkdir /usr/local/bin/dmonitor
mkdir /var/run/dmonitor/
mkdir /var/dmonitor/

chown dmonitor /usr/local/bin/dmonitor
chown dmonitor /var/run/dmonitor/
chown dmonitor /var/dmonitor

cp ./dmonitor /etc/init.d/dmonitor
cp ./http.sh /usr/local/bin/dmonitor/
cp ./data_process.sh /usr/local/bin/dmonitor/data_process.sh
cp ./dmonitor.conf.sh /etc/dmonitor.conf.sh
cp ./dmonitor.service /etc/systemd/system/dmonitor
systemctl daemon-reload

