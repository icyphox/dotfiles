{ config
, pkgs
, lib
, self
, host
, ...
}:

{
  home.stateVersion = "22.11";
  home.username = "icy";


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
    docker
    pinentry_mac
    kubectl
  ] ++ (import ../bin { inherit pkgs host; });
}
