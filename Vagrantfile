# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "ubuntu/bionic64"
  config.vm.box_check_update = false

  config.vm.network "forwarded_port", guest: 3276, host: 3276
  config.vm.network "forwarded_port", guest: 8080, host: 8080

  config.vm.provider "virtualbox" do |vb|
    vb.cpus = "2"
    vb.memory = "4096"
  end

  config.vm.provision "shell", inline: <<-SHELL
    export http_proxy="http://145.77.103.133:8080"
    export https_proxy="http://145.77.103.133:8080"
    apt-get update

    # Install Docker
    apt install -y docker.io docker-compose
    mkdir -p /etc/systemd/system/docker.service.d
    cp /vagrant/http-proxy.conf /etc/systemd/system/docker.service.d/
    systemctl daemon-reload
    systemctl enable docker
    systemctl start docker

    ## Install Salt Minion
    # Setup Repo
    wget  --no-check-certificate https://repo.saltstack.com/py3/debian/9/amd64/latest/SALTSTACK-GPG-KEY.pub -O salt.pub && apt-key add salt.pub
    echo "deb http://repo.saltstack.com/py3/debian/9/amd64/latest stretch main" > /etc/apt/sources.list.d/saltstack.list
    apt update
    apt install -y salt-minion
    systemctl start salt-minion

    mkdir -p /srv/salt
    cp -a /vagrant/minion/salt/* /srv/salt/
  SHELL
end
