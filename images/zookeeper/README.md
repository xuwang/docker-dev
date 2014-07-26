docker-zookeeper
================

Builds a docker image for Zookeeper.

```
docker build -t <user>/zookeeper:3.4.6 .

docker run -d <zk-image-id>
	
echo stat | nc <container-ip> 2181
```