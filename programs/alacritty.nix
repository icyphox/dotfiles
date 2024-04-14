{ config
, pkgs
, ...
}:

{
  programs.alacritty = {
    enable = true;
    settings = {
      env = {
        "TERM" = "xterm-256color-italic";
      };

      window = {
        padding.x = 10;
        padding.y = 10;
        dynamic_padding = true;
        decorations = "None";
        startup_mode = "Maximized";
      };

      font = {
        size = 12.0;

        normal.family = "Input";
      };

      cursor.style = "Beam";

      colors = {
        primary = {
          background = "0xf4f4f4";
          foreground = "0x676767";
        };
        normal = {
          black = "0xf4f4f4";
          red = "0xdb7070";
          green = "0x7c9f4b";
          yellow = "0xd69822";
          blue = "0x6587bf";
          magenta = "0xb870ce";
          cyan = "0x509c93";
          white = "0x676767";
        };
        bright = {
          black = "0xaaaaaa";
          red = "0xc66666";
          green = "0x6d8b42";
          yellow = "0xe7e7e7";
          blue = "0x8a8a8a";
          magenta = "0xa262b5";
          cyan = "0x43827b";
          white = "0x525252";
        };
      };

    };
  };
}
