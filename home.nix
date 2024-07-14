{ config
, pkgs
, self
, host
, lib
, ...
}:

let
  mkTuple = lib.hm.gvariant.mkTuple;
in
{

  imports = [
    ./programs
    ./services
  ];

  fonts.fontconfig.enable = true;
  manual.manpages.enable = true;

  home.stateVersion = "24.05";
  home.username = "icy";
  home.homeDirectory = "/home/icy";
  home.extraOutputsToInstall = [ "man" ];

  home.packages = with pkgs; [

    git
    unzip
    curl
    tmux
    ripgrep
    fd
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
    signal-desktop-beta
    calibre
    pinentry
    libreoffice
    go
    dconf
    chromium
    evolution
    nix-your-shell
    pass
    zed-editor
    newsflash
    wl-clipboard

    gnome3.gnome-tweaks
    gnome3.gnome-shell-extensions
    gnomeExtensions.appindicator
    gnomeExtensions.dash-to-dock
    gnomeExtensions.unite
    gnomeExtensions.search-light

  ] ++ (import ./bin { inherit pkgs host; });

  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
    "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [ (mkTuple [ "xkb" "us+workman" ]) (mkTuple [ "xkb" "us" ]) ];
      xkb-options = [ "terminate:ctrl_alt_bksp" "compose:ralt" ];
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

