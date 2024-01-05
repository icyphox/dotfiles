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
    mbsync.enable = true;
    gpg.enable = true;
  };
}
