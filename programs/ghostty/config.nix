{ pkgs, ... }:
{
  settings = {
    term = "xterm-256color";
    font-family = "SF Mono";
    font-size = 12.0;
    window-padding-x = 10;
    window-padding-y = 10;
    window-padding-balance = true;
    window-theme = "ghostty";
    theme = "light:icy_light,dark:icy_dusk";
    adjust-cell-height = 10;
    macos-option-as-alt = "left";
  };

  themes = {
    icy_dusk = {
      background = "100f0f";
      foreground = "fff6e3";
      cursor-color = "509c93";
      selection-background = "509c93";
      selection-foreground = "fff6e3";
      palette = [
        "0=2a261f" # Black (Normal)
        "1=db7070" # Red (Normal)
        "2=7c9f4b" # Green (Normal)
        "3=d69822" # Yellow (Normal)
        "4=509c93" # Blue (Normal)
        "5=b870ce" # Magenta (Normal)
        "6=509c93" # Cyan (Normal)
        "7=fff6e3" # White (Normal)
        "8=4a443d" # Black (Bright)
        "9=c66666" # Red (Bright)
        "10=6d8b42" # Green (Bright)
        "11=4a443d" # Yellow (Bright)
        "12=6b635a" # Blue (Bright)
        "13=a262b5" # Magenta (Bright)
        "14=43827b" # Cyan (Bright)
        "15=fff9eb" # White (Bright)
      ];
    };

    icy_light = {
      background = "fffdf5";
      foreground = "4a443d";
      cursor-color = "509c93";
      selection-background = "fceccc";
      selection-foreground = "4a443d";
      palette = [
        "0=4a443d" # Black (Normal)
        "1=db7070" # Red (Normal)
        "2=7c9f4b" # Green (Normal)
        "3=d69822" # Yellow (Normal)
        "4=6587bf" # Blue (Normal)
        "5=b870ce" # Magenta (Normal)
        "6=509c93" # Cyan (Normal)
        "7=fffdf5" # White (Normal)
        "8=776e63" # Black (Bright)
        "9=c66666" # Red (Bright)
        "10=6d8b42" # Green (Bright)
        "11=d8cbbe" # Yellow (Bright)
        "12=6587bf" # Blue (Bright)
        "13=a262b5" # Magenta (Bright)
        "14=43827b" # Cyan (Bright)
        "15=2a261f" # White (Bright)
      ];
    };
  };
}
