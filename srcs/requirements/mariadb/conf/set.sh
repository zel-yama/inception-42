
service start mariadb

mariadb -u root -p ${SQL_PASSWORD}
mariadb -e "CREATE DATABASE IF NOT EXISTS `${DATABASE_NAME}`"

mariadb -e "CREATE USER IF NOT EXISTS ${MYSQL_USER}`@``%` IDNTIFIED BY  `${MYSQL_PASSWORD}`"

mariadb -e " GRANTE ALL PRIVILEGES; "

mariadb -e "FLUSH PRIVILEGES;" 