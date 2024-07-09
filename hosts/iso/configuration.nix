{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      ../ssh.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "iso";
  networking.networkmanager.enable = true;

  time.timeZone = "Europe/Helsinki";

  i18n.defaultLocale = "en_US.UTF-8";

  i18n.extraLocaleSettings = {
    LC_ADDRESS = "en_US.UTF-8";
    LC_IDENTIFICATION = "en_US.UTF-8";
    LC_MEASUREMENT = "en_US.UTF-8";
    LC_MONETARY = "en_US.UTF-8";
    LC_NAME = "en_US.UTF-8";
    LC_NUMERIC = "en_US.UTF-8";
    LC_PAPER = "en_US.UTF-8";
    LC_TELEPHONE = "en_US.UTF-8";
    LC_TIME = "en_US.UTF-8";
  };

  sound.enable = true;
  hardware.pulseaudio.enable = true;
  hardware.opengl = {
    enable = true;
    extraPackages = with pkgs; [
      intel-media-driver
      vaapiIntel
      vaapiVdpau
      libvdpau-va-gl
      intel-compute-runtime
    ];
  };

  security = {
    doas.enable = true;
    sudo.enable = true;
    doas.extraConfig = ''
      permit nopass :wheel
    '';
    doas.extraRules = [{
      users = [ "icy" ];
    }];
  };

  users.users.icy = {
    isNormalUser = true;
    description = "icy";
    extraGroups = [ "networkmanager" "wheel" "docker" ];
    packages = with pkgs; [ ];
  };

  users.users.git = {
    isNormalUser = true;
    description = "git";
    extraGroups = [ "networkmanager" "wheel" ];
    homeMode = "755";
    packages = with pkgs; [ ];
  };


  nixpkgs.config.allowUnfree = true;
  environment.systemPackages = with pkgs; [
    vim
    wget
    git
  ];

  services = {
    openssh.enable = true;
    tailscale.enable = true;
    # nix-snapshotter.enable = true;
  };

  services.k3s = let address = "100.109.134.88"; in {
    enable = true;
    role = "agent";
    extraFlags = "--node-ip=${address} --node-external-ip=${address} --flannel-iface=tailscale0";
    serverAddr = "https://sini:6443";
    tokenFile = "/var/lib/rancher/k3s/token";
  };

  services.openiscsi = {
    enable = true;
    name = config.networking.hostName;
  };

  environment.etc = {
    "rancher/k3s/registries.yaml" = {
      text = ''
        mirrors:
          sini:5000:
            endpoint:
              - "http://sini:5000"
      '';
    };
  };

  systemd.tmpfiles.rules = [
    "L+ /usr/local/bin - - - - /run/current-system/sw/bin/"
  ];

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.05";
}

