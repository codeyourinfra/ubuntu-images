#!/bin/bash

# Requires VAGRANT_CLOUD_TOKEN
BOX_VERSION=$(date '+%Y%m%d.0.0')
BOX_FILE=repo-$BOX_VERSION.box

echo "Updating the vagrant box, if necessary"
vagrant box update | tee box-update-output.txt

echo "Bootstrapping the repo server"
vagrant up --no-provision

echo "Provisioning the server with the latest Apache 2"
vagrant provision

echo "Baking the repo server"
rm -f $BOX_FILE && vagrant package --output $BOX_FILE

echo "Publish the new box version in Vagrant Cloud"
BASE_BOX_VERSION=$(grep -o "'[a-zA-Z0-9]*/[a-zA-Z0-9]*' (v[0-9.]*)" -m 1 box-update-output.txt)
UBUNTU_VERSION=$(cat ubuntu-version.txt)
APACHE2_VERSION=$(cat apache2-version.txt)
VERSION_DESCRIPTION="Built from $BASE_BOX_VERSION - $UBUNTU_VERSION - and provisioned with Apache HTTP Server $APACHE2_VERSION."
vagrant cloud publish codeyourinfra/repo $BOX_VERSION virtualbox $BOX_FILE --version-description "$VERSION_DESCRIPTION" --force --release

echo "Removing the repo server"
vagrant destroy -f

echo "Cleaning up everything and exiting"
rm -rf .vagrant ubuntu-*-cloudimg-console.log roles *-version.txt box-update-output.txt repo-*.box
exit 0
