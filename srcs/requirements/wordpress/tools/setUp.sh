 
#!/bin/bash

cd /srv/www/wordpress/

sed -i  "s/listen = .*/listen = 9000/g" /etc/php/8.2/fpm/pool.d/www.conf;

until ping -c1 mariadb  ; do 
   echo "hello "
    sleep 2
 done
sleep 10
# until mariadb -hmariadb -u$MYSQL_USER -p$MYSQL_PASSWORD -e "SELECT 1"
# do
#     echo "is data base ready " 
#     sleep 2
# done

if [ ! -f wp-config.php ]; then

mv wp-config-sample.php wp-config.php 

wp core download --allow-root 
#sed -i -r "s/database_name_here/${DATABASE_NAME}/g" wp-config.php
sed -i -r "s/username_here/${MYSQL_USER}/g" wp-config.php
sed -i -r "s/password_here/${MYSQL_PASSWORD}/g" wp-config.php
sed -i -r "s/localhost/mariadb:3306/g" wp-config.php

# connection refused # wp-config-sample.php  
# and  wp-config.ph is not create config wordpress is not correct 
# echo "here create config " 

# wp config create --allow-root \
#     --dbname=$DATABASE_NAME \
#     --dbuser=$MYSQL_USER \
#     --dbpass=$MYSQL_PASSWORD \
#     --dbhost=mariadb:3306 \
#     --path=/srv/www/wordpress

wp core install --allow-root \
    --url=zel-yama.42.fr \
    --title="the my wordpress site" \
    --admin_email=$EMAIL_USER_WORDPRESS \
    --admin_user=$WORDPRESS_ADMIN_USER_NAME \
    --admin_password=$WORDPRESS_PASSWORD \
    --path=/srv/www/wordpress

wp user create --allow-root \
    $WORDPRESS_USER \
    $WORDPRESS_EMAIL_USER \
    --role=editor \
    --user_pass=$WORDPRESS_USER_PASSWORD \
    --path=/srv/www/wordpress 

#fi

exec php-fpm8.2 -F
