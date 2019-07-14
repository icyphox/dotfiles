#!/usr/bin/env bash

sudo cp /etc/resolv.conf /etc/resolv.conf.bk
sudo cp ~/dotfiles/resolv.conf /etc/resolv.conf
sudo openvpn --config ~/client.ovpn
sudo cp /etc/resolv.conf.bk /etc/resolv.conf
