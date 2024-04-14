{ config
, pkgs
, self
, ...
}:

{

  imports = [
    ./firefox.nix
    ./common.nix
    ./alacritty.nix
  ];

  programs = {
    gpg.enable = true;
  };
}
