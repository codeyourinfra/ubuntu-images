#!/bin/bash

echo "Updating the vagrant box, if necessary"
vagrant box update

echo "Bootstrapping the jenkins server"
vagrant up --no-provision

echo "Provisioning the server with the latest Oracle Java 8 and Jenkins"
vagrant provision

echo "Baking the jenkins server"
vagrant package --output jenkins.box

echo "Removing the jenkins server"
vagrant destroy -f

echo "Cleaning up everything and exiting"
rm -rf .vagrant/ ubuntu-xenial-16.04-cloudimg-console.log roles/
exit 0
