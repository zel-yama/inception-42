


wp config  create  --dbname=$DATABASE_NAME \
          --dbuser=$MYSQL_USER \
          --dbpass=$MYSQL_PASSWORD \
          --dbhost=mariadb \
          

wp core install --url=zel-yama.fr.42 --title="the my wordpress site" \
    --admin_user=$WORDPRESS_ADMIN_USER_NAME --admin_password=$WORDPRESS_PASSWORD  


