#!/bin/bash

#this should be cmd cuz this run put this in the beluiding of image
#there in networks my can create i don't why but connection send user-mysql and @networks name 
# or my be the error in the creation of data base users 
# if [ -d "/var/lib/mysql/${DATABASE_NAME}" ]; this wrong cuz file can in differnt place 

#is server listen on defualt or not 
#is server sql work good how i can test it can try local host and then ??
#i thinks sql server listen on the localhost 
# i thinks sql 
# how to know  Check that mariadbd is running and that the socket: '/run/mysqld/mysqld.sock' exists!

#/etc/mysql/mariadb.conf.d/50-server.cnf

 
sleep 4
echo "new " 

if [ -d  "/var/lib/mysql/${DATABASE_NAME}" ];
then
    echo "data base already created" 
else

service  mariadb start
sleep 5

mysql << EOF
DELETE FROM mysql.user WHERE user='';
CREATE DATABASE  IF NOT EXISTS  ${DATABASE_NAME}; 
CREATE USER IF NOT EXISTS '$MYSQL_USER'@'%' IDENTIFIED BY '$MYSQL_PASSWORD'; 
GRANT ALL PRIVILEGES ON *.* TO '$MYSQL_USER'@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '$MYSQL_ROOT_PASSWORD';
FLUSH PRIVILEGES;

EOF

service mariadb  stop
#mysqladmin -u$MYSQL_USER -p${MYSQL_PASSWORD} shutdown # this require user root to turn of it 

fi

mysqld_safe --bind-address=0.0.0.0 --port=3306
