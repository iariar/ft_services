#!bash

telegraf &
service nginx start
service php-fpm7 start

sleep 2

while true
do
    if ! pgrep nginx ; then
    echo "Nginx is down!"
    exit 1
    else
    echo "Nginx is up !"
    fi

    if ! pgrep telegraf ; then
    echo "telegraf is down !"
    exit 1
    else
    echo "telegraf is up !"
    fi

sleep 2

    if ! pgrep php-fpm7 ; then
    echo "php-fpm7 is down !"
    exit 1
    else
    echo "php-fpm7 is up !"
    fi

done