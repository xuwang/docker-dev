## Instant Docker Development Environment With VirtualBox and Vagrant

### Overview

We are going to use a Ubuntu Vagrant VM as Docker host and manage the following applications in the docker environment:

* Private local docker registry
* Zookeeper - Zookeeper service
* Kafka - use Zookeeper service 
* Shipyard - UI to display all dockers on the docker host. 
* Mysql - a mysql server
* Phpmyadmin - UI interface to the MySQL server
* Sandbox - an container with mysql client to connect to mysql server, and kafkacat to demonstrate kafka consumer and producer to monitor logs

These are just examples to show how to setup your apps to run in this development environment. 
 
### Install VirtualBox and Vagrant

Get the latest version for VirtualBox and Vagrant. This ensure that Vagrant has docker support:

* Install VirtualBox: [VirtualBox download page](https://www.virtualbox.org/wiki/Downloads)
* Install Vagrant: [Vagrant download page](http://www.vagrantup.com/downloads.html).
* Install Vagrant Guest Additions Plugin

        vagrant plugin install vbguest

#### Check out this repository

The following will clone the repository into your current directory under docker-dev:

        git clone https://github.com/xuwang/docker-dev
        cd docker-dev

#### Fire up VM and update Dockers

You can take a quick look at *Vagrantfile* under docker-dev. The vagrant configuration file tells vagrant to
download docker ready ubuntu-14.04 image, configure port mappings for all the docker services that
we will run in this environment, and start the services in their isolated contains after the VM is up.

        vagrant up

The default docker processes that will be started are a private image registry service and a shipyard UI application to manage all contains running on the host.

#### Check docker status
Now the Docker Host VM is ready and you can ssh to it and check the docker status:

		vagrant ssh
		sudo dk status

### Start The Docker Web UI: Shipyard:

You can start up Shipyard (https://github.com/shipyard/shipyard):

		sudo dk start shipyard

Go to shipyard hosts page (http://localhost:8005/hosts/) to enable docker hosts (the credentials are "admin/shipyard").

### Docker Local Registry Web UI: docker-registry-ui

If you want to run you own local docker registry, simply:

		sudo dk start registry-ui
		
docker-registry-ui (https://github.com/atc-/docker-registry-web) should also be up by now.

Go to docker-registry-ui (http://localhost:5080)

### Manage applications

You manage dockers using bin/vdk without having to login to VM. vdk runs ssh and execute  bin/dk command in the VM.

The following examples show how to use dk command within vagrant

### Login to docker server
        vagrant ssh

*/vagrant/bin/dk* is available to let you easily manage all the services.

        sudo dk help

For example, if you want to start a redis service:

        sudo dk start redis

See all available dockers:

        sudo dk list

### How to add new application 

Under /vagrant/bin directory, each *_start_app* is a wrapper around docker run command to setup the necessary container environment, service dependencies and then run "docker run" to start the docker. 

Here is an example of start_kafka. It checks if zookeeper is running, and start it if not, then run kafka:
	
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


If you add new a container, make sure you add them as bin/start-app script to allow script for enabling auto provisioning. To run your app in a container:

        sudo dk start <app-name>

### Update, Stop, Tear Down, Etc.

        vagrant provision		# pull all the images from the server and update containers
        vagrant ssh					# ssh to the docker VM
        vagrant halt				# bring down the VM
        vagrant destroy         	# destroy the VM
        vagrant box remove docker	# remove the VBox from the system


