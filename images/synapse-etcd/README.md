# Synapse docker ambassador container with etcd

This container is a simple (1 service/port) ambassador container,
using the etcd service watcher.

Example of how you would use this container:

    docker run \
		-d \
		-e SYNAPSE_APP=my_app \
		-e SYNAPSE_PORT=8000 \
		--link etcd:etcd \
		--name synapse-etcd

This makes a container which runs a haproxy on port 8000, and subscribes to the key ``/services/my_app`` in etcd

Use [etcdctl](https://github.com/coreos/etcdctl.git) to register your service:

	etcdctl --peers <etcd_ip:etcd_port> \
		set /services/my_app/$SERVICE_NAME \
			"{ \"host\": \"$SERVICE_IP\", \"port\": $SERVICE_PORT, \"name\": \"$SERVICE_NAME\" }" \
		--ttl 20
