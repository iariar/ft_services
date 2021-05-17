FROM alpine:3.12.3

RUN apk update &&\
    apk add influxdb &&\
    apk upgrade &&\
    apk add openrc &&\
    rc-status &&\
    touch /run/openrc/softlevel &&\
    wget https://dl.influxdata.com/influxdb/releases/influxdb2-2.0.4-linux-amd64.tar.gz &&\
    tar xvfz influxdb2-2.0.4-linux-amd64.tar.gz &&\
    mv influxdb2-2.0.4-linux-amd64 influxdb &&\
    mv influxdb/ etc/influxdb &&\
    echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories &&\
    apk add telegraf &&\
    mkdir /etc/telegraf && \
	cp -f /etc/telegraf.conf /etc/telegraf/telegraf.conf

COPY src/script.sh /script.sh
COPY	./src/telegraf.conf /etc/telegraf/telegraf.conf
EXPOSE 8086
CMD ["sh", "script.sh"]