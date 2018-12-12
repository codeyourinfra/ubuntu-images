# Codeyourinfra baked Ubuntu images

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

The [Codeyourinfra project](https://github.com/codeyourinfra/codeyourinfra) brings solutions for common sysadmin problems. The proposed solutions use Ubuntu images previously built. In this repository you'll find all the code developed for automatically building the Codeyourinfra [Vagrant boxes](https://www.vagrantup.com/docs/boxes.html) and the Codeyourinfra [AWS AMIs](https://docs.aws.amazon.com/AWSEC2/latest/UserGuide/AMIs.html).

During the building process, a temporary VM is initialized from a base image, and then provisioned by [Ansible](https://www.ansible.com). The same Ansible playbook is used to provision the VM initialized for building the Vagrant box and for building the AWS AMI.

## Vagrant boxes

The Codeyourinfra Vagrant boxes are available at Vagrant Cloud, in <https://app.vagrantup.com/codeyourinfra>. The currently used base Vagrant box is the latest [ubuntu/bionic64](https://app.vagrantup.com/ubuntu/boxes/bionic64). Run the following command to build and deploy the new custom Vagrant box to Vagrant Cloud:

`./build-and-deploy.sh <image_id>`

The *image_id* parameter can be set to **jenkins**, **monitor** or **repo**. In addition to that, the shell script requires the environment variable *VAGRANT_CLOUD_TOKEN*. To set it, you must have defined a [token in Vagrant Cloud](https://www.vagrantup.com/docs/vagrant-cloud/users/authentication.html#authentication-tokens). Last but not least, don't forget to install [Vagrant](https://www.vagrantup.com/downloads.html)!

## Amazon Web Services AMIs

The Codeyourinfra AWS AMIs are currently available in 2 regions: South America - São Paulo (**sa-east-1**) and Europe - London (**eu-west-2**). They can be found by using the [AWS CLI tool](https://aws.amazon.com/cli), executing the following command (replace the *region* parameter with the appropriate value):

```bash
aws ec2 describe-images --owners 334305766942 --region <region> \
--query 'Images[*].[Name,ImageId]' --output text
```

Their building processes are performed by [Packer](https://www.packer.io). During the process, Packer finds the latest available [Canonical](https://www.canonical.com) Ubuntu 18.04 LTS in the region *sa-east-1*, to be used as the base image. With the command below you can find it too:

```bash
aws ec2 describe-images --owners 099720109477 --region sa-east-1 \
--filters "Name=name,Values=ubuntu/images/hvm-ssd/ubuntu-bionic-18.04-amd64-server-*" \
--query 'Images[*].[ImageId,CreationDate]' --output text | sort -k2 -r | head -n1
```

Before building the images, get the right credentials, through the [AWS IAM](https://aws.amazon.com/iam). You must set the environment variables *AWS_ACCESS_KEY_ID* and *AWS_SECRET_ACCESS_KEY* in order to run, from the image folder:

`packer build aws-ami.json`
