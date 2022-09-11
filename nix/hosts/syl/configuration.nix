{ self, config, pkgs, lib, ... }:

{
  programs.bash.enable = true;
  environment.shells = [ pkgs.bash ];

  services.nix-daemon.enable = true;
  nixpkgs.overlays = with self.overlays; [
    nvim-nightly
    prompt
  ];

  homebrew = {
    enable = true;
    casks = [ "adur1990/tap/passformacos" ];
    masApps = {
      Tailscale = 1475387142;
    };
  };

  system.activationScripts.applications.text = pkgs.lib.mkForce (
    ''
      echo "setting up ~/Applications..." >&2
      rm -rf ~/Applications/Nix\ Apps
      mkdir -p ~/Applications/Nix\ Apps
      for app in $(find ${config.system.build.applications}/Applications -maxdepth 1 -type l); do
        src="$(/usr/bin/stat -f%Y "$app")"
        cp -r "$src" ~/Applications/Nix\ Apps
      done
    ''
  );
}
