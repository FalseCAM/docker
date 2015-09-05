docker run -p 53:53/tcp -p 53:53/udp --cap-add=NET_ADMIN -v /etc/hosts:/etc/hosts --name dnsmasq falsecam/dnsmasq
