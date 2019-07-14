#!/usr/bin/env bash

if [ "$script_type" == "up" ]; then
  route add -host $remote_1/32 gw $route_net_gateway
  route add -net 0.0.0.0/1 gw $route_vpn_gateway
  route add -net 128.0.0.0/1 gw $route_vpn_gateway
  /etc/openvpn/update-resolv-conf
elif [ "$script_type" == "down" ]; then
  /etc/openvpn/update-resolv-conf
  route del -host $remote_1/32 gw $route_net_gateway
fi
