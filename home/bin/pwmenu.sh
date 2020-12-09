#!/bin/sh

p="$(pw -l | xprompt pw)"
[[ "$p" == "" ]] && exit
pw -c "$p"
