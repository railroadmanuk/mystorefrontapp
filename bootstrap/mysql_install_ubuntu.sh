#!/bin/bash
MYSQL_PASS='VMware1!'
apt-get update -y && apt-get upgrade -y
debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password $MYSQL_PASS'
debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password $MYSQL_PASS'
apt-get install mysql-server -y
MYSQL_SCRIPT="\n
CREATE DATABASE sfapp;\n
SELECT sfapp;\n
CREATE TABLE orders (
    OrderID INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Address VARCHAR(200) NOT NULL,
    PostCode VARCHAR(20) NOT NULL,
    ItemRefs VARCHAR(2000) NOT NULL
  );\n
CREATE TABLE items (
    ItemID INT(6) UNSIGNED AUTO_INCREMENT PRIMARY KEY,
    Name VARCHAR(30) NOT NULL,
    Description VARCHAR(200) NOT NULL
  );\n
INSERT INTO items (Name, Description)
    VALUES ('Nice Spade','This is a damn good spade');\n
INSERT INTO items (Name, Description)
    VALUES ('Crappy Spade','This is an awful spade');\n
"
mysql -uroot -p$MYSQL_PASS -e "$MYSQL_SCRIPT"
