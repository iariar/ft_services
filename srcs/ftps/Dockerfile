FROM alpine:3.12.3
RUN		apk upgrade &&\
		apk update
RUN		apk add openrc --no-cache &&\
		rc-status &&\
		touch /run/openrc/softlevel &&\
		apk add vsftpd &&\
		echo -e "1234\n1234" | adduser 'testuser' &&\
		echo "testuser" | tee -a /etc/vsftpd.userlist &&\
		apk add openssl
RUN		echo -e "MA\nKhouribga\n=Khouribga\nOrganisation_NAME\nSERVER_NAME\nft_services@1337.ma\n" | openssl req -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/vsftpd.pem -out /etc/ssl/private/vsftpd.pem &&\
		echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories &&\
		apk add telegraf 1>/dev/null &&\
#edit config file for file to link it with InfluxDB
		mkdir /etc/telegraf && \
		cp -f /etc/telegraf.conf /etc/telegraf/telegraf.conf

COPY 	./src/script.sh /script.sh
COPY	./src/vsftpd.conf /etc/vsftpd/vsftpd.conf
COPY	./src/telegraf.conf /etc/telegraf/telegraf.conf
EXPOSE 21
CMD ["sh", "script.sh"]
