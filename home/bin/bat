#!/usr/bin/env bash

if [[ "$(uname)" == "Darwin" ]]; then
    cap="$(pmset -g batt | grep -Eo "\d+%" | cut -d% -f1)"
    is_charging=""
else
    cap="$(apm -l)"
    is_charging="$(apm -a)"

    status="discharging"
fi

tmux_bat() {
    if [[ "$is_charging" -eq 1 ]]; then 
        printf '%s%%' "+$cap"
    else
        printf '%s%%' "$cap"
    fi
}

if [[ "$1" == "-q" ]]; then
   tmux_bat 
else
    [[ "$is_charging" -eq 1 ]] &&
        status="charging"
    printf '%s%% [%s]\n' $cap $status 
fi
