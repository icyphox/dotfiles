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
  manual.manpages.enable = false;


  imports = [
    ../programs/common.nix
  ];

  programs.bash = {
    shellAliases = {
      ls = "ls --color=auto";
    };
  };

  home.packages = with pkgs; [
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

    go
    gopls
    gotools
  ] ++ (import ../bin { inherit pkgs host; });
}
