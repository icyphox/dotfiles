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
  ];

  programs = {
    home-manager.enable = true;
    direnv = {
      enable = true;
      enableBashIntegration = true;
      nix-direnv = {
        enable = true;
      };
      stdlib = ''
        layout_poetry() {
          if [[ ! -f pyproject.toml ]]; then
            log_error 'No pyproject.toml found. Use `poetry new` or `poetry init` to create one first.'
            exit 2
          fi

          local VENV=$(poetry env list --full-path | cut -d' ' -f1)
          if [[ -z $VENV || ! -d $VENV/bin ]]; then
            log_error 'No poetry virtual environment found. Use `poetry install` to create one first.'
            exit 2
          fi

          export VIRTUAL_ENV=$VENV
          export POETRY_ACTIVE=1
          PATH_add "$VENV/bin"
        }
      '';
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
