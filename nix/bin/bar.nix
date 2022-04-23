{ pkgs, theme, host, ... }:

let
  name = "bar";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  lemonbar = "${pkgs.lemonbar-xft}/bin/lemonbar";
  btctl = "${pkgs.bluezFull}/bin/bluetoothctl";
  barHeight = if host == "wyndle" then "50" else "30";
in
pkgs.writeShellScriptBin name
  ''
    dt() {
        date +"%a, %d %b" | tr A-Z a-z
    }

    vol() {
        ${pamixer} --get-volume
    }

    audio_dev() {
      con="$(${btctl} info | grep Connected | awk '{ print $2 }')"

      if [[ "$con" == "yes" ]]; then
        printf 'bt'
      else
        printf 'spkr'
      fi
    }

    pad="%{015}"

    while :; do
        time="$(date +"%H:%M")"
        echo "$pad $(dt) $pad $time %{r}bat $(bat) %{O14}$(audio_dev) $(vol)% $pad"
        sleep 0.5
    done | ${lemonbar} -n bar -f 'Input:style=Regular:size=12:antialias=true' -g x${barHeight} \
        -F '${theme.base00}' -B '${theme.base07}'
  ''
