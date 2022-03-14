{ config
, pkgs
, theme
, ...
}:

with theme;
{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        font = "Input 10";
        allow_markup = "no";
        format = ''%s\n%b'';
        sort = "yes";
        indicate_hidden = "yes";
        alignment = "right";
        bounce_freq = "0";
        show_age_threshold = "60";
        word_wrap = "yes";
        ignore_newline = "no";
        geometry = "300x8-20+20";
        shrink = "yes";
        frame_width = 0;
        transparency = "0";
        idle_threshold = "120";
        monitor = "0";
        follow = "mouse";
        sticky_history = "yes";
        history_length = "20";
        icon_folders = "/usr/share/icons/gnome/16x16/status/:/usr/share/icons/gnome/16x16/devices/";
        show_indicators = "yes";
        line_height = "0";
        separator_height = "0";
        padding = "20";
        horizontal_padding = "20";
        separator_color = "auto";
        startup_notification = "false";
        stack_duplicates = "true";
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };

      urgency_normal = {
        background = base01;
        foreground = base05;
        timeout = 10;
      };

      urgency_low = {
        background = base01;
        foreground = base05;
        timeout = 2;
      };

      urgency_critical = {
        background = base01;
        foreground = base05;
        timeout = 0;
      };
    };
  };
}
