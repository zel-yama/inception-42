#!/bin/bash

#i should check if data create and 
#i should check config in first config 

#!/bin/bash


sed -i  "s/listen = .*/listen = 9000/g" /etc/php/8.2/fpm/pool.d/www.conf;

sleep 10

if [ ! -f wp-config.php ]; then

wp config create --allow-root \
    --dbname=$DATABASE_NAME \
    --dbuser=$MYSQL_USER \
    --dbpass=$MYSQL_PASSWORD \
    --dbhost=mariadb

wp core install --allow-root \
    --url=zel-yama.42.fr \
    --title="the my wordpress site" \
    --admin_email=$EMAIL_USER_WORDPRESS \
    --admin_user=$WORDPRESS_ADMIN_USER_NAME \
    --admin_password=$WORDPRESS_PASSWORD

wp user create --allow-root \
    $WORDPRESS_USER \
    $WORDPRESS_EMAIL_USER \
    --role=editor \
    --user_pass=$WORDPRESS_USER_PASSWORD

fi

exec php-fpm8.2 -F
