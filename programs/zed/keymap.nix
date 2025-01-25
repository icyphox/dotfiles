{ pkgs, ... }:

let
  keymap = [
    {
      context = "Dock || Terminal || Editor";
      bindings = {
        "alt-y" = [ "workspace::ActivatePaneInDirection" "Left" ];
        "alt-o" = [ "workspace::ActivatePaneInDirection" "Right" ];
        "alt-e" = [ "workspace::ActivatePaneInDirection" "Up" ];
        "alt-n" = [ "workspace::ActivatePaneInDirection" "Down" ];
      };
    }
    {
      context = "VimControl && !VimWaiting && !menu";
      bindings = {
        "space o" = "tab_switcher::Toggle";
        "space t" = "workspace::NewCenterTerminal";
        "space n" = "pane::ActivateNextItem";
        "space p" = "pane::ActivatePrevItem";
        "space e" = "file_finder::Toggle";
        "space shift-e" = "workspace::NewSearch";
        "space ?" = "workspace::ToggleRightDock";
        "space shift-f" = "workspace::ToggleLeftDock";
      };
    }
    {
      context = "Workspace";
      bindings = {
        "ctrl-q c" = "pane::SplitRight";
        "ctrl-q \"" = "pane::SplitDown";
      };
    }
  ];

  keymapFile = pkgs.writeText "keymap.json" (builtins.toJSON keymap);
in
{
  home.file.".config/zed/keymap.json".source = keymapFile;
}
