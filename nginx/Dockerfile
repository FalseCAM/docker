FROM centos:centos7
RUN yum -y update; yum clean all
RUN yum -y install http://nginx.org/packages/centos/7/noarch/RPMS/nginx-release-centos-7-0.el7.ngx.noarch.rpm; yum -y makecache
RUN yum -y install nginx-1.8.0
RUN rm /etc/nginx/conf.d/default.conf
RUN rm /etc/nginx/conf.d/example_ssl.conf

RUN mkdir -p /etc/nginx/certs/

COPY conf/nginx.conf /etc/nginx/nginx.conf

VOLUME /etc/nginx/conf.d
VOLUME /etc/nginx/certs

EXPOSE 80 443
CMD ["nginx"]
