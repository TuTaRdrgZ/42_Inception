FROM alpine:3.20

RUN apk update && apk add --no-cache mariadb mariadb-client

RUN mkdir -p /run/mysqld /var/lib/mysql && \
    chown -R mysql:mysql /run/mysqld /var/lib/mysql

COPY ./conf.d/ /etc/my.cnf.d

COPY ./mariadb-entrypoint.sh /mariadb-entrypoint.sh

RUN chmod +x /mariadb-entrypoint.sh

EXPOSE 3306

STOPSIGNAL SIGTERM

ENTRYPOINT ["/mariadb-entrypoint.sh"]

CMD ["mysqld", "--user=mysql"]
