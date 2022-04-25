{ config
, pkgs
, theme
, ...
}:

{
  services.sxhkd = {
    enable = true;
    keybindings = {
      "XF86Audio{Lower,Raise}Volume" = "${pkgs.pamixer}/bin/pamixer -{d,i} 2";
      "XF86AudioMute" = "${pkgs.pamixer}/bin/pamixer -t";
      "XF86MonBrightness{Down,Up}" = "${pkgs.brightnessctl}/bin/brightnessctl s 10{-,+}";
      "XF86KbdBrightness{Down,Up}" = "${pkgs.brightnessctl}/bin/brightnessctl --device='asus::kbd_backlight' s 1{-,+}";
      "XF86AudioMicMute" = "${pkgs.alsaUtils}/bin/amixer set Capture toggle";
      "super + Escape" = "pkill -USR1 -x sxhkd";
    };
  };
}
