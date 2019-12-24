#!/usr/bin/env bash

pass="$(pw -l | dmenu)"
if [[ -z "$pass" ]]; then
    exit
else
    pw -c "$pass"
fi
