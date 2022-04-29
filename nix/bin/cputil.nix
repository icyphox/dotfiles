{ pkgs, ... }:

let
  name = "cputil";
  cpufreqctl = "${pkgs.auto-cpufreq}/bin/cpufreqctl.auto-cpufreq";
  asusctl = "${pkgs.asusctl}/bin/asusctl";
in
pkgs.writeShellScriptBin name
  ''
    mode="$1"
    case "$mode" in
      "perf")
        doas ${cpufreqctl} --governor --set=performance
        ${asusctl} profile -P performance
        printf "turning on cores... "
        for i in {8..15}; do
          printf "$i "
          doas ${cpufreqctl} --on --core=$i
        done
        printf "\n"
        ;;
      "save")
        doas ${cpufreqctl} --governor --set=powersave
        ${asusctl} profile -P quiet
        printf "turning off cores... "
        for i in {8..15}; do
          printf "$i "
          doas ${cpufreqctl} --off --core=$i
        done
        printf "\n"
    esac
  ''

