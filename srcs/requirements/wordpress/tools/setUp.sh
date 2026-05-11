#!/bin/bash

#i should check if data create and 
#i should check config in first config 

wp core download 

wp config  create  --allow-root  --dbname=$DATABASE_NAME \
          --dbuser=$MYSQL_USER \
          --dbpass=$MYSQL_PASSWORD \
          --dbhost=mariadb 
          

wp --allow-root core install --url=zel-yama.fr.42 --title="the my wordpress site" \
    --admin_email=$EMAIL_USER_WORDPRESS    \
    --admin_user=$WORDPRESS_ADMIN_USER_NAME \
     --admin_password=$WORDPRESS_PASSWORD  

wp user create --allow-root  $WORDPRESS_USER $WORDPRESS_EMAIL_USER --role=editor --user_pass=$WORDPRESS_USER_PASSWORD



php-fpm3.8 -F



