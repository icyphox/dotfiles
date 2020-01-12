#!/usr/bin/env bash

sudo wpa_supplicant -i wlp2s0 -B -c /etc/wpa_supplicant.conf
sudo wpa_cli -i wlp2s0 select_network 1
sudo dhcpcd wlp2s0
