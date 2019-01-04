# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_check_update = false

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "2"
    vb.memory = "2048"
  end

  config.vm.provision "shell", inline: <<-SHELL
    ### PROXY ###
    rm /etc/systemd/system/docker.service.d/http-proxy.conf
    #export http_proxy="http://145.77.103.133:8080"
    #export https_proxy="http://145.77.103.133:8080"

    apt-get -qq update

    ## Install Salt Minion
    # Setup Repo
    wget  -q --no-check-certificate https://repo.saltstack.com/py3/debian/9/amd64/latest/SALTSTACK-GPG-KEY.pub -O salt.pub && apt-key add salt.pub
    echo "deb http://repo.saltstack.com/py3/debian/9/amd64/latest stretch main" > /etc/apt/sources.list.d/saltstack.list
    apt-get -qq update
    apt-get -qq install -y salt-minion

    mkdir -p /srv/salt

    # Copy master config
    cp /vagrant/minion/master.conf /etc/salt/minion.d/master.conf
  SHELL

  config.vm.define "master" do |master|
    master.vm.hostname = "master"
    master.vm.network "private_network", ip: "192.168.50.5"
    master.vm.provision "shell", inline: <<-SHELL

      ### PROXY ###
      rm /etc/systemd/system/docker.service.d/http-proxy.conf
      #export http_proxy="http://145.77.103.133:8080"
      #export https_proxy="http://145.77.103.133:8080"

      # Install Docker
      apt-get install -qq -y docker.io docker-compose
      mkdir -p /etc/systemd/system/docker.service.d
      cp /vagrant/http-proxy.conf /etc/systemd/system/docker.service.d/

      systemctl daemon-reload
      systemctl enable docker
      systemctl start docker

      cp -a /vagrant/master/salt/* /srv/salt/

      cd /vagrant
      docker-compose down
      docker-compose build
      docker-compose up -d --force-recreate --remove-orphans

      # Force delete of master key
      rm -f /etc/salt/pki/minion/minion_master.pub

      # (re)Start salt-minion afterwards
      systemctl restart salt-minion
    SHELL
  end

  config.vm.define "minion1" do |minion1|
    minion1.vm.hostname = "minion1"
    minion1.vm.network "private_network", ip: "192.168.50.10"
    minion1.vm.provision "shell", inline: <<-SHELL
      cp -a /vagrant/minion/salt/* /srv/salt/

      # Force delete of master key
      rm -f /etc/salt/pki/minion/minion_master.pub

      # (re)Start salt-minion afterwards
      systemctl restart salt-minion
    SHELL
  end

  config.vm.define "minion2" do |minion2|
    minion2.vm.hostname = "minion2"
    minion2.vm.network "private_network", ip: "192.168.50.15"
    minion2.vm.provision "shell", inline: <<-SHELL
      cp -a /vagrant/minion/salt/* /srv/salt/

      # Force delete of master key
      rm -f /etc/salt/pki/minion/minion_master.pub

      # (re)Start salt-minion afterwards
      systemctl restart salt-minion
    SHELL
  end
end