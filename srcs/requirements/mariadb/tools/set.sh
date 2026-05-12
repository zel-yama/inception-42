#!/bin/bash

service  mysql start;

mysql -e "CREATE  IF NOT EXSITS ${DATABASE_NAME}; "
mysql -e "CREATE USER '${MYSQL_USER}'@'%' IDENTIFIED BY ${MYSQL_ROOT_PASSWORD}; "
mysql -e "GRANT ALL PRIVILEGS ON '${DATABASE_NAME}'.* TO ${MYSQL_USER} IDENTIFIED BY ${MYSQL_ROOT_PASSWORD};"
mysql -e "ALERT USER 'root'@'localhost' IDENTIFIED BY ${MYSQL_ROOT_PASSWORD};"
mysql -e "FLUSH PRIVILEGS;"

mysqladmin -u${MYSQL_USER} -p${MYSQL_ROOT_PASSWORD} shutdown 


exec mysql_safe