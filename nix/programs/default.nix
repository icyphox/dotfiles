{ config
, pkgs
, self
, ...
}:

{

  imports = [
    ./chromium.nix
    ./firefox.nix
    ./common.nix
  ];

  programs = {
    mbsync.enable = true;
    gpg.enable = true;
  };
}
