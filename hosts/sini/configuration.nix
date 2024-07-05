{ config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;

  networking.hostName = "sini"; # Define your hostname.

  boot.kernelParams = [ "ip=dhcp" ];
  boot.initrd = let interface = "wlp3s0"; in
    {
      luks.devices."luks-0ae4be28-55a1-4a0c-8518-c6d53540cb26".device = "/dev/disk/by-uuid/0ae4be28-55a1-4a0c-8518-c6d53540cb26";
      availableKernelModules = [ "ccm" "ctr" "iwlmvm" "iwlwifi" ];

      systemd = {
        enable = true;

        packages = [ pkgs.wpa_supplicant ];
        initrdBin = [ pkgs.wpa_supplicant ];
        targets.initrd.wants = [ "wpa_supplicant@${interface}.service" ];

        # prevent WPA supplicant from requiring `sysinit.target`.
        services."wpa_supplicant@".unitConfig.DefaultDependencies = false;

        users.root.shell = "/bin/systemd-tty-ask-password-agent";
        network = {
          enable = true;
          networks."wifi" = {
            enable = true;
            DHCP = "yes";
            name = interface;
          };
        };

      };

      network = {
        enable = true;
        ssh = {
          enable = true;
          port = 22;
          authorizedKeys = [ "ssh-rsa AAAAyourpublic-key-here..." ];
          hostKeys = [ "/etc/secrets/initrd/ssh_host_rsa_key" ];
        };
      };
    };

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

  services.pixelfed = {
    enable = true;
    domain = "ani.place";
    secretFile = "/home/icy/svc/pixelfed/.env";
    nginx.listen = [
      {
        addr = "0.0.0.0";
        port = 3535;
      }
    ];
  };

  # building only
  virtualisation.docker.enable = true;

  services.k3s = {
    enable = true;
    extraFlags = "--disable=traefik --disable=servicelb --disable=metrics-server --bind-address=100.85.88.64 --node-ip=100.85.88.64 --node-external-ip=100.85.88.64";
  };

  services.dockerRegistry = {
    enable = true;
    listenAddress = "0.0.0.0";
    port = 5000;
    enableGarbageCollect = true;
  };

  nix.settings.experimental-features = [ "nix-command" "flakes" ];
  system.stateVersion = "24.05";
}

