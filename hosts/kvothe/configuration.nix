{ self, config, pkgs, lib, ... }:

{

  nixpkgs.config.allowUnfree = true;

  programs = {
    bash.enable = true;
    fish.enable = true;
  };

  services = {
    tailscale = {
      enable = true;
    };
  };

  environment = {
    variables = {
      EDITOR = "nvim";
    };
    shells = [ pkgs.bash ];
  };

  users.knownUsers = [ "icy" ];
  users.users.icy = {
    name = "icy";
    home = "/Users/icy";
    uid = 501;
    shell = pkgs.fish;
  };

  networking = {
    hostName = "kvothe";
    localHostName = "kvothe";
    dns = [
      "100.100.100.100"
    ];
    knownNetworkServices = [
      "Thunderbolt Bridge"
      "Wi-Fi"
    ];
  };

  security.pam.services.sudo_local.touchIdAuth = true;
  # security.pam.enableSudoTouchIdAuth = true;


  system = {
    activationScripts.applications.text = pkgs.lib.mkForce (
      ''
                echo "setting up /Applications..." >&2
                rm -rf /Applications/Nix\ Apps
                mkdir -p /Applications/Nix\ Apps
                find ${
        pkgs.buildEnv {
        name = "system-applications";
        paths = config.environment.systemPackages;
        pathsToLink = "/Applications";
        }
        }/Applications -maxdepth 1 -type l -exec readlink '{}' + |
                while read -r src; do
                  app_name=$(basename "$src")
                  echo "copying $src" >&2
                  ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
                done
      ''
    );

    defaults = {
      screencapture.location = "/Users/icy/Pictures/Screenshots";
    };

    stateVersion = 5;
  };

  homebrew = {
    enable = true;
    onActivation = {
      autoUpdate = true;
      cleanup = "uninstall";
      upgrade = true;
    };
    casks = [
      "orion"
      "karabiner-elements"
      "halloy"
      "zed"
      "raycast"
      "signal@beta"
      "zen-browser"
    ];
  };
}
