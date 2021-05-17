#!/bin/sh

# service telegraf start
telegraf &
grafana-server -homepath /usr/share/grafana

sleep 2

while true
do

    if ! pgrep telegraf ; then
    echo "telegraf is down !"
    exit 1
    else
    echo "telegraf is up !"
    fi

sleep 1

    if ! pgrep grafana-serve ; then
    echo "grafana is down !"
    exit 1
    else
    echo "grafana is up !"
    fi

done