FROM alpine:3.12.3

RUN apk update
RUN apk add nginx
RUN apk add openrc
RUN rc-status
RUN touch /run/openrc/softlevel

#add the community repo for the repositories packages file reference, telegraf exists in that repo
RUN echo "http://nl.alpinelinux.org/alpine/edge/community" >> /etc/apk/repositories
RUN apk add telegraf 1>/dev/null
#edit config file for file to link it with InfluxDB
RUN mkdir /etc/telegraf && \
	cp -f /etc/telegraf.conf /etc/telegraf/telegraf.conf

#add www user in www group
RUN adduser -D -g 'www' www
RUN mkdir /www

#give permissions, -R is for recursion on directories and files
RUN chown -R www:www /var/lib/nginx /www

#install openssl to generate an ssl certificate with it
RUN apk add openssl
RUN echo -e "MA\nKH\nKHOURIBGA\n1337Ltd\nOCP\nOCP SA\nft_services@1337.ma\n" | openssl req \
    -x509 -nodes -days 365 -newkey rsa:2048 -keyout /etc/ssl/private/nginx-selfsigned.key \
    -out /etc/ssl/certs/nginx-selfsigned.crt

#copy the necessary files
ADD ./src/nginx.conf /etc/nginx/nginx.conf
ADD ./src/sample.html /www/index.html
COPY	./src/telegraf.conf /etc/telegraf/telegraf.conf
COPY ./src/script.sh /script.sh
EXPOSE 80 443

CMD ["sh", "script.sh"]
