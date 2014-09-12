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

while true; do
	etcdctl \
		--peers "${ETCD_PORT_4001_TCP_ADDR}:${ETCD_PORT_4001_TCP_PORT}" \
		set /services/nodeapp/$hn "{ \"host\": \"$SERVICE_IP\", \"port\": $SERVICE_PORT, \"name\": \"$hn\" }" \
		--ttl 20

	sleep 15
done