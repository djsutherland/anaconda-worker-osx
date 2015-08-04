# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure(2) do |config|
  # see https://github.com/AndrewDryga/vagrant-box-osx
  config.vm.box = "http://files.dryga.com/boxes/osx-yosemite-0.2.0.box"

  # config.vm.provider "virtualbox" do |vb|
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end

  config.vm.provision "file", source: "conda-worker.sh", destination: "conda-worker.sh"
  config.vm.provision "file",
      source: "me.dougal.conda-worker.plist",
      destination: "Library/LaunchAgents/me.dougal.conda-worker.plist"

  # Create this file manually; contents should be like USERNAME/QUEUENAME
  config.vm.provision "file", source: "queuename", destination: "queuename"

  # Create this file with:
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
