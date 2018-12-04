#!/bin/bash

# Requires VAGRANT_CLOUD_TOKEN
BOX_VERSION=$(date '+%Y%m%d.0.0')
BOX_FILE=jenkins-$BOX_VERSION.box

echo "Updating the vagrant box, if necessary"
vagrant box update | tee box-update-output.txt

echo "Bootstrapping the jenkins server"
vagrant up --no-provision

echo "Provisioning the server with the latest Oracle Java 8 and Jenkins"
vagrant provision

echo "Baking the jenkins server"
rm -f $BOX_FILE && vagrant package --output $BOX_FILE

echo "Creating the new box version in Vagrant Cloud"
BASE_BOX_VERSION=$(grep -o "'[a-zA-Z0-9]*/[a-zA-Z0-9]*' (v[0-9.]*)" -m 1 box-update-output.txt)
UBUNTU_VERSION=$(cat ubuntu-version.txt)
JAVA_VERSION=$(cat java-version.txt)
JENKINS_VERSION=$(cat jenkins-version.txt)
VERSION_DESCRIPTION="Built from $BASE_BOX_VERSION - $UBUNTU_VERSION - and provisioned with Oracle JDK $JAVA_VERSION and Jenkins $JENKINS_VERSION."
vagrant cloud version create -d "$VERSION_DESCRIPTION" codeyourinfra/jenkins $BOX_VERSION

echo "Removing the jenkins server"
vagrant destroy -f

echo "Cleaning up everything and exiting"
rm -rf .vagrant/ ubuntu-*-cloudimg-console.log roles/ *-version.txt box-update-output.txt
exit 0
