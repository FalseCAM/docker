Based on this tutorial: https://www.debinux.de/2015/05/mailserver-from-scratch-debian-8/

docker run --name mail-data falsecam/mail-data

docker run --volumes-from mail-data --name mail --link openldap --hostname mail.domain.tld -d falsecam/mail
