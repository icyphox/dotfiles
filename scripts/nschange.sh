#!/bin/bash

# run as root

echo nameserver 8.8.8.8 > /etc/resolv.conf
chattr +i /etc/resolv.conf
