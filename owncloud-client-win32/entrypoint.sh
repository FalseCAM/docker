sed 's/UsePAM yes/UsePAM no/' -i /etc/ssh/sshd_config
sed 's/#PermitRootLogin yes/PermitRootLogin yes/' -i /etc/ssh/sshd_config
sed 's/#PermitEmptyPasswords no/PermitEmptyPasswords no/' -i /etc/ssh/sshd_config

systemctl enable sshd
systemctl start sshd

useradd -md /home/oc oc
echo 'root:password' | chpasswd
echo 'oc:password' | chpasswd
su - oc -c "mkdir /home/oc/password/.ssh"
id_rsa /home/oc/.ssh/
id_rsa.pub /home/oc/.ssh/
known_hosts /home/oc/.ssh/
authorized_keys /home/oc/.ssh/
chown oc:users -R /home/oc/.ssh
chmod 0700 /home/oc/.ssh && chmod 0600 /home/oc/.ssh/*

sed 's/Defaults *requiretty/#Defaults    requiretty/' -i /etc/sudoers
echo "oc ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers

/bin/bash