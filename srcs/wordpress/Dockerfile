FROM	alpine:3.12.3
RUN apk add openrc --no-cache &&\
	rc-status &&\
	touch /run/openrc/softlevel &&\
	apk add nginx &&\
	adduser -D -g 'www' www &&\
	mkdir /www &&\
	chown -R www:www /var/lib/nginx &&\
	chown -R www:www /www &&\
	mv /etc/nginx/nginx.conf /etc/nginx/nginx.conf.orig &&\
	apk add php7-fpm php7-mcrypt php7-soap php7-openssl php7-gmp php7-pdo_odbc php7-json php7-dom php7-pdo php7-zip php7-mysqli php7-sqlite3 php7-apcu php7-pdo_pgsql php7-bcmath php7-gd php7-odbc php7-pdo_mysql php7-pdo_sqlite php7-gettext php7-xmlreader php7-xmlrpc php7-bz2 php7-iconv php7-pdo_dblib php7-curl php7-ctype
# RUN mkdir /www/wordpress &&\
RUN	touch /etc/nginx/nginx.conf &&\
	echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories &&\
    apk add telegraf &&\
	mkdir /etc/telegraf && \
	cp -f /etc/telegraf.conf /etc/telegraf/telegraf.conf

COPY src/script.sh /script.sh
RUN wget https://wordpress.org/latest.tar.gz
RUN tar -xzvf latest.tar.gz 1>/dev/null
RUN mv /wordpress /www
RUN rm -rf latest.tar.gz 
COPY	./src/telegraf.conf /etc/telegraf/telegraf.conf
COPY src/nginx.conf /etc/nginx/nginx.conf
COPY ./src/wp-config.php /www/wordpress/wp-config.php

EXPOSE 5050

CMD ["sh", "script.sh"]