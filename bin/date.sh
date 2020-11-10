#!/usr/bin/env bash

date="$(date +"%a, %d %b" | tr A-Z a-z)"

printf "%s " "$date"

