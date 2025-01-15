{ config
, pkgs
, lib
, ...
}:

{
  programs.ghostty = {
    enable = true;
    enableFishIntegration = true;
    settings = {
      term = "xterm-256color";
      font-family = "SF Mono";
      font-size = 12.0;
      window-padding-x = 10;
      window-padding-y = 10;
      window-padding-balance = true;
      window-theme = "ghostty";
      theme = "icy";
      adjust-cell-height = 10;
    };

    themes = {
      icy = {
        background = "f4f4f4";
        foreground = "676767";
        cursor-color = "676767"; # Fallback to foreground
        selection-background = "aaaaaa";
        selection-foreground = "525252";
        palette = [
          "0=f4f4f4" # Black (Normal)
          "1=db7070" # Red (Normal)
          "2=7c9f4b" # Green (Normal)
          "3=d69822" # Yellow (Normal)
          "4=6587bf" # Blue (Normal)
          "5=b870ce" # Magenta (Normal)
          "6=509c93" # Cyan (Normal)
          "7=676767" # White (Normal)
          "8=aaaaaa" # Black (Bright)
          "9=c66666" # Red (Bright)
          "10=6d8b42" # Green (Bright)
          "11=e7e7e7" # Yellow (Bright)
          "12=8a8a8a" # Blue (Bright)
          "13=a262b5" # Magenta (Bright)
          "14=43827b" # Cyan (Bright)
          "15=525252" # White (Bright)
        ];
      };
    };
  };
}
