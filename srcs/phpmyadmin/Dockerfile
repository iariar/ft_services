FROM	alpine:3.12.3
RUN		apk upgrade &&\
		apk update
RUN		apk add nginx &&\
		apk add openrc --no-cache &&\
		rc-status &&\
		touch /run/openrc/softlevel &&\
		adduser -D -g 'www' www &&\
		mkdir /www &&\
		chown -R www:www /var/lib/nginx &&\
		chown -R www:www /www &&\
		mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig
RUN apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json &&\
	apk add php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath &&\
	apk add php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc &&\
	apk add php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype php7-session php7-mbstring &&\
	apk add php7 php7-opcache php7-zlib 1>/dev/null

RUN mkdir -p /usr/share/webapps/ &&\
	cd /usr/share/webapps &&\
	wget http://files.directadmin.com/services/all/phpMyAdmin/phpMyAdmin-5.0.2-all-languages.tar.gz &&\
	tar zxvf phpMyAdmin-5.0.2-all-languages.tar.gz &&\
	rm phpMyAdmin-5.0.2-all-languages.tar.gz &&\
	mv phpMyAdmin-5.0.2-all-languages phpmyadmin &&\
	chmod -R 777 /usr/share/webapps &&\
	touch /usr/share/webapps/phpmyadmin/config.inc.php &&\
	chmod 755 /usr/share/webapps/phpmyadmin/config.inc.php &&\
	echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories &&\
    apk add telegraf &&\
	mkdir /etc/telegraf && \
	cp -f /etc/telegraf.conf /etc/telegraf/telegraf.conf
	
COPY ./src/nginx.conf /etc/nginx/nginx.conf
COPY ./src/script.sh /script.sh
COPY	./src/telegraf.conf /etc/telegraf/telegraf.conf
COPY ./src/config.inc.php /usr/share/webapps/phpmyadmin/config.inc.php
RUN	chmod 755 /usr/share/webapps/phpmyadmin/config.inc.php

EXPOSE 5000

CMD ["sh", "script.sh"]

