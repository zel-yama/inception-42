#!/bin/bash



service  mariadb start;

if [ -d  "/var/lib/mysql/${DATABASE_NAME}" ];
then
    echo "data base already created" 
else

mysql -e "CREATE DATABASE  IF NOT EXISTS  ${DATABASE_NAME}; "
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; "
mysql -e "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"
#mys_ql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD};"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u${MYSQL_USER} -p${MYSQL_ROOT_PASSWORD} shutdown 

fi

