#!/usr/bin/env bash
set -e

if [ "$1" = 'php-fpm83' ]; then
    config="/var/www/html/wp-config.php"

    if [ ! -f "$config" ]; then
        cp /var/www/html/wp-config-sample.php $config

        sed -i "s/define( 'DB_NAME', 'database_name_here' );/define( 'DB_NAME', '${WORDPRESS_DB_NAME}' );/" $config
        sed -i "s/define( 'DB_USER', 'username_here' );/define( 'DB_USER', '${WORDPRESS_DB_USER}' );/" $config
        sed -i "s/define( 'DB_PASSWORD', 'password_here' );/define( 'DB_PASSWORD', '${WORDPRESS_DB_PASSWORD}' );/" $config
        sed -i "s/define( 'DB_HOST', 'localhost' );/define( 'DB_HOST', 'mariadb' );/" $config

        chown www-data:www-data $config
    fi

    echo "WordPress config initialized."
fi

exec "$@"
