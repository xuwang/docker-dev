#!/bin/bash -x

IP=$(cat /etc/hosts | head -n1 | awk '{print $1}')
PORT=9092

cat /kafka/config/server.properties.tmpl \
  | sed "s|{{ZK_CONNECT}}|${ZK_CONNECT:-zookeeper:2181}|g" \
  | sed "s|{{BROKER_ID}}|${BROKER_ID:-0}|g" \
  | sed "s|{{EXPOSED_HOST}}|${EXPOSED_HOST:-$IP}|g" \
  | sed "s|{{PORT}}|${PORT:-$PORT}|g" \
  | sed "s|{{EXPOSED_PORT}}|${EXPOSED_PORT:-$PORT}|g" \
   > /kafka/config/server.properties
   
cp -f /kafka/config/server.properties /logs

export CLASSPATH=$CLASSPATH:/kafka/lib/slf4j-log4j12.jar

echo "Starting kafka"
/kafka/bin/kafka-server-start.sh /kafka/config/server.properties 2>&1 | tee /logs/kafka.log