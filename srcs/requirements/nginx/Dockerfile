FROM alpine:3.20

RUN apk update && \
	apk add nginx openssl

RUN mkdir -p /run/nginx/

RUN touch /run/nginx/nginx.pid

RUN adduser -D -g 'www' www

RUN mkdir /www 

RUN chown -R www:www /var/lib/nginx

RUN chown -R www:www /www

COPY config/nginx.conf /etc/nginx/nginx.conf

COPY index.html /www

RUN ["./usr/sbin/nginx"]
