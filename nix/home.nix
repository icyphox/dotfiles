{ config
, pkgs
, theme
, self
, host
, ...
}:

{

  imports = [
    ./programs
    ./services
    ./x
    ./mail.nix
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
    xclip
    ripgrep
    arandr
    imagemagick
    ffmpeg
    wget
    tree
    mpv
    w3m
    noto-fonts-emoji
    jq
    yq-go
    sxiv
    feh
    st
    fzy
    xorg.xmodmap
    kubectl
    slack
    nixpkgs-fmt
    libnotify
    signal-desktop
    aerc
    calibre
    pinentry
    kontact
    kmail
    korganizer
    libreoffice-qt

  ] ++ (import ./bin { inherit pkgs theme host; });

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

