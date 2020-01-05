#!/usr/bin/env bash

if [ "$1" = "freenode" ]; then
    proxychains4 irc -u icyphox -n icyphox/freenode
elif [ "$1" = "nixers" ]; then
    proxychains4 irc -u icy -n icyphox/nixers
elif [ "$1" = "rizon" ]; then
    proxychains4 irc -u icy -n icyphox/rizon
fi
