#!/bin/bash
MYSQL_PASS='VMware1!'
apt-get update -y && apt-get upgrade -y
debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password $MYSQL_PASS'
debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password $MYSQL_PASS'
apt-get install mysql-server -y
MYSQL_SCRIPT="\n
CREATE DATABASE sfapp;\n

"
mysql -uroot -p$MYSQL_PASS -e "$MYSQL_SCRIPT"
