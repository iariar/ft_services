FROM alpine:3.12.3

RUN apk update &&\
    apk upgrade &&\
    apk add openrc &&\
    rc-status &&\
    touch /run/openrc/softlevel &&\
    echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories &&\
    apk add grafana &&\
    apk add telegraf &&\
    mkdir /etc/telegraf &&\
	cp -f /etc/telegraf.conf /etc/telegraf/telegraf.conf

COPY ./src/grafana.db /usr/share/grafana/data/grafana.db
COPY	./src/telegraf.conf /etc/telegraf/telegraf.conf
COPY ./src/script.sh /script.sh
EXPOSE 3000
CMD ["sh", "script.sh"]
