#!/bin/bash

service  mariadb start;

mysql -e "CREATE DATABASE  IF NOT EXISTS  ${DATABASE_NAME}; "
mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}'; "
mysql -e "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
#mys_ql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD};"
mysql -e -u root -p${MYSQL_ROOT_PASSWORD} "FLUSH PRIVILEGES;"

mysqladmin -u${MYSQL_USER} -p${MYSQL_ROOT_PASSWORD} shutdown 


exec mysql_safe