{ config
, pkgs
, theme
, self
, ...
}:

{

  imports = [
    ./programs
    ./services
    ./x
  ];

  home.stateVersion = "21.05";
  home.username = "icy";
  home.homeDirectory = "/home/icy";
  home.extraOutputsToInstall = [ "man" ];
  home.packages = with pkgs; [

    git
    unzip
    curl
    tmux
    weechat
    firefox
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
    yq
    sxiv
    st
    fzy
    xorg.xmodmap
    kubectl
    slack
    nixpkgs-fmt
    libnotify
    signal-desktop

  ] ++ (import ./bin { inherit pkgs theme; });

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

  xsession = {
    enable = true;
    windowManager.command = "cwm";
    initExtra = ''
      xrdb -load $HOME/.Xresources
      xmodmap $HOME/.xmodmap
      bar &
    '';
  };

}
