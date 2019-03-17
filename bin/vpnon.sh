#!/usr/bin/env bash

sudo cp /etc/resolv.conf /etc/resolv.conf.bk
sudo cp ~/Dotfiles/resolv.conf /etc/resolv.conf
sudo openvpn --config ~/client.ovpn --script-security 2
sudo cp /etc/resolv.conf.bk /etc/resolv.conf
