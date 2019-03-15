#!/bin/bash

DOCKER_VERSION=$(cat docker-version.txt)
DOCKER_COMPOSE_VERSION=$(cat docker-compose-version.txt)
VERSION_DESCRIPTION="Built from $BASE_BOX_VERSION - $UBUNTU_VERSION - and provisioned with Docker $DOCKER_VERSION and Docker Compose $DOCKER_COMPOSE_VERSION."
