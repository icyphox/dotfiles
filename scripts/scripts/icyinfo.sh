#!/bin/bash

# a system info script written by yours truly
# it's hardcoded stuff, lulz

red="\e[31m"
grn="\e[32m"
ylw="\e[33m"
cyn="\e[36m"
blu="\e[34m"
prp="\e[35m"
bprp="\e[35;1m"
rst="\e[0m"

echo

color-echo()
{  # print with colors
  echo -e " $cyn$1: $rst$2"
}

# kernel
color-echo 'kernel' "$(uname -smr)"

# uptime
up=$(</proc/uptime)
up=${up//.*}                # string before first . is seconds
days=$((${up}/86400))       # seconds divided by 86400 is days
hours=$((${up}/3600%24))    # seconds divided by 3600 mod 24 is hours
mins=$((${up}/60%60))       # seconds divided by 60 mod 60 is mins
color-echo "uptime" $days'd '$hours'h '$mins'm'

# shell
color-echo 'shell' 'zsh'

# wm
color-echo 'wm' 'i3'

# distro
color-echo 'distro' 'Arch Linux'

# ascii art
echo ""
echo "/\ /\ "
echo "\^ ^/  i c y p h o x "
echo " \_/   "
echo ""

# colors
echo -e "$red▓▓$rst $grn▓▓$rst $blu▓▓$rst $ylw▓▓$rst $cyn▓▓$rst $prp▓▓$rst $bprp▓▓$rst"

echo 
echo
