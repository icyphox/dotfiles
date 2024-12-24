{ config, pkgs, ... }:

let
  settings = import ./settings.nix;
  keymap = import ./keymap.nix;
in
{
  home.file.".config/zed/themes/icy.json".source = ./themes/icy.json;
  home.file.".config/zed/themes/icy-dusk.json".source = ./themes/icy-dusk.json;
  imports = [ settings keymap ];
}
