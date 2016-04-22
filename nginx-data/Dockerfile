FROM centos:centos7

RUN yum -y install openssl
RUN mkdir -p /etc/nginx/conf.d/ && mkdir -p /etc/nginx/certs/

COPY conf/ldapaccountmanager.conf /etc/nginx/conf.d/ldapaccountmanager.conf
COPY conf/owncloud.conf /etc/nginx/conf.d/owncloud.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

#generate ssl cert
RUN openssl req -x509 -nodes -sha384 -days 3650 -newkey rsa:4096 \
 -subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/CN=*" \
 -keyout /etc/nginx/certs/server.key -out /etc/nginx/certs/server.crt

VOLUME ["/etc/nginx/conf.d", "/etc/nginx/certs"]
ENTRYPOINT ["hostname"]
