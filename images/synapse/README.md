# HAProxy with Synapse #

Synapse is Airbnb's new system for service discovery.
Synapse solves the problem of automated fail-over in the cloud, where failover via network re-configuration is impossible.
The end result is the ability to connect internal services together in a scalable, fault-tolerant way.

See https://github.com/airbnb/synapse or https://github.com/bobtfish/synapse (with etcd watcher)
    

A docker usage example: http://adetante.github.io/articles/service-discovery-with-docker-1