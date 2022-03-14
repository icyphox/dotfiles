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
  ];

  programs = {
    # msmtp.enable = true;
    home-manager.enable = true;
    mbsync.enable = false;
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv = {
        enable = true;
        enableFlakes = true;
      };
    };
    autojump = {
      enable = true;
      enableBashIntegration = true;
    };
    nix-index = {
      enable = true;
      enableBashIntegration = true;
    };
    gpg.enable = true;
  };
}
