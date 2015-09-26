FROM debian:jessie

MAINTAINER falsecam

RUN export DEBIAN_FRONTEND="noninteractive"
RUN apt-get update 
RUN apt-get -y install debconf-utils rsyslog nginx-full php-auth-sasl php-http-request php-mail \
	php-mail-mime php-mail-mimedecode php-net-dime php-net-smtp php-net-socket php-net-url \
	php-pear php-soap php5 php5-cli php5-common php5-curl php5-fpm php5-gd php5-imap \
	php-apc php5-intl php5-mcrypt php5-mysql libawl-php php5-xmlrpc mysql-client ca-certificates \
	git curl wget vim openssh-server \
	clamav clamav-daemon amavisd-new spamassassin \
	arj bzip2 cabextract cpio file gzip nomarch pax unzip zoo zip

RUN echo "postfix postfix/main_mailer_type select No configuration" | debconf-set-selections && \
	apt-get install -y postfix postfix-ldap postfix-pcre

COPY mailserver.nginx /etc/nginx/sites-available/mailserver
RUN ln -s /etc/nginx/sites-available/mailserver /etc/nginx/sites-enabled/

RUN apt-get install dovecot-common dovecot-core dovecot-imapd dovecot-lmtpd dovecot-managesieved dovecot-sieve dovecot-mysql dovecot-ldap && \
	groupadd -g 5000 vmail && \ 
	useradd -g vmail -u 5000 vmail -d /var/vmail && \
	mkdir /var/vmail && \
	chown -R vmail: /var/vmail/

RUN echo "@bypass_virus_checks_maps = (\%bypass_virus_checks, \@bypass_virus_checks_acl, \$bypass_virus_checks_re);" >> /etc/amavis/conf.d/15-content_filter_mode
RUN echo "@bypass_spam_checks_maps = (\%bypass_spam_checks, \@bypass_spam_checks_acl, \$bypass_spam_checks_re);" >> /etc/amavis/conf.d/15-content_filter_mode
RUN freshclam

WORKDIR /var/www/html
RUN wget --content-disposition -O - http://sourceforge.net/projects/roundcubemail/files/latest/download | tar xfvz -
RUN mv roundcubemail-* webmail

VOLUME /etc/postfix
VOLUME /var/vmail
VOLUME /etc/dovecot

WORKDIR /

RUN curl -sS https://getcomposer.org/installer | php
RUN mv composer.phar /usr/local/bin/composer
RUN composer create-project opensolutions/vimbadmin /srv/vimbadmin -s dev -n --keep-vcs
RUN chown -R www-data: /srv/vimbadmin/public && chown -R www-data: /srv/vimbadmin/var
RUN ln -s /srv/vimbadmin/public/ /var/www/html/admin
RUN cp /srv/vimbadmin/application/configs/application.ini.dist /srv/vimbadmin/application/configs/application.ini

COPY entrypoint.sh /entrypoint.sh
COPY postfix-main.cf /etc/postfix/main.cf
COPY master.cf /etc/postfix/master.cf
COPY postfix-mysql-virtual_alias_maps.cf /etc/postfix/mysql/postfix-mysql-virtual_alias_maps.cf
COPY postfix-mysql-virtual_domains_maps.cf /etc/postfix/mysql/postfix-mysql-virtual_domains_maps.cf
COPY postfix-mysql-virtual_mailbox_maps.cf /etc/postfix/mysql/postfix-mysql-virtual_mailbox_maps.cf
COPY postfix-mysql-virtual_transport_maps.cf /etc/postfix/mysql/postfix-mysql-virtual_transport_maps.cf

COPY postfix-ldap-sender_login_maps.cf /etc/postfix/ldap/postfix-ldap-sender_login_maps.cf
COPY postfix-ldap-virtual_mailbox_maps.cf /etc/postfix/ldap/postfix-ldap-virtual_mailbox_maps.cf
COPY postfix-ldap-virtual_group_maps.cf /etc/postfix/ldap/postfix-ldap-virtual_group_maps.cf
COPY postfix-ldap-aliases.cf /etc/postfix/ldap/postfix-ldap-aliases.cf

COPY dovecot.conf /etc/dovecot/dovecot.conf
COPY dovecot-mysql.conf /etc/dovecot/dovecot-mysql.conf
COPY dovecot-ldap.conf /etc/dovecot/dovecot-ldap.conf
COPY config.inc.php /var/www/html/webmail/config/config.inc.php

ENTRYPOINT ["/entrypoint.sh"]

# Ports: HTTP HTTPS SMTP SMTPS POP3 POP3S IMAP IMAPS SIEVE
EXPOSE  80 443 25 587 143 993 110 995 4190
