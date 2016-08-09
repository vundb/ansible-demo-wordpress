#!/bin/bash
# Shell script to install LAMP with dependencies for running PHP applications
# with mod_fcgi
# -------------------------------------------------------------------------
# Version 1.1 (August 18 2011)
# -------------------------------------------------------------------------
# Copyright (c) 2011 Finn Hensner <http://www.gerillafilm.se>
# This script is licensed under GNU GPL version 2.0 or above
# -------------------------------------------------------------------------
apt-get update
aptitude install apache2 apache2-suexec libapache2-mod-fcgid php5-cgi
a2dismod php5
a2enmod rewrite
a2enmod suexec
a2enmod include
a2enmod fcgid

apt-get install mysql-server
apt-get install php5-gd
apt-get install php5-common php5-mysql

sleep 1
echo "Adding extensions and fixes to custom ini"
cat > /etc/php5/conf.d/custom.ini << EOF
cgi.fix_pathinfo = 1
extension=gd2.so
extension=pdo.so
extension=pdo_mysql.so
extension=php_pgsql.so
extension=php_pdo_pgsql.so
EOF

sleep 1
echo "Add server name to Apache config"
echo "ServerName 127.0.0.1" >> /etc/apache2/apache2.conf

sleep 1
echo "Installing ProFTPd server"
apt-get purge proftpd
apt-get install proftpd
#jail users in their home directory
echo -e "<Global>\nDefaultRoot ~\n</Global>" >> /etc/proftpd/proftpd.conf

sleep 1
echo "Removing default virtual host."
rm /etc/apache2/sites-available/default
rm /etc/apache2/sites-enabled/default-000

sleep 1
echo "Restarting apache2 and proftpd"
service apache2 restart
service proftpd restart
