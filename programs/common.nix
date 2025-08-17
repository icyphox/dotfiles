{ config
, pkgs
, self
, ...
}:

{

  imports = [
    ./git.nix
    ./tmux.nix
    ./readline.nix
    ./neovim.nix
    ./bash.nix
    ./ssh.nix
    ./alacritty.nix
    ./fish.nix
    ./zed/default.nix
    ./jujutsu.nix
    ./ghostty/default.nix
  ];

  programs = {
    home-manager.enable = true;
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
    htop = {
      enable = true;
      settings.color_scheme = 1;
    };
  };
}
