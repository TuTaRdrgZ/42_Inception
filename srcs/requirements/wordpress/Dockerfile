FROM alpine:3.20

RUN apk add --no-cache \
		openssl

RUN set -eux; \
	addgroup -S www.data;\
	adduser -u 82 -D -S -G www-data www-data

ENV PHP_INI_DIR /usr/local/etc/php

RUN set -eux; \
	mkdir -p "$PHP_INI_DIR/conf.d"; \
	mkdir -p /var/www/html; \
	chown www-data:www-data /var/www/html; \
	chmod 1777 /var/www/html

RUN apk update && apk add php83 php83-fpm php83-mysqli php-zlib php83-curl php83-json php83-xml php83-phar php83-intl php83-dom php83-xmlreader php83-ctype php83-session php83-mbstring curl bash

RUN sed -i 's|^listen = .*|listen = 0.0.0.0:9000|' /etc/php83/php-fpm.d/www.conf

COPY php-entrypoint.sh /
RUN chmod +x /php-entrypoint.sh

ENTRYPOINT ["/php-entrypoint.sh"]

WORKDIR /var/www/html

EXPOSE 9000

STOPSIGNAL SIGQUIT

CMD ["php-fpm83", "-F", "-R"]
