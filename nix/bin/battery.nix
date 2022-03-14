{ pkgs, ... }:

let
  name = "bat";
in
pkgs.writeScriptBin name
  ''
    red="\e[31m"
    grn="\e[32m"
    ylw="\e[33m"
    cyn="\e[36m"
    blu="\e[34m"
    prp="\e[35m"
    bprp="\e[35;1m"
    rst="\e[0m"

    bat_status=""
    bat_status=$( cat /sys/class/power_supply/BAT0/capacity )
    charging_status=$( cat /sys/class/power_supply/BAT0/status )

    health() {
    for i in {0..4}
    do
        if [[ $i -le $(( $bat_status/20 )) ]]; then
            echo -ne "#[fg=colour1]· "
        else
            echo -ne "#[fg=colour8]· "
        fi
    done
    echo
    }

    bat_status_small() {
    if [[ "$charging_status" = *Charging* ]]; then
        echo -ne "+$bat_status%"
    else
        echo -ne "$bat_status%"
    fi
    }

    [ -z "$1" ] && {
    bat_status_small
    }

    while getopts qi options 
    do
    case $options in
        i)
            bat_status_small
            ;;
        q)
            if [[ "$charging_status" = *Charging* ]]; then
                echo -ne "+ $(health)"
            else
                health
            fi
    esac
    done
  ''
