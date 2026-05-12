#!/bin/bash

service mariadb start


mariadb -u root -p${SQL_ROOT_PASSWORD} \
-e "CREATE DATABASE IF NOT EXISTS ${DATABASE_NAME};"

mariadb -u root -p${SQL_ROOT_PASSWORD} \
-e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}';"

mariadb -u root -p${SQL_ROOT_PASSWORD} \
-e "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${MYSQL_USER}'@'%';"

mariadb -u root -p${SQL_ROOT_PASSWORD} \
-e "FLUSH PRIVILEGES;"

mysqladmin -u root -p${SQL_ROOT_PASSWORD} shutdown

exec mysqld_safe --port=3306 --bind-address=0.0.0.0