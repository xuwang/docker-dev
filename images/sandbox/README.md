docker-sandbox
================

Builds a docker image for sandbox.

### Installed packages:
	* openssh-server  
	* git 
	* curl 
	* wget 
	* build-essential 
	* mysql-client-5.6 
	* fortune-mod
	* kafkacat

### Build
```
docker build -t <user>/sandbox .
```

### Run 

```
docker run -d --link kafka:kafka --link mysql:mysql <user>/sandbox   # for ssh

```
or simply
```
docker run -it --rm <user>/sandbox bash -l
```
