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

  fonts.fontconfig.enable = true;
  manual.manpages.enable = false;

  home.stateVersion = "23.11";
  home.username = "icy";
  home.homeDirectory = "/home/icy";
  home.extraOutputsToInstall = [ "man" ];
  home.packages = with pkgs; [

    git
    unzip
    curl
    tmux
    ripgrep
    imagemagick
    ffmpeg
    wget
    tree
    mpv
    noto-fonts-cjk
    noto-fonts-emoji
    jq
    yq-go
    fzy
    nixpkgs-fmt
    libnotify
    signal-desktop
    calibre
    pinentry
    kontact
    korganizer
    libreoffice-qt
    akonadi
    go
    evolution
    dconf
    chromium

  ] ++ (import ./bin { inherit pkgs host; });


  gtk = {
    enable = true;
    iconTheme = {
      package = pkgs.breeze-icons;
      name = "Breeze";
    };
    theme = {
      package = pkgs.breeze-gtk;
      name = "Breeze";
    };
  };

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

