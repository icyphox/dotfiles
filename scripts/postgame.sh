#!/bin/bash

# remove write-lock
chattr -i /etc/resolv.conf

# start dhcpcd
systemctl start dhcpcd

# restart NetworkManager for re-resolving IP
systemctl restart NetworkManager


