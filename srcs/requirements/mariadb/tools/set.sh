
service start mariadb

mariadb -u root -p ${SQL_ROOT_PASSWORD}
mariadb -e "CREATE DATABASE IF NOT EXISTS `${DATABASE_NAME}`"

mariadb -e "CREATE USER IF NOT EXISTS ${MYSQL_USER}`@``%` IDNTIFIED BY  `${MYSQL_PASSWORD}`"

mariadb -e " GRANT ALL PRIVILEGES; "

mariadb -e "FLUSH PRIVILEGES;" 

mariadbmyadmin -u root -p ${MYSQL_ROOT_PASSWORD} shutdown 

exec mariadb_safe  #i should put port and op address 
