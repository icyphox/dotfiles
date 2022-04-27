{ pkgs, theme, host, ... }:

let
  name = "bar";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  lemonbar = "${pkgs.lemonbar-xft}/bin/lemonbar";
  cpufreq = "${pkgs.cpufrequtils}/bin/cpufreq-info";
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

    freq() {
      printf '%sGHz' $(${cpufreq} -fm | cut -d' ' -f1)
    }

    temp() {
      printf '%sC' $(( $(cat /sys/class/thermal/thermal_zone0/temp) / 1000 ))
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
        echo "$pad $(dt) $pad $time %{r}temp $(temp) $pad cpu $(freq) $pad bat $(bat) $pad $(audio_dev) $(vol)% $pad"
        sleep 0.5
    done | ${lemonbar} -n bar -f 'Input:style=Regular:size=12:antialias=true' -g x${barHeight} \
        -F '${theme.base00}' -B '${theme.base07}'
  ''
