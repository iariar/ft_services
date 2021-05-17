#!/bin/bash

telegraf &
service vsftpd start

sleep 2

while true
do
    if ! pgrep telegraf ; then
    echo "Telegraf is down!"
    exit 1
    else
    echo "Telegraf is up !"
    fi

sleep 2

    if ! pgrep vsftpd ; then
    echo "vsftpd is down !"
    exit 1
    else
    echo "vsftpd is up !"
    fi

done
