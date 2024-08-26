{ config, pkgs, ... }:

let
  settings = import ./settings.nix;
  keymap = import ./keymap.nix;
in
{
  home.file.".config/zed/themes/icy.json".source = ./themes/icy.json;
  imports = [ settings keymap ];
}
