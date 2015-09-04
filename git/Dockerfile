FROM debian:8.1

RUN apt-get -y update
RUN apt-get -y install openssh-server
RUN apt-get -y install git

RUN mkdir /var/run/sshd

RUN adduser --system git
RUN mkdir -p /home/git/.ssh
RUN echo 'git:password' | chpasswd
RUN mkdir -p /repos

RUN sed -i s#/home/git:/bin/false#/home/git:/bin/bash# /etc/passwd

EXPOSE 22
CMD ["/usr/sbin/sshd", "-D"]
