FROM	alpine:3.12.3
RUN apk add openrc --no-cache &&\
	rc-status &&\
	touch /run/openrc/softlevel &&\
	apk add mysql mysql-client &&\
	echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories &&\
    apk add telegraf &&\
    mkdir /etc/telegraf && \
	cp -f /etc/telegraf.conf /etc/telegraf/telegraf.conf

COPY ./src/script.sh /script.sh
COPY	./src/telegraf.conf /etc/telegraf/telegraf.conf
COPY ./src/wordpress.sql /
EXPOSE 3306
CMD ["sh", "script.sh"]