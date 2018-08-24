# Codeyourinfra Vagrant Boxes

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

The Codeyourinfra Vagrant boxes are available at Vagrant Cloud, in https://app.vagrantup.com/codeyourinfra.

For creating the Vagrant box, follow the steps:

1. `vagrant up`
2. `vagrant ssh`
   1. `sudo apt-get clean`
   2. `sudo rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*`
   3. `sudo dd if=/dev/zero of=/EMPTY bs=1M`
   4. `sudo rm -f /EMPTY`
   5. `cat /dev/null > ~/.bash_history && history -c && exit`
3. `vagrant package --output vagrant.box`
4. `vagrant box add --name codeyourinfra/vagrant-box vagrant.box`
5. `vagrant destroy -f && rm -rf *.retry .vagrant/`

