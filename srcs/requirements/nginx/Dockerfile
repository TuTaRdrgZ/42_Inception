FROM alpine:3.20

LABEL maintainer="bautrodr <bautrodr@student.42barcelona.com"

RUN set -x \
    && apk add --no-cache openssl nginx

COPY --chmod=755 nginx-entrypoint.sh / 

ENTRYPOINT ["/nginx-entrypoint.sh"]

STOPSIGNAL SIGQUIT

CMD ["nginx", "-g", "daemon off;"]
