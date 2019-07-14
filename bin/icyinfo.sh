#!/usr/bin/env bash
# icyinfo, but better

BLK="\e[30m"
RED="\e[31m"
GRN="\e[32m"
YLW="\e[33m"
BLU="\e[34m"
PUR="\e[35m"
CYN="\e[36m"
BRED="\e[31m"
BGRN="\e[32m"
BYLW="\e[33m"
BBLU="\e[34m"
BPUR="\e[35m"
BCYN="\e[36m"
WHT="\e[37m"
RST="\e[0m"

BAR="▁▁▁▁"
COLOR_BARS="$RED$BAR$GRN$BAR$YLW$BAR$BLU$BAR$PUR$BAR$CYN$BAR$RST"

user=$(whoami)
host=$(hostname)
kernel=$(uname -r)
uptime=$(uptime -p)    # too long to print
shell=$(basename $SHELL)

os() {
	os=$(source /etc/os-release && echo $ID)
	export os
}

wm() {
	id=$(xprop -root -notype _NET_SUPPORTING_WM_CHECK)
	id=${id##* }
	wm=$(xprop -id "$id" -notype -len 100 -f _NET_WM_NAME 8t)
	wm=${wm/*_NET_WM_NAME = }
	wm=${wm/\"}
	wm=${wm/\"*}
	wm=${wm,,}
	export wm
}


os
wm

clear
printf "$COLOR_BARS\n\n"
printf "${CYN}$user${RST}@${CYN}$host${RST}     ${CYN}   |\___/|${RST}\n"
printf "                ${CYN}/     \\ ${RST} \n"
printf "               ${CYN}/__${RST}${PUR}^ ^${RST}${CYN}__\\ ${RST} \n"
printf "                  ${CYN}\o/    ${RST}\n\n"
printf "os:               ${CYN}$os${RST}\n"
printf "kernel:   ${CYN}$kernel${RST}\n"
# printf "uptime:    ${CYN}$uptime${RST}\n"
printf "wm:                   ${CYN}$wm${RST}\n"
printf "shell:               ${CYN}$shell${RST}\n"
printf "$COLOR_BARS\n"
