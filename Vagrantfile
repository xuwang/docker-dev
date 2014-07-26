# -# -*- mode: ruby -*-
# vi: set ft=ruby :

# Make sure use a "docker ready" base image
BOX_NAME = ENV['BOX_NAME'] || "docker"
BOX_URI = ENV['BOX_URI'] || 
          '../ubuntu-14.04-amd64-vbox.box' ||
          "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vbox.box"
VF_BOX_URI = ENV['BOX_URI'] || 
            "../ubuntu-14.04-amd64-vmwarefusion.box" ||
            "https://oss-binaries.phusionpassenger.com/vagrant/boxes/latest/ubuntu-14.04-amd64-vmwarefusion.box"
            
# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant::VERSION >= "1.6.3" and Vagrant::Config.run do |config|  
  # Setup virtual machine box. This VM configuration code is always executed.
  config.vm.box = BOX_NAME
  config.vm.box_url = BOX_URI

  #Shipyard
  config.vm.forward_port 8005, 8005
  #Shipyard agent
  config.vm.forward_port 4500, 4500
  #redis
  config.vm.forward_port 6379, 6379
  
  # Installing Docker (latest) onto machine
  config.vm.provision :docker do |d|
  end
  config.vm.provision :shell, :inline => "sudo /vagrant/bin/dock stop; sudo /vagrant/bin/dock update && sudo /vagrant/bin/dock start" 
end
  

Vagrant::VERSION >= "1.6.3" and Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  config.vm.provider :vmware_fusion do |f, override|
    override.vm.box = BOX_NAME
    override.vm.box_url = VF_BOX_URI
    #override.vm.synced_folder ".", "/vagrant", disabled: true
    f.vmx["displayName"] = BOX_NAME
  end

  config.vm.provider :virtualbox do |vb|
    config.vm.box = BOX_NAME
    config.vm.box_url = BOX_URI
    #memory
    vb.customize ["modifyvm", :id, "--memory", "2048"]
  end
  
end



