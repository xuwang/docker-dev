#! /bin/sh

# Get the local docker host ip address
/sbin/ip route | awk '/default/ { print $3 }' > /etc/host_ip
LOCALHOST_IP=`cat /etc/host_ip`

# Config synapse to use the docker watcher on localhost
sed -ri "s/#LOCALHOST_IP#/${LOCALHOST_IP}/" /etc/synapse.json.conf

# Start the load balancer on port 8080
#service haproxy start

# Start synapse for service discovery
synapse -c /etc/synapse.json.conf