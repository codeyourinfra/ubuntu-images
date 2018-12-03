#!/bin/bash

BOX_VERSION=$(date '+%Y%m%d.0.0')
BOX_FILE=jenkins-$BOX_VERSION.box

echo "Updating the vagrant box, if necessary"
vagrant box update

echo "Bootstrapping the jenkins server"
vagrant up --no-provision

echo "Provisioning the server with the latest Oracle Java 8 and Jenkins"
vagrant provision

echo "Baking the jenkins server"
rm -f $BOX_FILE && vagrant package --output $BOX_FILE

echo "Creating the new box version in Vagrant Cloud"
UBUNTU_VERSION=$(cat ubuntu-version.txt)
JAVA_VERSION=$(cat java-version.txt)
JNEKINS_VERSION=$(cat jenkins-version.txt)
VERSION_DESCRIPTION="Built from $UBUNTU_VERSION and provisioned with Oracle JDK $JAVA_VERSION and Jenkins $JENKINS_VERSION."
vagrant cloud version create codeyourinfra/jenkins $BOX_VERSION --description $VERSION_DESCRIPTION

echo "Removing the jenkins server"
vagrant destroy -f

echo "Cleaning up everything and exiting"
rm -rf .vagrant/ ubuntu-*-cloudimg-console.log roles/ *-version.txt
exit 0
