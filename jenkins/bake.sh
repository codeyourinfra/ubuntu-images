#!/bin/bash

echo "Updating the vagrant box, if necessary"
vagrant box update

echo "Bootstrapping the jenkins server"
vagrant up --no-provision

echo "Provisioning the server with the latest Oracle Java 8 and Jenkins"
vagrant provision

echo "Baking the jenkins server"
vagrant package --output jenkins-$(date '+%Y%m%d.0.0').box

echo "Removing the jenkins server"
vagrant destroy -f

echo "Cleaning up everything and exiting"
rm -rf .vagrant/ ubuntu-*-cloudimg-console.log roles/
exit 0
