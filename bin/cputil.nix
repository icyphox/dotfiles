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
        ;;
      "save")
        doas ${cpufreqctl} --governor --set=powersave
        ${asusctl} profile -P quiet
        printf "\n"
    esac
  ''

