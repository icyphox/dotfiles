{ config
, pkgs
, self
, host
, lib
, inputs
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

  home.stateVersion = "24.11";
  home.username = "icy";
  home.homeDirectory = "/home/icy";
  home.extraOutputsToInstall = [ "man" ];

  home.packages = [
    pkgs.git
    pkgs.unzip
    pkgs.curl
    pkgs.tmux
    pkgs.ripgrep
    pkgs.fd
    pkgs.imagemagick
    pkgs.ffmpeg
    pkgs.wget
    pkgs.tree
    pkgs.mpv
    pkgs.noto-fonts-cjk
    pkgs.noto-fonts-emoji
    pkgs.jq
    pkgs.yq-go
    pkgs.fzy
    pkgs.nixpkgs-fmt
    pkgs.libnotify
    pkgs.signal-desktop
    pkgs.calibre
    pkgs.pinentry
    pkgs.libreoffice
    pkgs.go
    pkgs.dconf
    pkgs.chromium
    pkgs.nix-your-shell
    pkgs.geary
    pkgs.pass
    pkgs.newsflash
    pkgs.errands
    pkgs.wl-clipboard
    pkgs.nvtop

    pkgs.gnome3.gnome-tweaks
    pkgs.gnome3.gnome-shell-extensions
    pkgs.gnomeExtensions.appindicator
    pkgs.gnomeExtensions.dash-to-dock
    pkgs.gnomeExtensions.search-light
    pkgs.gnomeExtensions.hide-top-bar

    pkgs.prompt
    pkgs.zed-editor
    # inputs.zed.packages.${pkgs.system}.zed-editor

  ] ++ (import ./bin { inherit pkgs host; });

  dconf.settings = {
    "org/gnome/mutter" = {
      experimental-features = [ "scale-monitor-framebuffer" ];
    };
    "org/gnome/desktop/input-sources" = {
      show-all-sources = true;
      sources = [
        (mkTuple [
          "xkb"
          "us+workman"
        ])
        (mkTuple [
          "xkb"
          "us"
        ])
      ];
      xkb-options = [
        "terminate:ctrl_alt_bksp"
        "compose:ralt"
      ];
    };
    "org/gnome/mutter" = {
      overlay-key = [ "" ];
    };
    "org/gnome/shell/extensions/search-light" = {
      shortcut-search = [ "<Super>space" ];
    };
    "org/gnome/settings-daemon/plugins/media-keys" = {
      screensaver = [ "<Control><Super>q" ];
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
