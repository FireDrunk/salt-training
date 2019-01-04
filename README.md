# Basics:

2 Docker images: Master / Minion

1 Docker Compose file to install 1 Master and *NO* Minions. (The minion is just for educational purposes)
- It passes the master/minion directories via volumes to the container.

Vagrantfile creates 3 machines with salt-minion preinstalled, and runs the docker-compose up on the 'master' guest vm.

To Use:

- Install Virtualbox (5.x NOT 6!)
- Install Vagrant
- Go to repo directory
- Execute: ```vagrant up```
- Wait till completes, watch for errors!
- To enter the machine, execute: ```vagrant ssh <machine>```
  - Machines are called: ```master```, ```minion1``` and ```minion2```
- You can access the local salt-minion with ```salt-call --local <function>```
- To run a command on the master use: ```sudo docker exec -it vagrant_salt_1 salt '<group>' <function>```
- To run a command on a docker minion use: ```sudo docker exec -it vagrant_minion1_1 salt-call --local <function>```

# !!! WARNING !!!
This repo is **PURELY** for educational/workshop purposes.
DO NOT, I repeat: **DO NOT** use this in production in **_ANY WAY!_**

The Salt Master autoaccepts **ALL** keys, so any minion will be added/accepted automatically.
Which is pretty insecure by design :-) 