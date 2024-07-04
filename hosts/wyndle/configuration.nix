{ self, config, pkgs, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.systemd-boot.consoleMode = "max";
    loader.efi.canTouchEfiVariables = true;
    kernel.sysctl."net.ipv4.ip_forward" = 1;
    resumeDevice = "/dev/nvme0n1p2";
    kernelPackages = pkgs.linuxPackages;
    kernelModules = [ "i2c-dev" ];
  };

  networking = {
    nameservers = [ "8.8.8.8" "8.8.4.4" ];
    networkmanager.enable = true;
    hostName = "wyndle";
    useDHCP = false;
    interfaces.wlp6s0.useDHCP = true;
    firewall.checkReversePath = "loose";
  };

  i18n.defaultLocale = "en_US.UTF-8";
  i18n.inputMethod = {
    enabled = "ibus";
  };
  time.timeZone = "Europe/Helsinki";

  nixpkgs.config = {
    allowUnfree = true;
    allowUnfreePredicate = pkg: builtins.elem (lib.getName pkg) [
      "steam"
      "steam-original"
      "steam-runtime"
    ];
    st = {
      conf = builtins.readFile ../../programs/st/config.h;
      extraLibs = with pkgs; [ harfbuzz ];
      patches = [
        ../../patches/st/xres.diff
        ../../patches/st/bright.diff
        ../../patches/st/ligatures.diff
      ];
    };
    chromium = {
      commandLineArgs = "--ozone-platform=wayland";
    };
    firefox.enablePlasmaBrowserIntegration = true;
  };

  nixpkgs.overlays = with self.overlays; [
    prompt
  ];

  environment = {
    etc = {
      "supergfxd.conf" = {
        mode = "0644";
        source = (pkgs.formats.json { }).generate "supergfxd.conf" {
          mode = "hybrid";
          vfio_enable = false;
          vfio_save = false;
          always_reboot = false;
          no_logind = false;
          logout_timeout_s = 180;
        };
      };
    };
    sessionVariables = rec {
      NIXOS_OZONE_WL = "1";
    };
    variables = {
      MOZ_USE_XINPUT2 = "1";
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "1";
    };
    systemPackages = with pkgs; [
      man-pages
      git
      man-pages-posix
      (lib.hiPrio pkgs.bashInteractive_5)
    ];
    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs.gnome; [
      cheese
      epiphany
      geary
      totem
    ]);
  };

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
    font = "${pkgs.terminus_font}/share/consolefonts/ter-u28n.psf.gz";
    keyMap = "us";
  };

  sound.enable = true;
  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      disabledPlugins = [ "sap" ];
    };
    nvidia.prime = {
      offload.enable = true;
      amdgpuBusId = "PCI:8:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
  };

  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd = {
      enable = true;
    };
    pipewire = {
      enable = true;
      wireplumber.enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      xkb.layout = "us";
      desktopManager.gnome.enable = true;
      displayManager.gdm.enable = true;
      dpi = 192;
      videoDrivers = [ "nvidia" ];
      screenSection = ''
        Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
        Option         "AllowIndirectGLXProtocol" "off"
        Option         "TripleBuffer" "on"
      '';
      libinput = {
        enable = true;
        mouse = {
          scrollButton = 8;
          scrollMethod = "button";
        };
      };
    };
    ddccontrol.enable = true;
    tailscale.enable = true;
    # 1. chmod for rootless backligh1t
    # 2. lotus58 bootloader mode for rootless qmk flashing
    udev = {
      extraRules = ''
        ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
        ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0036", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
        KERNEL=="i2c-[0-9]*", GROUP="i2c", MODE="0660"
      '';
      extraHwdb = ''
        evdev:input:b0003v0B05p19B6*
          KEYBOARD_KEY_ff31007c=f20 # x11 mic-mute
      '';
      path = [
        pkgs.coreutils
      ];
    };
    logind.extraConfig = ''
      HandlePowerKey=hibernate
    '';

    keyd = {
      enable = true;
      keyboards.default = {
        ids = [ "*" ];
        extraConfig = ''
          [main]
          capslock = overload(capslock, esc)

          [capslock:C]
          h = left
          j = down
          k = up
          l = right

          # Activates when both capslock and shift is pressed
          [capslock+shift]
          h = C-left
          j = C-down
          k = C-up
          l = C-right
        '';
      };
    };
    pcscd.enable = true;
  };

  virtualisation.docker = {
    enable = true;
    logDriver = "json-file";
    extraOptions = ''
      --insecure-registry "http://sini:5000"
    '';
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

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  users.users.icy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" "video" "dialout" "i2c" ];
  };

  programs = {
    steam.enable = true;
    gamemode.enable = true;
  };

  nix = {
    package = pkgs.nixVersions.stable;
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

  # https://github.com/NixOS/nixpkgs/issues/180175
  systemd.services.systemd-udevd.restartIfChanged = false;
  systemd.services.NetworkManager-wait-online.enable = lib.mkForce
    false;


  # This value determines the NixOS release from which the default
  # settings for stateful data, like file locations and database versions
  # on your system were taken. It‘s perfectly fine and recommended to leave
  # this value at the release version of the first install of this system.
  # Before changing this value read the documentation for this option
  # (e.g. man configuration.nix or on https://nixos.org/nixos/options.html).
  system.stateVersion = "21.11"; # Did you read the comment?

}

