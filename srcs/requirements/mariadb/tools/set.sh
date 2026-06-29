#!/bin/bash



if [ -d  "/var/lib/mysql/${DATABASE_NAME}" ];
then
    echo "data base already created" 
else

service  mariadb start
sleep 5

mysql << EOF
CREATE DATABASE  IF NOT EXISTS  ${DATABASE_NAME}; 
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; 
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;

EOF

 

fi
service mariadb  stop

mysqld_safe --bind-address=0.0.0.0 --port=3306
