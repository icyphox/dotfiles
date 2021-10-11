#!/usr/bin/env bash

stripnl() {
    printf '%s' "${1##"\n"}"
}

check_playing() {
    status="$(cmus-remote -Q | grep status | cut -d ' ' -f 2)"
    [[ "$status" == "paused" ]] && exit
}

check_playing
mapfile np < <(cmus-remote -Q | grep tag | head -n3 | sort -r | cut -d ' ' -f 3-)
track="$(stripnl "${np[0]}")"
artist="$(stripnl "${np[1]}")"

case "$1" in
    "-a")
        printf '%s' "$artist"
        ;;
    "-t")
        printf '%s' "$track"
        ;;
    *)
        printf '%s - %s\n' "$artist" "$track" 
esac
