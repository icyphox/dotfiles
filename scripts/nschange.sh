#!/bin/bash

# create a SOCKS proxy 
ssh -D 8008 boop

# change nameservers
sudo echo nameserver 8.8.8.8 > /etc/resolv.conf

# write-lock the file (even root can't edit it)
sudo chattr +i /etc/resolv.conf

# kill dhcpcd (messes with IP)
sudo systemctl stop dhcpcd.sevice

# start VPN
sudo openvpn --config ~/icy.ovpn
