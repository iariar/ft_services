#!/bin/sh

telegraf &
# service telegraf start
service influxdb start

sleep 2

while true
do
    if ! pgrep influx ; then
    echo "influxdb is dowm!"
    exit 1
    else
    echo "influxdb is up !"
    fi

    sleep 1

    if ! pgrep telegraf ; then
    echo "telegraf is down !"
    exit 1
    else
    echo "telegraf is up !"
    fi

done
