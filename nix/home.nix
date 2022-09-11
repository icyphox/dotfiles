{ config
, pkgs
, self
, host
, ...
}:

{

  imports = [
    ./programs
    ./services
  ];

  home.stateVersion = "22.05";
  home.username = "icy";
  home.homeDirectory = "/home/icy";
  home.extraOutputsToInstall = [ "man" ];
  home.packages = with pkgs; [

    git
    unzip
    curl
    tmux
    weechat
    ripgrep
    imagemagick
    ffmpeg
    wget
    tree
    mpv
    noto-fonts-emoji
    jq
    yq-go
    fzy
    kubectl
    slack
    nixpkgs-fmt
    libnotify
    signal-desktop
    calibre
    pinentry
    kontact
    trojita
    korganizer
    libreoffice-qt

  ] ++ (import ./bin { inherit pkgs host; });

  xdg = {
    userDirs = {
      enable = true;
      desktop = "\$HOME/desktop";
      documents = "\$HOME/docs";
      download = "\$HOME/downloads";
      pictures = "\$HOME/pics";
      videos = "\$HOME/vids";
    };
  };
}

