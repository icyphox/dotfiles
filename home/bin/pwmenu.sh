#!/bin/sh

p="$(pw -l | dmenu)"
[[ "$p" == "" ]] && exit
pw -c "$p"
