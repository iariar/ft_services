#!bash

telegraf &
service nginx start

sleep 2

while true
do
    if ! pgrep nginx ; then
    echo "Nginx is dowm!"
    exit 1
    else
    echo "Nginx is up !"
    fi

    sleep 1

    if ! pgrep telegraf ; then
    echo "telegraf is down !"
    exit 1
    else
    echo "telegraf is up !"
    fi

done
