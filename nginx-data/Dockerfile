FROM centos:centos7

RUN yum -y install openssl
RUN mkdir -p /etc/nginx/conf.d/ && mkdir -p /etc/nginx/certs/

COPY conf/gitlab.conf /etc/nginx/conf.d/gitlab.conf
COPY conf/jenkins.conf /etc/nginx/conf.d/jenkins.conf
COPY conf/ldapaccountmanager.conf /etc/nginx/conf.d/ldapaccountmanager.conf
COPY conf/ldapadmin.conf /etc/nginx/conf.d/ldapadmin.conf
COPY conf/nginx.conf /etc/nginx/nginx.conf

#generate ssl cert
RUN openssl req -x509 -nodes -sha384 -days 3650 -newkey rsa:4096 \
 -subj "/C=XX/ST=XXXX/L=XXXX/O=XXXX/CN=*" \
 -keyout /etc/nginx/certs/server.key -out /etc/nginx/certs/server.crt

VOLUME ["/etc/nginx/conf.d", "/etc/nginx/certs"]
ENTRYPOINT ["hostname"]
