{ config
, pkgs
, lib
, self
, host
, ...
}:

{
  home.stateVersion = "22.05";
  home.username = "icy";

  imports = [
    ../programs/common.nix
  ];

  home.packages = with pkgs; [
    tmux
    git
    fzy
    ripgrep
    pass
    fd
  ];
}
