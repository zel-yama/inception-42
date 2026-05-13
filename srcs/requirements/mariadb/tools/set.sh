#!/bin/bash

service  mariadb start;

mysql -e "CREATE DATABASE  IF NOT EXISTS  ${DATABASE_NAME}; "
mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY ${MYSQL_ROOT_PASSWORD}; "
mysql -e "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD}';"
mysql -e "ALERT USER 'root'@'localhost' IDENTIFIED BY ${MYSQL_ROOT_PASSWORD};"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u${MYSQL_USER} -p${MYSQL_ROOT_PASSWORD} shutdown 


exec mysql_safe