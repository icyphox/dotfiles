{ config
, pkgs
, ...
}:

{
  programs.readline = {
    enable = true;
    bindings = {
      "\\t" = "menu-complete";
      "\\e[Z" = "menu-complete-backward";
      "\\C-w" = "backward-kill-word";
    };
    variables = {
      "completion-ignore-case" = "on";
      "show-all-if-ambiguous" = "on";
      "colored-stats" = "on";
      "completion-display-width" = 4;
      "enable-bracketed-paste" = "on";
    };
  };
}
