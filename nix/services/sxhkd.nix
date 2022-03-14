{ config
, pkgs
, theme
, ...
}:

{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "XF86Audio{Lower,Raise}Volume" = "${pkgs.alsaUtils}/bin/amixer sset Master 2%{-,+}";
      "XF86AudioMute" = "${pkgs.alsaUtils}/bin/amixer sset Master toggle";
      "XF86MonBrightness{Down,Up}" = "${pkgs.light}/bin/light -{U,A} 50";
      "super + Escape" = "pkill -USR1 -x sxhkd";
    };
  };
}
