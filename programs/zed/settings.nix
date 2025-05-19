{ pkgs, lib, ... }:

let
  isDarwin = lib.strings.hasSuffix "darwin" pkgs.stdenv.hostPlatform.system;
  zedSettings = {
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    features = {
      edit_prediction_provider = "zed";
    };
    edit_predictions = {
      mode = "subtle";
    };
    active_pane_modifiers = {
      inactive_opacity = 0.8;
      magnification = 1.5;
    };
    base_keymap = "VSCode";
    buffer_font_size = 15;
    theme = {
      mode = "system";
      light = "Icy Light";
      dark = "Icy Dark";
    };
    show_completions_on_input = true;
    buffer_font_family = "SF Mono";
    buffer_font_weight = 500;
    ui_font_family = if isDarwin then "System Font" else "Inter";
    ui_font_size = 18;
    vim_mode = true;
    vim = {
      use_system_clipboard = "never";
    };
    gutter = {
      line_numbers = false;
      runnables = false;
      folds = false;
    };
    terminal = {
      button = false;
      working_directory = "current_project_directory";
      option_as_meta = true;
      env = {
        EDITOR = if isDarwin then "zed --wait" else "zeditor --wait";
      };
      shell = {
        program = "fish";
      };
    };
    outline_panel = {
      button = false;
    };
    project_panel = {
      button = false;
      file_icons = false;
      folder_icons = false;
      indent_size = 10;
    };
    chat_panel = {
      button = false;
    };
    collaboration_panel = {
      button = false;
    };
    notification_panel = {
      button = false;
    };
    assistant = {
      default_model = {
        provider = "zed.dev";
        model = "claude-3-7-sonnet-latest";
      };
      version = "2";
      enabled = true;
      button = false;
    };
    scrollbar = {
      show = "never";
    };
    toolbar = {
      breadcrumbs = true;
      quick_actions = false;
      selections_menu = false;
    };
    tab_bar = {
      show = false;
    };
    preview_tabs = {
      enable = false;
    };
  };

  zedSettingsFile = pkgs.writeText "settings.json" (builtins.toJSON zedSettings);
in
{
  home.file.".config/zed/settings.json".source = zedSettingsFile;
}
