#!/bin/bash

#this should be cmd cuz this run put this in the beluiding of image
#there in networks my can create i don't why but connection send user-mysql and @networks name 
# or my be the error in the creation of data base users 
# if [ -d "/var/lib/mysql/${DATABASE_NAME}" ]; this wrong cuz file can in differnt place 



service  mariadb start;

if [ -d  "/var/lib/mysql/${DATABASE_NAME}" ];
then
    echo "data base already created" 
else

mysql -e "CREATE DATABASE  IF NOT EXISTS  ${DATABASE_NAME}; "
mysql -e "CREATE USER IF NOT EXISTS 'ZIKO' IDENTIFIED BY '12345'; "
mysql -e "GRANT ALL PRIVILEGES ON data_base.* to 'ZIKO'   ;"
mysql -e "CREATE USER IF NOT EXISTS '${MYSQL_USER}'@'%' IDENTIFIED BY '${MYSQL_PASSWORD}'; "
mysql -e "GRANT ALL PRIVILEGES ON ${DATABASE_NAME}.* TO '${MYSQL_USER}'@'%' ;"  #THIS worng and indentified is exist
#mys_ql -e "ALTER USER 'root'@'localhost' IDENTIFIED BY '${MYSQL_ROOT_PASSWORD};"
mysql -e "FLUSH PRIVILEGES;"

mysqladmin -u${MYSQL_USER} -p${MYSQL_PASSWORD} shutdown # this require user root to turn of it 

fi

