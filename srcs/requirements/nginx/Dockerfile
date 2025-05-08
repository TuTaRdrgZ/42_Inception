FROM alpine:3.20

RUN set -x \
    && apk add --no-cache openssl nginx

COPY  nginx-entrypoint.sh / 
RUN chmod +x /nginx-entrypoint.sh

ENTRYPOINT ["/nginx-entrypoint.sh"]

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
