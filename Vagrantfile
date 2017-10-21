#$script = <<SCRIPT
#echo Generate a private and a public key
#sudo su
#ssh-keygen
#cp /root/.ssh/id_rsa.pub /vagrant
#SCRIPT

# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  config.vm.box = "ubuntu/xenial64"

  # Disable automatic box update checking. If you disable this, then
  # boxes will only be checked for updates when the user runs
  # `vagrant box outdated`. This is not recommended.
  # config.vm.box_check_update = false

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"
  #WARNING: UNPROTECTED PRIVATE KEY FILE!
  # config.vm.synced_folder "./", "/vagrant", owner: "ubuntu", mount_options: ["dmode=775,fmode=600"]
  config.vm.synced_folder "../../source", "/home/ubuntu/workspace/", create: true

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  config.vm.define "database" do |machine|
    machine.vm.provision "shell",
      inline: "sudo apt-get --assume-yes install python-minimal"
    machine.vm.network "public_network", ip: "192.168.10.91"
    machine.vm.network "forwarded_port", guest: 22, host: 2233, id: 'ssh'
    machine.vm.network "forwarded_port", guest: 3306, host: 3306 #MySQL
    machine.vm.network "forwarded_port", guest: 5432, host: 5432 #PostgreSQL
    machine.vm.network "forwarded_port", guest: 27017, host: 27017 #MongoDB
    machine.vm.network "forwarded_port", guest: 6379, host: 6379 #Redis
    machine.vm.network "forwarded_port", guest: 5672, host: 5672 #RabbitMQ
    machine.vm.network "forwarded_port", guest: 11300, host: 11300 #Beanstalkd
  end
  config.vm.define "api" do |machine|
    machine.vm.provision "shell",
      inline: "sudo apt-get --assume-yes install python-minimal"
    machine.vm.network "public_network", ip: "192.168.10.92"
    machine.vm.network "forwarded_port", guest: 22, host: 2234, id: 'ssh'
    machine.vm.network "forwarded_port", guest: 3000, host: 3002 #Node.js
    machine.vm.network "forwarded_port", guest: 8080, host: 8082 #Jenkins
  end
  config.vm.define "web1" do |machine|
    machine.vm.provision "shell",
      inline: "sudo apt-get --assume-yes install python-minimal"
    machine.vm.network "public_network", ip: "192.168.10.93"
    machine.vm.network "forwarded_port", guest: 22, host: 2235, id: 'ssh'
    machine.vm.network "forwarded_port", guest: 3000, host: 3003 #Node.js
    machine.vm.network "forwarded_port", guest: 4200, host: 4203 #Angular
    machine.vm.network "forwarded_port", guest: 8000, host: 8003 #Django
  end
  config.vm.define "web2" do |machine|
    machine.vm.provision "shell",
      inline: "sudo apt-get --assume-yes install python-minimal"
    machine.vm.network "public_network", ip: "192.168.10.94"
    machine.vm.network "forwarded_port", guest: 22, host: 2236, id: 'ssh'
    machine.vm.network "forwarded_port", guest: 3000, host: 3004 #Node.js
    machine.vm.network "forwarded_port", guest: 4200, host: 4204 #Angular
    machine.vm.network "forwarded_port", guest: 8000, host: 8004 #Django
  end
  config.vm.define "controller" do |machine|
    machine.vm.network "public_network", ip: "192.168.10.90"
    machine.vm.network "forwarded_port", guest: 22, host: 2237, id: 'ssh'

  #  machine.vm.provision "create-key",
  #    type: "shell",
  #    preserve_order: true,
  #    inline: $script,
  #    run: "once",
  #    upload_path: "",
  #    privileged: true

    machine.vm.provision "ansible_local" do |ansible|
      ansible.verbose = "vvv"
      ansible.playbook        = "provisioning/playbook.yml"
  #    ansible.groups          = {
  #      "allmachines" => ["controller", "database", "api", "web[1:2]"],
  #      "dbmachines" => ["database"],
  #      "apimachines" => ["api"],
  #      "webmachines" => ["web[1:2]"]
  #    }
      ansible.install_mode    = "pip"
  #    ansible.install_mode  = "pip_args_only"
  #    ansible.pip_args      = "-r /vagrant/requirements.txt"
      ansible.version         = "2.4.0.0"
      ansible.limit           = "all,localhost" #if tasks not running
      ansible.inventory_path  = "provisioning/inventory"
    end
  end
  config.vm.provision "shell",
    inline: "sudo apt-get --assume-yes install python-minimal"

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   apt-get update
  #   apt-get install -y apache2
  # SHELL
end
