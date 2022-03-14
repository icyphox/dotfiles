{ pkgs, theme, ... }:

let
  name = "bar";
  pamixer = "${pkgs.pamixer}/bin/pamixer";
  lemonbar = "${pkgs.lemonbar-xft}/bin/lemonbar";
in
pkgs.writeShellScriptBin name
  ''
    dt() {
        date +"%a, %d %b" | tr A-Z a-z
    }

    vol() {
        ${pamixer} --get-volume
    }

    pad="%{015}"

    while :; do
        time="$(date +"%H:%M")"
        echo "$pad $(dt) $pad $time %{r}bat $(bat) %{O14}vol $(vol)% $pad"
        sleep 0.5
    done | ${lemonbar} -n bar -f 'Input:style=Regular:size=12:antialias=true' -g x30 \
        -F '${theme.base00}' -B '${theme.base07}'
  ''
