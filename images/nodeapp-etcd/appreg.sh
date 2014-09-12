#!/bin/bash
# register nodeapp in etcd

set -e

# set the docker host ip as SERVICE_IP to be registered with etcd
if [ "$SERVICE_IP" == "" ];then
  export SERVICE_IP=`hostname -i`
fi

# set the SERVICE_PORT to be registered with etcd
if [ "$SERVICE_PORT" == "" ];then
  export SERVICE_PORT=8000
fi

hn=`hostname`
etcd_addr="${ETCD_PORT_4001_TCP_ADDR}:${ETCD_PORT_4001_TCP_PORT}"
value="{ \"host\": \"$SERVICE_IP\", \"port\": $SERVICE_PORT, \"name\": \"$hn\" }"

# rm from etcd when the exit 
function finish {
  echo "etcdctl rm /services/nodeapp/$hn"
  etcdctl --peers $etcd_addr rm /services/nodeapp/$hn
}
trap finish EXIT

# the main reg loop, may be we should test nodeapp is trully up by curl it first
while true; do
	etcdctl --peers $etcd_addr set /services/nodeapp/$hn "$value" --ttl 20
	sleep 15
done