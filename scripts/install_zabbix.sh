#!/bin/bash

set -e

apt update -y
apt upgrade -y


apt install -y curl gnupg2 apache2 mariadb-server php php-mysql libapache2-mod-php unzip wget

wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu22.04_all.deb
dpkg -i zabbix-release_7.0-1+ubuntu22.04_all.deb
apt update -y

apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent zabbix-sql-scripts

mysql -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
mysql -e "create user 'zabbix'@'localhost' identified by 'zabbixpass';"
mysql -e "grant all privileges on zabbix.* to 'zabbix'@'localhost';"
mysql -e "flush privileges;"

until mysqladmin ping -uzabbix -pzabbixpass --silent; do
    echo "Aguardando MariaDB iniciar..."
    sleep 2
done

zcat /usr/share/zabbix-sql-scripts/mysql/server.sql.gz | mysql -uzabbix -pzabbixpass zabbix

sed -i 's/^# DBPassword=/DBPassword=zabbixpass/' /etc/zabbix/zabbix_server.conf

systemctl enable zabbix-server zabbix-agent apache2 mariadb
systemctl restart zabbix-server zabbix-agent apache2 mariadb
