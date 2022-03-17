{ self, config, pkgs, theme, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  boot.kernel.sysctl."net.ipv4.ip_forward" = 1;

  networking = {
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    networkmanager = {
      enable = true;
      insertNameservers = [ "1.1.1.1" "1.0.0.1" ];
      wifi.backend = "iwd";
    };
    dhcpcd.enable = false;
    hostName = "lapis";
    useDHCP = false;
    interfaces.wlan0.useDHCP = true;
    wireless.iwd.enable = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Kolkata";

  nixpkgs.config = {
    allowUnfree = true;
    st = {
      conf = builtins.readFile ../../programs/st/config.h;
      extraLibs = with pkgs; [ harfbuzz ];
      patches = [
        ../../patches/st/xres.diff
        ../../patches/st/bright.diff
        ../../patches/st/ligatures.diff
      ];
    };
  };

  nixpkgs.overlays = with self.overlays; [
    nvim-nightly
    prompt
  ];

  environment.systemPackages = with pkgs; [
    cwm
    man-pages
    git
    man-pages-posix
    (lib.hiPrio pkgs.bashInteractive_5)
  ];

  documentation = {
    dev.enable = true;
    man.generateCaches = true;
  };

  users.motd = with config; ''
    Host       ${networking.hostName}
    OS         NixOS ${system.nixos.release} (${system.nixos.codeName})
    Version    ${system.nixos.version}
    Kernel     ${boot.kernelPackages.kernel.version}
  '';

  console = {
    font = "Lat2-Terminus16";
    keyMap = "us";
  };

  sound.enable = true;
  hardware = {
    pulseaudio.enable = true;
    bluetooth = {
      enable = true;
      powerOnBoot = true;
    };
  };

  services = {
    xserver = {
      enable = true;
      layout = "us";
      xkbVariant = "workman";
      displayManager.startx.enable = true;
      libinput.enable = true;
    };
    tailscale.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
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
    extraGroups = [ "wheel" "docker" "audio" "video" ];
  };

  nix = {
    package = pkgs.nixUnstable;
    extraOptions = ''
      experimental-features = nix-command flakes ca-derivations
      warn-dirty = false
      keep-outputs = false
    '';
    settings = {
      trusted-users = [
        "root"
        "icy"
      ];
    };
  };


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

