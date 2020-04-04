# -*- mode: ruby -*-
# vi: set ft=ruby :

# Config Github Settings
github_username = "SimpCosm"
github_repo     = "Vagrant"
github_branch   = "master"
github_url      = "https://raw.githubusercontent.com/#{github_username}/#{github_repo}/#{github_branch}"

vboxname        = "ubuntu/xenial64"
hostname        = "cosmos"

# Set a local private network IP address.
# See http://en.wikipedia.org/wiki/Private_network for explanation
# You can use the following IP ranges:
#   10.0.0.1    - 10.255.255.254
#   172.16.0.1  - 172.31.255.254
#   192.168.0.1 - 192.168.255.254
server_ip             = "192.168.22.10"
server_cpus           = "2"   # Cores
server_memory         = "2048" # MB

# UTC        for Universal Coordinated Time
# EST        for Eastern Standard Time
# CET        for Central European Time
# US/Central for American Central
# US/Eastern for American Eastern
server_timezone  = "UTC"

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.
Vagrant.configure("2") do |config|
  config.vm.box = vboxname
  config.vm.hostname = hostname

  # Create a static IP
  if Vagrant.has_plugin?("vagrant-auto_network")
    config.vm.network :private_network, :ip => "0.0.0.0", :auto_network => true
  else
    config.vm.network :private_network, ip: server_ip
    config.vm.network :forwarded_port, guest: 80, host: 8000
  end

  # shared folder
  config.vm.synced_folder "../data", "/home/vagrant/workspace"

  # Enable agent forwarding over SSH connections
  config.ssh.forward_agent = true

  # If using VirtualBox
  config.vm.provider "virtualbox" do |vb|
    vb.customize ["modifyvm", :id, "--cpus", server_cpus]
    vb.customize ["modifyvm", :id, "--memory", server_memory]

    disk = "system.vmdk"
    unless File.exist?(disk)
      vb.customize [ "createmedium", "disk", "--filename", disk, "--format", "vmdk", "--size", 1024 * 40 ]
    end
    vb.customize ['storageattach', :id, '--storagectl', "SCSI", '--port', 2, '--device', 0, '--type', 'hdd', '--medium', disk]
  end

  # Replicate local .gitconfig file if it exists
  # if File.file?(File.expand_path("~/.gitconfig"))
  #   config.vm.provision "file", source: "~/.gitconfig", destination: ".gitconfig"
  # end

  ####
  # Base Items
  ##########

  # Optimize Ubuntu Mirror List
  config.vm.provision "shell", path: "#{github_url}/scripts/mirrors.sh", privileged: true

  # Provision Base Packages
  config.vm.provision "shell", path: "#{github_url}/scripts/base.sh", args: [github_url, server_timezone]

  # Provision Vim
  config.vm.provision "shell", path: "#{github_url}/scripts/vim.sh", args: github_url

  # Provision Docker
  # config.vm.provision "shell", path: "#{github_url}/scripts/docker.sh", args: "permissions"

  # Install Python
  # config.vm.provision "shell", path: "#{github_url}/scripts/python.sh", privileged: false, args: [python_version]

  # Install Go Version Manager (GVM)
  config.vm.provision "shell", path: "#{github_url}/scripts/go.sh", privileged: false, args: [go_version], privileged: true

end
