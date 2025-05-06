#!/bin/sh
# vim:sw=4:ts=4:et

set -e

entrypoint_log() {
    if [ -z "${NGINX_ENTRYPOINT_QUIET_LOGS:-}" ]; then
        echo "$@"
    fi
}

if [ "$1" = "nginx" ] || [ "$1" = "nginx-debug" ]; then
        entrypoint_log "$0: /docker-entrypoint.d/ is not empty, will attempt to perform configuration"

        entrypoint_log "$0: Looking for shell scripts in /docker-entrypoint.d/"
        entrypoint_log "$0: Generating ssl certificates"
        mkdir -p /etc/nginx/ssl
        openssl req -x509 -nodes -days 365 \
        -newkey rsa:2048 \
        -keyout /etc/nginx/ssl/bautrodr.42.fr.key \
        -out /etc/nginx/ssl/bautrodr.42.fr.crt \
        -subj "/C=ES/ST=Catalonia/L=Barcelona/O=42/OU=42Barcelona/CN=bautrodr.42.fr"
		sed -i "/http {/a \\
	server {\\
		listen 443 ssl;\\
		server_name bautrodr.42.fr;\\
		ssl_certificate /etc/nginx/ssl/bautrodr.42.fr.crt;\\
		ssl_certificate_key /etc/nginx/ssl/bautrodr.42.fr.key;\\
		root /var/www/html;\\
		index index.html index.php;\\
		location / {\\
			try_files \$uri \$uri/ /index.php\$is_args\$args;\\
		}\\
		location ~ \\\.php\$ {\\
			include fastcgi_params;\\
			fastcgi_pass wordpress:9000;\\
			fastcgi_param SCRIPT_FILENAME \$document_root\$fastcgi_script_name;\\
		}\\
	}" /etc/nginx/nginx.conf
        entrypoint_log "$0: Configuration complete; ready for start up"
fi

exec "$@"
