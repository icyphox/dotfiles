{ config
, pkgs
, self
, ...
}:

{

  imports = [
    ./firefox.nix
    ./common.nix
  ];

  programs = {
    gpg.enable = true;
  };
}
