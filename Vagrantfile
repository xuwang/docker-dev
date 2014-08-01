# -# -*- mode: ruby -*-
# vi: set ft=ruby :

# Make sure use a "docker ready" base image
BOX_NAME = ENV['BOX_NAME'] || "docker"
BOX_URI = ENV['BOX_URI'] || 
          '../ubuntu-14.04-amd64-vbox.box' ||
          "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"
            
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant::VERSION >= "1.6.3" and Vagrant::Config.run do |config|  
  # Setup virtual machine box. This VM configuration code is always executed.
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

  #Registry
  config.vm.forward_port 5000, 5000
  
  #Registry-UI
  config.vm.forward_port 5080, 5080
  
  #Shipyard
  config.vm.forward_port 8005, 8005
  
  #Shipyard agent
  config.vm.forward_port 4500, 4500
  
  #redis
  config.vm.forward_port 6379, 6379

  #logstash ui
  config.vm.forward_port 9292 9292
  
  #elasticsearch
  config.vm.forward_port 9200, 9200
  config.vm.forward_port 9300, 9300

  #cassandra
  config.vm.forward_port 7000, 7000
  config.vm.forward_port 7001, 7001
  config.vm.forward_port 7199, 7199
  config.vm.forward_port 9160, 9160
  config.vm.forward_port 9042, 9042

  #mongo
  config.vm.forward_port 27017, 27017
  config.vm.forward_port 28017, 28017

  #kafka
  config.vm.forward_port 9092, 9092
  config.vm.forward_port 7203, 7203

  #zookeeper
  config.vm.forward_port 2181, 2181

  #jetty
  config.vm.forward_port 8080, 8080

  #Storm UI
  config.vm.forward_port 8081, 8081
  
  #mysql
  config.vm.forward_port 3306, 3306
  
  #sandbox
  config.vm.forward_port 8100, 8100
  config.vm.forward_port 8101, 8101
  config.vm.forward_port 8102, 8102
  config.vm.forward_port 8103, 8103
  config.vm.forward_port 8104, 8104
  
  # Installing Docker (latest) onto machine
  config.vm.provision :docker do |d|
  end
  config.vm.provision :shell, :inline => "sudo /vagrant/bin/dk stop; sudo /vagrant/bin/dk update && sudo /vagrant/bin/dk start" 
end
  

Vagrant::VERSION >= "1.6.3" and Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :virtualbox do |vb|
    config.vm.box = BOX_NAME
    config.vm.box_url = BOX_URI
    #memory
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end
  
end



