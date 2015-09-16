#!/bin/bash

# config php
sed -i "s/^;date.timezone =$/date.timezone = \"Europe\/Berlin\"/" /etc/php5/fpm/php.ini
systemctl reload php5-fpm.service


# certificate
openssl req -new -newkey rsa:4096 -sha256 -days 1095 -nodes -x509 -subj "/C=DE/ST=STATE/L=CITY/O=MAIL/CN=`hostname -f`" -keyout /etc/ssl/`hostname -f`.key  -out /etc/ssl/`hostname -f`.cer
chmod 600 /etc/ssl/`hostname -f`.key
cp /etc/ssl/`hostname -f`.cer /usr/local/share/ca-certificates/
update-ca-certificates

# config nginx
sed -i 's/mail.domain.tld/'"`hostname -f`"'/g' /etc/nginx/sites-available/mailserver
ln -s /etc/nginx/sites-available/mailserver /etc/nginx/sites-enabled/
systemctl reload nginx.service

# config mysql
debconf-set-selections <<< 'mysql-server mysql-server/root_password password changeme'
debconf-set-selections <<< 'mysql-server mysql-server/root_password_again password changeme'
apt-get -y install mysql-server
service mysql start
# ViMbAdmin: Datenbankname vimbadmin, Username vimbadmin
mysql -uroot -pchangeme -e "CREATE DATABASE vimbadmin; GRANT ALL ON vimbadmin.* TO 'vimbadmin'@'localhost' IDENTIFIED BY 'changeme'; FLUSH PRIVILEGES;"
# Roundcube: Datenbankname roundcube, Username roundcube
mysql -uroot -pchangeme -e "CREATE USER 'roundcube'@'localhost' IDENTIFIED BY 'changeme';"
mysql -uroot -pchangeme -e "CREATE DATABASE roundcube; GRANT ALL ON roundcube.* TO 'roundcube'@'localhost' IDENTIFIED BY 'changeme'; FLUSH PRIVILEGES;"

# config roundcube
mysql -uroot -pchangeme roundcube < /var/www/html/webmail/SQL/mysql.initial.sql
chown -R www-data: /var/www/html

# config postfix
sed -i 's/mail.domain.tld/'"`hostname -f`"'/g' /etc/postfix/main.cf

# config dovecot
sed -i 's/mail.domain.tld/'"`hostname -f`"'/g' /etc/dovecot/dovecot.conf

# start services
service mysql start
service php5-fpm start
service nginx start

/bin/bash

