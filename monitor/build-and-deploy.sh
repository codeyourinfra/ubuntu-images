#!/bin/bash

# Requires VAGRANT_CLOUD_TOKEN
BOX_VERSION=$(date '+%Y%m%d.0.0')
BOX_FILE=monitor-$BOX_VERSION.box

echo "Updating the vagrant box, if necessary"
vagrant box update | tee box-update-output.txt

echo "Bootstrapping the monitor server"
vagrant up --no-provision

echo "Provisioning the server with the latest InfluxDB, Grafana and Ansible"
vagrant provision

echo "Baking the monitor server"
rm -f $BOX_FILE && vagrant package --output $BOX_FILE

echo "Publish the new box version in Vagrant Cloud"
BASE_BOX_VERSION=$(grep -o "'[a-zA-Z0-9]*/[a-zA-Z0-9]*' (v[0-9.]*)" -m 1 box-update-output.txt)
UBUNTU_VERSION=$(cat ubuntu-version.txt)
GRAFANA_VERSION=$(cat grafana-version.txt)
INFLUXDB_VERSION=$(cat influxdb-version.txt)
ANSIBLE_VERSION=$(cat ansible-version.txt)
VERSION_DESCRIPTION="Built from $BASE_BOX_VERSION - $UBUNTU_VERSION - and provisioned with InfluxDB $INFLUXDB_VERSION, Grafana $GRAFANA_VERSION and Ansible $ANSIBLE_VERSION."
vagrant cloud publish codeyourinfra/monitor $BOX_VERSION virtualbox $BOX_FILE --version-description "$VERSION_DESCRIPTION" --force --release

echo "Removing the monitor server"
vagrant destroy -f

echo "Cleaning up everything and exiting"
rm -rf .vagrant ubuntu-*-cloudimg-console.log roles *-version.txt box-update-output.txt monitor-*.box
exit 0
