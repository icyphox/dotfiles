{ config
, pkgs
, theme
, ...
}:

{
  imports = [
    ./xft.nix
    ./xresources.nix
  ];
}
