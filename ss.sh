
sudo systemctl m

sudo mysql -uroot  <<EOF
DELETE FROM mysql.user WHERE user='';
DELETE FROM mysql.user WHERE User='root' AND Host NOT IN ('localhost','127.0.0.1','::1');
DROP DATABASE IF EXISTS test;
CREATE DATABASE  IF NOT EXISTS  data;
CREATE USER IF NOT EXISTS 'zaka'@'%' IDENTIFIED BY '1234'; 
GRANT ALL PRIVILEGES ON data.* TO 'zaka'@'%' ;
ALTER USER 'root'@'localhost' IDENTIFIED BY '123456';
FLUSH PRIVILEGES;
EOF