#!/bin/bash

JAVA_VERSION=$(cat java-version.txt)
JENKINS_VERSION=$(cat jenkins-version.txt)
VERSION_DESCRIPTION="Built from $BASE_BOX_VERSION - $UBUNTU_VERSION - and provisioned with Oracle JDK $JAVA_VERSION and Jenkins $JENKINS_VERSION."
