# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # see https://github.com/AndrewDryga/vagrant-box-osx
  config.vm.box = "http://files.dryga.com/boxes/osx-yosemite-0.2.0.box"

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  config.vm.network "private_network", ip: "192.168.33.10"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

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

  config.vm.provision "file", source: "conda-worker.sh", destination: "conda-worker.sh"
  config.vm.provision "file",
      source: "me.dougal.conda-worker.plist",
      destination: "Library/LaunchAgents/me.dougal.conda-worker.plist"

  # anaconda auth --create -n 'token name' --scopes api:build-worker --out binstar.token
  config.vm.provision "file", source: "binstar.token", destination: ".binstar.token"

  config.vm.provision "shell", privileged: false, inline: <<-SHELL
      brew update
      brew install wget

      # set up anaconda
      wget -N https://repo.continuum.io/miniconda/Miniconda-latest-MacOSX-x86_64.sh
      bash Miniconda-latest-MacOSX-x86_64.sh -b
      export PATH="$HOME/miniconda/bin:$PATH"

      conda config --set always_yes true
      conda install anaconda-build conda-build

      mkdir -p .log
      launchctl load ~/Library/LaunchAgents/me.dougal.conda-worker.plist
  SHELL
end