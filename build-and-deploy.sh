#!/bin/bash

if [ $# -ne 1 ]; then
    echo "One parameter expected:"
    echo "- image name (jenkins|monitor|repo)"
    exit 1
fi

VAGRANT_CLOUD_USER=codeyourinfra
VAGRANT_CLOUD_BOX=$1
cd $VAGRANT_CLOUD_BOX

cleanup_and_exit()
{
	echo "Removing the $VAGRANT_CLOUD_BOX server"
    vagrant destroy -f

    echo "Cleaning up everything and exiting"
    rm -rf .vagrant ubuntu-*-cloudimg-console.log roles *-version.txt box-update-output.txt $BOX_FILE
    exit $1
}

BOX_VERSION=$(date '+%Y%m%d.0.0')
BOX_FILE=$VAGRANT_CLOUD_BOX-$BOX_VERSION.box

echo "Updating the vagrant box, if necessary"
vagrant box update | tee box-update-output.txt
BASE_BOX_VERSION=$(grep -o "'[a-zA-Z0-9]*/[a-zA-Z0-9]*' (v[0-9.]*)" -m 1 box-update-output.txt)

echo "Bootstrapping the $VAGRANT_CLOUD_BOX server"
vagrant up --no-provision

echo "Provisioning the server with the latest tools"
vagrant provision
if [ $? -ne 0 ]; then
    cleanup_and_exit 1
fi
UBUNTU_VERSION=$(cat ubuntu-version.txt)

echo "Baking the $VAGRANT_CLOUD_BOX server"
rm -f $BOX_FILE && vagrant package --output $BOX_FILE

# Requires VAGRANT_CLOUD_TOKEN
echo "Publish the new box version in Vagrant Cloud"
. ./set-version-description.sh
vagrant cloud publish $VAGRANT_CLOUD_USER/$VAGRANT_CLOUD_BOX $BOX_VERSION virtualbox $BOX_FILE --version-description "$VERSION_DESCRIPTION" --force --release

cleanup_and_exit 0