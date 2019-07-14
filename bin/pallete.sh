#!/usr/bin/env bash
# author: daniel neemann
# so you can see yr colors

# color escapes
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

# build the color bars
BAR="███"
((LEN = ${#BAR} * 6))
OUTT="$RED$BAR$GRN$BAR$YLW$BAR$BLU$BAR$PUR$BAR$CYN$BAR$RST"

printf "\n"
printf "$OUTT\n"
printf "$OUTT\n"
printf "$OUTT\n"
printf "$OUTT\n"
printf "$OUTT\n"
printf "$OUTT\n"
printf "\n"
