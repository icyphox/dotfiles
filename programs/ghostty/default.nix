{ config
, pkgs
, lib
, ...
}:

let
  config = import ./config.nix { inherit pkgs; };
  keyValue = pkgs.formats.keyValue {
    listsAsDuplicateKeys = true;
    mkKeyValue = lib.generators.mkKeyValueDefault { } " = ";
  };

  isLinux = pkgs.stdenv.isLinux;
  isDarwin = pkgs.stdenv.isDarwin;
in
{
  programs.ghostty = lib.mkIf isLinux {
    enable = true;
    enableFishIntegration = true;
    settings = config.settings;
    themes = config.themes;
  };

  home.file = lib.mkIf isDarwin {
    ".config/ghostty/config".source =
      keyValue.generate "ghostty-config" config.settings;
    ".config/ghostty/themes/icy_light".source =
      keyValue.generate "ghostty-icy_light-theme" config.themes.icy_light;
    ".config/ghostty/themes/icy_dusk".source =
      keyValue.generate "ghostty-icy_dusk-theme" config.themes.icy_dusk;
  };
}
