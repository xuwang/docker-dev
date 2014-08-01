## Instant Docker Development Environment With VirtualBox and Vagrant

### Installation:

#### Rerequisites: Install VirtualBox and Vagrant 
* Install VirtualBox: [VirtualBox download page](https://www.virtualbox.org/wiki/Downloads).
* Install Vagrant Guest Additions Plugin
```
vagrant plugin install vbguest
```

#### Check out the repository
```
git clone https://github.com/xuwang/docker-dev
cd docker-dev
```

#### Fire Up VM and Update Dockers
```
vagrent up			# bring up the VM and provisioning docker containers
```

#### Check docker status.
```
./bin/vdk status
```
### Configure The Docker Web UI: Shipyard

[Shipyard](http://localhost:8005/) should be up by now. The credentials are "admin/shipyard".

* Go to http://localhost:8005/hosts/ to enable docker hosts.

### Docker Local Registry Web UI: docker-registry-ui

[docker-registry-ui](https://github.com/atc-/docker-registry-web) should also be up by now.

* Go to [http://localhost:5080](http://localhost:5080).

### Update, Stop, Tear Down, Etc.

```
vagrant provision		# pull all the images from the server and update containers
vagrant ssh					# ssh to the docker VM
vagrant halt				# bring down the VM
vagrant destroy         	# destroy the VM
vagrant box remove docker	# remove the VBox from the system
```

### What's Next?

If you add new containers, make sure you add the bin/start-app script and pull cmd to 
in bin/dk script for enabling auto provisioning.

It's all yours now ...

