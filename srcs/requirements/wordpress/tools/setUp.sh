 
#!/bin/bash


mkdir -p /srv/www/wordpress && chown -R www-data:www-data /srv/www/wordpress
cd /srv/www/wordpress/

sed -i  "s/listen = .*/listen = 9000/g" /etc/php/8.2/fpm/pool.d/www.conf;


until mysqladmin -h mariadb -u$MYSQL_USER -p$MYSQL_PASSWORD ping   ; do 
   echo "hello "
    sleep 2
 done

if [ ! -f wp-config.php ]; then

    wp core download --allow-root 

    wp config create --allow-root \
        --dbname=$DATABASE_NAME \
        --dbuser=$MYSQL_USER \
        --dbpass=$MYSQL_PASSWORD \
        --dbhost=mariadb:3306 \
       

    wp core install --allow-root \
        --url=$DOMAIN_NAME \
        --title="WordPress" \
        --admin_email=$EMAIL_ADMIN_WORDPRESS \
        --admin_user=$WORDPRESS_ADMIN_USER_NAME \
        --admin_password=$WORDPRESS_PASSWORD \


    wp user create --allow-root \
        $WORDPRESS_USER \
        $WORDPRESS_EMAIL_USER \
        --role=editor \
        --user_pass=$WORDPRESS_USER_PASSWORD \
       
fi

exec php-fpm8.2 -F