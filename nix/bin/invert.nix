{ pkgs, ... }:

let
  xrandr = "${pkgs.xorg.xrandr}/bin/xrandr";
  xinput = "${pkgs.xorg.xinput}/bin/xinput";
in
pkgs.writeShellScriptBin "invert"
  ''
    orientation="$(${xrandr} --query --verbose | grep eDP | cut -d ' ' -f 6)"
    if [[ "$orientation" == "normal" ]];
    then
      echo "turning screen upside down..."
      ${xrandr} -o inverted
      ${xinput} set-prop 'ELAN9008:00 04F3:2C82' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
      ${xinput} set-prop 'ELAN9008:00 04F3:2C82 Stylus Pen (0)' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
      ${xinput} set-prop 'ELAN9008:00 04F3:2C82 Stylus Eraser (0)' 'Coordinate Transformation Matrix' -1 0 1 0 -1 1 0 0 1
    else
      echo "reverting back to normal..."
      ${xrandr} -o normal
      ${xinput} set-prop 'ELAN9008:00 04F3:2C82' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
      ${xinput} set-prop 'ELAN9008:00 04F3:2C82 Stylus Pen (0)' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
      ${xinput} set-prop 'ELAN9008:00 04F3:2C82 Stylus Eraser (0)' 'Coordinate Transformation Matrix' 1 0 0 0 1 0 0 0 1
    fi
  ''
