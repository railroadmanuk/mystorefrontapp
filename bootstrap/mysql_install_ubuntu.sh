#!/bin/bash
apt-get update -y && apt-get upgrade -y
debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password password VMware1!'
debconf-set-selections <<< 'mysql-server-5.6 mysql-server/root_password_again password VMware1!'
apt-get install mysql-server -y
