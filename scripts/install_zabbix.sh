#!/bin/bash
apt update -y
apt upgrade -y
apt install -y curl gnupg2 apache2 mysql-server php php-mysql libapache2-mod-php unzip wget

# Adiciona o repositório Zabbix 7.0 LTS
wget https://repo.zabbix.com/zabbix/7.0/ubuntu/pool/main/z/zabbix-release/zabbix-release_7.0-1+ubuntu22.04_all.deb
dpkg -i zabbix-release_7.0-1+ubuntu22.04_all.deb
apt update -y

# Instala Zabbix
apt install -y zabbix-server-mysql zabbix-frontend-php zabbix-apache-conf zabbix-agent

# Configura banco de dados
mysql -e "create database zabbix character set utf8mb4 collate utf8mb4_bin;"
mysql -e "create user zabbix@localhost identified by 'zabbixpass';"
mysql -e "grant all privileges on zabbix.* to zabbix@localhost;"
zcat /usr/share/doc/zabbix-server-mysql*/create.sql.gz | mysql -uzabbix -pzabbixpass zabbix

# Configura Zabbix
sed -i 's/^# DBPassword=/DBPassword=zabbixpass/' /etc/zabbix/zabbix_server.conf

# Inicia serviços
systemctl enable zabbix-server zabbix-agent apache2 mysql
systemctl restart zabbix-server zabbix-agent apache2
