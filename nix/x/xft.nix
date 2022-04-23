{ config
, pkgs
, ...
}:

{
  xresources.properties = {
    "Xft.autohint" = 1;
    "Xft.antialias" = 1;
    "Xft.lcdfilter" = "lcddefault";
    "Xft.hintstyle" = "hintslight";
    "Xft.hinting" = true;
    "Xft.rgba" = "rgb";
    "Xft.dpi" = 192;
  };
}
