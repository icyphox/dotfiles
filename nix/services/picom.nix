{ config
, pkgs
, ...
}:

{
  services.picom = {
    enable = true;
    backend = "glx";
    vSync = true;
    inactiveDim = "0.0";
    shadow = false;
    shadowOffsets = [ (-60) (-60) ];
    shadowOpacity = "0.20";
  };
}
