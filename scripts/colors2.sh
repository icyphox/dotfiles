#!/bin/bash

useage() {
  printf "\n\e[1;4mAscii Escape Code Helper Utility\e[m\n\n"
  printf "  \e[1mUseage:\e[m colors.sh [-|-b|-f|-bq|-fq|-?|?] [start] [end] [step]\n\n"
  printf "The values for the first parameter may be one of the following:\n\n"
  printf "  \e[1m-\e[m  Will result in the default output.\n"
  printf "  \e[1m-b\e[m This will display the 8 color version of this chart.\n"
  printf "  \e[1m-f\e[m This will display the 256 color version of this chart using foreground colors.\n"
  printf "  \e[1m-q\e[m This will display the 256 color version of this chart without the extra text.\n"
  printf "  \e[1m-bq\e[m    This will display the 8 color version of this chart without the extra text.\n"
  printf "  \e[1m-fq\e[m    This will display the 256 color version of this chart using foreground colors without the extra text.\n"
  printf "  \e[1m-?|?\e[m   Displays this help screen.\n"
  printf "\nThe remaining parameters are only used if the first parameter is one of: \e[1m-,-f,q,fq\e[m\n\n"
  printf "  \e[1mstart\e[m  The color index to begin display at.\n"
  printf "  \e[1mend\e[m    The color index to stop display at.\n"
  printf "  \e[1mstart\e[m  The number of indexes to increment color by each iteration.\n\n\n"

}
verbose() {
  if [[ "$1" != "-q" && "$1" != "-fq" && "$1" != "-bq" ]]; then
    printf "\nTo control the display style use \e[1m%s\e[m where \e[1m%s\e[m is:\n" '\e[{$value}[:{$value}]m' '{$value}'
    printf "\n  0 Normal \e[1m1 Bold\e[m \e[2m2 Dim\e[m \e[3m3 ???\e[m \e[4m4 Underlined\e[m \e[5m5 Blink\e[m \e[6m6 ???\e[m \e[7m7 Inverted\e[m \e[8m8 Hidden\e[m\n\n"
    printf "If \e[1m%s\e[m is not provided it will reset the display.\n\n" '{$value}'
  fi
}
eight_color() {
    local fgc bgc vals seq0
    if [ "$1" != "-bq" ]; then
        printf "\n\e[1;4m8 Color Escape Value Pallette\e[m\n\n"
        printf "Color escapes are \e[1m%s\e[m\n" '\e[${value};...;${value}m'
        printf "    Values \e[1m30..37\e[m are \e[1mforeground\e[m colors\n"
        printf "    Values \e[1m40..47\e[m are \e[1mbackground\e[m colors\n\n"  
    fi
    for fgc in {30..37}; do
        for bgc in {40..47}; do
            fgc=${fgc#37}
            bgc=${bgc#40}
            vals="${fgc:+$fgc;}${bgc}"
            vals=${vals%%;}
            seq0="${vals:+\e[${vals}m}"
            printf "  %-9s" "${seq0:-(default)}"
            printf " ${seq0}TEXT\e[m"
            printf " \e[${vals:+${vals+$vals;}}1mBOLD\e[m"
        done
        printf "\e[0m\n"
    done
}


if [[ "$1" == "-b" ||  "$1" == "-bq" ]]; then
  eight_color "$1"
  verbose "$1"
elif [[ "$1" == "" || "$1" == "-" ||  "$1" == "-f" ||  "$1" == "-q" ||  "$1" == "-fq" ]]; then
  start=${2:-0}
  end=${3:-255}
  step=${4:-1}
  color=$start
  style="48;5;"
  if [[ "$1" == "-f" || "$1" == "-fq" ]]; then
   style="38;5;"
  fi
  perLine=$(( ( $(tput cols) - 2 ) / 9 ));
  if [[ "$1" != "-q" && "$1" != "-fq" ]]; then
    printf "\n\e[1;4m256 Color Escape Value Pallette\e[0m\n\n"
    printf "    \e[1m%s\e[m for \e[1mbackground\e[m colors\n    \e[1m%s\e[m for \e[1mforeground\e[m colors\n\n" '\e[48;5;${value}m' '\e[38;5;${value}m'
  fi
  while [ $color -le $end ]; do
    printf "\e[m \e[${style}${color}m  %3d  \e[m " $color
    ((color+=step))
    if [ $(( ( ( $color - $start ) / $step ) % $perLine )) -eq 0 ]; then
      printf "\n"
    fi
    done
    printf "\e[m\n"
    verbose "$1"
else
  useage
fi
