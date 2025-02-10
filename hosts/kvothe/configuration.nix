{ self, config, pkgs, lib, ... }:

{
  programs.bash.enable = true;
  environment = {
    shells = [ pkgs.bash ];
  };


  users.users.icy = {
    name = "icy";
    home = "/Users/icy";
  };

  services.nix-daemon.enable = true;
  security.pam.enableSudoTouchIdAuth = true;
  
  system.stateVersion = 5;

  system.activationScripts.applications.text = pkgs.lib.mkForce (
    # ''
    #   echo "setting up ~/Applications..." >&2
    #   rm -rf ~/Applications/Nix\ Apps
    #   mkdir -p ~/Applications/Nix\ Apps
    #   for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
    #     src="$(/usr/bin/stat -f%Y "$app")"
    #     cp -r "$src" ~/Applications/Nix\ Apps
    #   done
    # ''

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
}
