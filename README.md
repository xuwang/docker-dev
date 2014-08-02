## Instant Docker Development Environment With VirtualBox and Vagrant

### Overview

We are going to use a Ubuntu Vagrant VM as Docker host and us an orchestration script to manage the following applications in the docker environment:

* Private local docker registry
* Zookeeper - Zookeeper service
* Kafka - use Zookeeper service 
* Shipyard - UI to display all dockers on the docker host. 
* Mysql - a mysql server
* Phpmyadmin - UI interface to the MySQL server
* Sandbox - an container with mysql client to connect to mysql server, and kafkacat to demonstrate kafka consumer and producer to monitor logs

....

These are just examples to show how to setup your apps to run in this development environment. 
 
### Install VirtualBox and Vagrant

Get the latest version for VirtualBox and Vagrant. This ensure that Vagrant has docker support:

* Install VirtualBox: [VirtualBox download page](https://www.virtualbox.org/wiki/Downloads)
* Install Vagrant: [Vagrant download page](http://www.vagrantup.com/downloads.html)
* Install Vagrant Guest Additions Plugin

        vagrant plugin install vbguest

#### Check out this repository

The following will clone the repository into your current directory under docker-dev:

        git clone https://github.com/xuwang/docker-dev
        cd docker-dev

#### Fire up VM and update Dockers

You can take a quick look at *Vagrantfile* under docker-dev. The vagrant configuration file tells Vagrant to
download docker-ready ubuntu-14.04 image, configure port mappings for all the docker services that
we will run in this environment, and start the services in their isolated containers after the VM is up.

        vagrant up

The default docker containers that will be started are a private image registry service and a shipyard UI application to manage all containers running on the host.

#### Check docker status
    
        ./bin/vdk status

### Configure The Docker Web UI: Shipyard

[Shipyard](http://localhost:8005/) should be up by now. The credentials are "admin/shipyard".

* Go to http://localhost:8005/hosts/ to enable docker hosts.

### Docker Local Registry Web UI: docker-registry-ui

[docker-registry-ui](https://github.com/atc-/docker-registry-web) should also be up by now.

* Go to [http://localhost:5080](http://localhost:5080)


### Manage dockers

You can manage dockers using bin/vdk without having to login to VM. vdk run starts a vagrant ssh and execute bin/dk command in the VM.

The following examples show how to use dk command within Vagrant docker server.  

### Login to docker server and run 'dk' command

        vagrant ssh

*/vagrant/bin/dk* is available to let you easily manage dockers.

        sudo /vagrant/bin/dk help

For example, if you want to start a redis docker:

        sudo /vagrant/bin/dk start redis

See all available dockers pre-build for this development environment:

        sudo /vagrant/bin/dk list

Check status:

       sudo /vagrant/bin/dk list

Stop all dockers:

       sudo /vagrant/bin/dk stop

### How to add new docker application 

Under /vagrant/bin directory, each *start_app* is a wrapper around docker run command to setup the necessary container environment, service dependencies and then run "docker run" to start the docker. Here is an example of start_kafka. It checks if zookeeper is running, and starts it if not, then runs kafka:
	
	#!/bin/bash

	APPS=${APPS:-/mnt/apps}

	SCRIPT_HOME="$( cd "$( dirname "$0" )" && pwd )"
	. $SCRIPT_HOME/env.sh

	#build first
	dockbuild_if_missing  kafka

	if ! is_running zookeeper; then start_zookeeper; fi

	# workaround a bug in kafka 0.8.1.1 KAFKA-1451 
	while echo dump | nc `getip zookeeper` 2181 | grep '/controller'
	do
	        echo waiting zookeeper to expire old leader
	        sleep 5
	done

	KAFKA=$(docker run \
		-d \
		-p 9092:9092 \
		-v $APPS/kafka/data:/data \
		-v $APPS/kafka/logs:/logs \
		--name kafka \
		--link zookeeper:zookeeper \
		kafka
	    )
	echo "Started KAFKA in container $KAFKA"


If you add new a container, make sure you name it as bin/start-\<app\> script to enable auto provisioning. To run your app in a container:

        /vagrant/bin/dk start <app-name>

When building your own docker, put the command 'dockbuild_if_missing \<app-name\>' at the top of the start\_<app-name\> script. _dockbuild\_if\_missing_ will look for build files under _images_  directory and build docker image according to the specs. 

### Update, Stop, Tear Down, Etc.

        vagrant provision		# pull all the images from the server and update containers
        vagrant ssh					# ssh to the docker VM
        vagrant halt				# bring down the VM
        vagrant destroy         	# destroy the VM
        vagrant box remove docker	# remove the VBox from the system


