{ pkgs, lib, ... }:

let
  isDarwin = lib.strings.hasSuffix "darwin" pkgs.stdenv.hostPlatform.system;
  zedSettings = {
    telemetry = {
      diagnostics = false;
      metrics = false;
    };
    base_keymap = "VSCode";
    buffer_font_size = 15;
    theme = "Icy Light";
    buffer_font_family = if isDarwin then "SF Mono" else "Input";
    buffer_font_weight = 500;
    ui_font_family = if isDarwin then "System Font" else "Inter";
    ui_font_size = 18;
    vim_mode = true;
    vim = {
      use_system_clipboard = "never";
    };
    gutter = {
      line_numbers = false;
    };
    terminal = {
      working_directory = "current_project_directory";
      option_as_meta = true;
      env = {
        EDITOR = "zed --wait";
      };
      shell = {
        program = "fish";
      };
    };
    project_panel = {
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
    assistant = {
      default_model = {
        provider = "copilot_chat";
        model = "gpt-4";
      };
      version = "2";
      enabled = true;
      button = true;
    };
    scrollbar = {
      show = "auto";
    };
    toolbar = {
      breadcrumbs = true;
      quick_actions = true;
    };
    tab_bar = {
      show = false;
    };
  };

  zedSettingsFile = pkgs.writeText "settings.json" (builtins.toJSON zedSettings);
in
{
  home.file.".config/zed/settings.json".source = zedSettingsFile;
}
