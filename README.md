# Codeyourinfra baked Ubuntu images

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

The [Codeyourinfra project](https://github.com/codeyourinfra/codeyourinfra) brings solutions for common sysadmin problems. The proposed solutions use Ubuntu images previously built. In this repository you'll find all the code developed for automaticaly building the Codeyourinfra [Vagrant boxes](https://www.vagrantup.com/docs/boxes.html) and the Codeyourinfra [AWS AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html).

During the building process, a temporary VM is initialized from a base image, and then provisioned by [Ansible](https://www.ansible.com). The same Ansible playbook is used to provision the VM initialized for building the Vagrant box and for building the AWS AMI.

## Vagrant boxes

The Codeyourinfra Vagrant boxes are available at Vagrant Cloud, in <https://app.vagrantup.com/codeyourinfra>. The currently used base Vagrant box is the latest [ubuntu/bionic64](https://app.vagrantup.com/ubuntu/boxes/bionic64). Run the following command to build and deploy the new custom Vagrant box to Vagrant Cloud:

`./build-and-deploy.sh <image_id>`

The *image_id* parameter can be set to **jenkins**, **monitor** or **repo**. In addition to that, the shell script requires the environment variable *VAGRANT_CLOUD_TOKEN*. To set it, you must have defined a [token in Vagrant Cloud](https://www.vagrantup.com/docs/vagrant-cloud/users/authentication.html#authentication-tokens).

## Amazon Web Services AMIs

