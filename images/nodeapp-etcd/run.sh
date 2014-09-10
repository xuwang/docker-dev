#!/bin/bash

# set the docker host ip as SERVICE_IP to be registered with etcd
if [ "$SERVICE_IP" == "" ];then
  /sbin/ip route | awk '/default/ { print $3 }' > /etc/host_ip
  export SERVICE_IP=`cat /etc/host_ip`
fi

# set the SERVICE_PORT to be registered with etcd
if [ "$SERVICE_POrT" == "" ];then
  export SERVICE_PORT=8000
fi

exec /usr/bin/supervisord

