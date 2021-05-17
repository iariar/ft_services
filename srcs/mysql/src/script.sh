#!bash
/etc/init.d/mariadb setup
/etc/init.d/mariadb start

telegraf &

echo "CREATE DATABASE wordpress;" | mysql -u root
# mysql -u root < /wordpress.sql
echo "GRANT ALL ON wordpress.* TO 'test'@'%' IDENTIFIED BY 'test' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "CREATE DATABASE phpmyadmin;" | mysql -u root
echo "GRANT ALL ON phpmyadmin.* TO 'test'@'%' IDENTIFIED BY 'test' WITH GRANT OPTION;" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root
echo "CREATE USER 'test'@'%' IDENTIFIED BY 'test';" | mysql -u root
echo "GRANT ALL PRIVILEGES ON * . * TO 'test'@'%';" | mysql -u root
echo "FLUSH PRIVILEGES;" | mysql -u root

sed -i "s|.*skip-networking.*|#skip-networking|g" /etc/my.cnf.d/mariadb-server.cnf

service mariadb restart

sleep 2

while true
do
    if ! pgrep mysql ; then
    echo "mysql is down!"
    exit 1
    else
    echo "mysql is up !"
    fi

    if ! pgrep telegraf ; then
    echo "telegraf is down !"
    exit 1
    else
    echo "telegraf is up !"
    fi
    sleep 2
done
