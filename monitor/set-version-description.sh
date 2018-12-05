#!/bin/bash

GRAFANA_VERSION=$(cat grafana-version.txt)
INFLUXDB_VERSION=$(cat influxdb-version.txt)
ANSIBLE_VERSION=$(cat ansible-version.txt)
VERSION_DESCRIPTION="Built from $BASE_BOX_VERSION - $UBUNTU_VERSION - and provisioned with InfluxDB $INFLUXDB_VERSION, Grafana $GRAFANA_VERSION and Ansible $ANSIBLE_VERSION."
