#!/usr/bin/env bash

sudo apt-get install -y build-essential
sudo apt-get install -y mysql-server
sudo apt-get install -y php5 php5-mysql
sudo apt-get install -y apache2
sudo apt-get install -y ...

sudo tee /etc/apache2/sites-available/mysite <<ENDOFFILE
    <VirtualHost *:80>
        Include /etc/apache2/sites-available/mysyte-common
    </VirtualHost>
ENDOFFILE

sudo rc-update add mysql default
sudo rc-update add apache2 default
