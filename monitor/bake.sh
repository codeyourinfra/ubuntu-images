#!/bin/bash

echo "Updating the vagrant box, if necessary"
vagrant box update

echo "Bootstrapping the monitor server"
vagrant up --no-provision

echo "Provisioning the server with the latest InfluxDB, Grafana and Ansible"
vagrant provision

echo "Baking the monitor server"
vagrant package --output monitor.box

echo "Removing the monitor server"
vagrant destroy -f

echo "Cleaning up everything and exiting"
rm -rf .vagrant/ ubuntu-xenial-16.04-cloudimg-console.log roles/
exit 0
