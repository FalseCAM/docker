docker run --name bind9-data falsecam/bind9-data
docker run --volumes-from bind9-data --name bind9 -p 53:53 -p 53:53/udp -d falsecam/bind9
