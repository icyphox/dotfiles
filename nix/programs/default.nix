{ config
, pkgs
, theme
, self
, ...
}:

{

  imports = [
    ./bash.nix
    ./chromium.nix
    ./git.nix
    ./neovim.nix
    ./readline.nix
    ./tmux.nix
    ./zathura.nix
    # ./firefox.nix
  ];

  programs = {
    home-manager.enable = true;
    mbsync.enable = true;
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv = {
        enable = true;
      };
    };
    zoxide = {
      enable = true;
      enableBashIntegration = true;
    };
    nix-index = {
      enable = true;
      enableBashIntegration = true;
    };
    gpg.enable = true;
    htop = {
      enable = true;
      settings.color_scheme = 1;
    };
  };
}
