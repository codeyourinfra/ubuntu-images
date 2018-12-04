#!/bin/bash

apt-get clean
rm -rf /var/lib/apt/lists/* /tmp/* /var/tmp/*

dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY

cat /dev/null > ~/.bash_history && history -c
