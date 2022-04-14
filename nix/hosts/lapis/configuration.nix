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
    wireless = {
      enable = true;
      interfaces = [ "wlan0" ];
      environmentFile = "/home/icy/secrets/wireless.env";
      networks = {
        Sanic.psk = "@PSK_SANI@";
        Gopalan.psk = "@PSK_GOPA@";
        "GoSpaze 2" = {
          psk = "@PSK_GOSP@";
        };
      };
      extraConfig = ''
        ctrl_interface=/run/wpa_supplicant
        ctrl_interface_group=wheel
      '';
    };
    # dhcpcd.enable = true;
    hostName = "lapis";
    useDHCP = false;
    interfaces.wlan0.useDHCP = true;
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
      displayManager.startx.enable = true;
      libinput.enable = true;
    };
    tailscale.enable = true;

    # 1. chmod for rootless backligh1t
    # 2. lotus58 bootloader mode for rootless qmk flashing
    udev = {
      extraRules = ''
        ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="intel_backlight", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
        ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0036", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
      '';
      path = [
        pkgs.coreutils
      ];
    };
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
    pki.certificateFiles = [ "/home/icy/.local/share/caddy/pki/authorities/local/root.crt" ];
  };


  users.users.icy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" "video" "dialout" ];
  };

  nix = {
    package = pkgs.nixFlakes;
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

