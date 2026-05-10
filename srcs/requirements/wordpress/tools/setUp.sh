

#i should check if data create and 
#i should check config in first config 


wp config  create  --dbname=$DATABASE_NAME \
          --dbuser=$MYSQL_USER \
          --dbpass=$MYSQL_PASSWORD \
          --dbhost=mariadb --allow-root \
          

wp --allow-root core install --url=zel-yama.fr.42 --title="the my wordpress site" \
    --admin_user=$WORDPRESS_ADMIN_USER_NAME --admin_password=$WORDPRESS_PASSWORD  

wp user create $WORDPRESS_USER $WORDPRESS_EMAIL_USER --role=editor --user_pass=$WORDPRESS_USER_PASSWORD






