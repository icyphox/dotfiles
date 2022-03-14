{ config
, pkgs
, ...
}:

{
  services.picom = {
    enable = true;
    backend = "glx";
    fade = true;
    fadeDelta = 5;
    fadeSteps = [ "0.04" "0.04" ];
    inactiveDim = "0.0";
    shadow = false;
    shadowOffsets = [ (-60) (-60) ];
    shadowOpacity = "0.20";
  };
}
