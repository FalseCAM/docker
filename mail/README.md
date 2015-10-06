Based on this tutorial: https://www.debinux.de/2015/05/mailserver-from-scratch-debian-8/

docker run --name mail-data falsecam/mail-data

docker run --volumes-from mail-data --name mail --link openldap --hostname mail.domain.tld -d falsecam/mail


docker run -it --name mail --hostname mail.domain.tld -p 4282:443 -p 25:25 -p 587:587 -p 143:143 -p 993:993 -p 110:110 -p 995:995 -p 4190:4190 --link openldap:openldap -v /srv/mail:/home falsecam/mail
