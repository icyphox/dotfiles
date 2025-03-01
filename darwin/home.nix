{ config
, pkgs
, lib
, self
, host
, ...
}:

{
  home.stateVersion = "24.05";
  home.username = "icy";
  manual.manpages.enable = true;


  imports = [
    ../programs/common.nix
  ];

  programs.bash = {
    shellAliases = {
      ls = "ls --color=auto";
    };
  };

  home.file.".hammerspoon" = {
    source = ./hammerspoon;
    recursive = true;
  };

  home.packages = with pkgs; [
    # prompt
    tmux
    git
    fzy
    ripgrep
    pass
    fd
    gnupg
    colima
    docker
    docker-buildx
    pinentry_mac
    kubectl

    signal-desktop
    raycast

    go
    gopls
    gotools
    nix-your-shell
  ] ++ (import ../bin { inherit pkgs host; });
}
