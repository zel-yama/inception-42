#!/bin/bash

service  mariadb start

mariadb -u root -p${SQL_ROOT_PASSWORD}

mariadb -e "CREATE DATABASE IF NOT EXISTS '${DATABASE_NAME}';"

mariadb -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY  '${MYSQL_PASSWORD}' ;" 

mariadb -e  "GRANT ALL PRIVILEGES ON '${MYSQL_DATABASE}'.* TO '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}' ;"

mariadb -e "FLUSH PRIVILEGES;" 

mysqlmyadmin -u root -p${MYSQL_ROOT_PASSWORD} shutdown 

exec mysql_safe --port=3306 --bind-address=0.0.0.0 #i should put port and op address 
