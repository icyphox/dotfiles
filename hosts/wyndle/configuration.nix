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
    kernelPackages = pkgs.linuxPackages_latest;
    kernelModules = [ "i2c-dev" "v4l2loopback" ];
  };

  boot.blacklistedKernelModules = [ "nouveau" "nvidia" "nvidia_drm" "nvidia_modeset" ];
  boot.extraModprobeConfig = ''
    blacklist nouveau
    options nouveau modeset=0
    options v4l2loopback video_nr=2,3 width=640,1920 max_width=1920 height=480,1080 max_height=1080 format=YU12,YU12 exclusive_caps=1,1 card_label=Phone,Laptop debug=1
  '';

  boot.extraModulePackages = with config.boot.kernelPackages; [
    v4l2loopback
  ];

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
    chromium = {
      commandLineArgs = "--ozone-platform=wayland --enable-features=TouchpadOverscrollHistoryNavigation";
    };
    firefox.enablePlasmaBrowserIntegration = true;
  };


  environment = {
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
      (lib.hiPrio pkgs.bashInteractive)
    ];
    gnome.excludePackages = (with pkgs; [
      gnome-photos
      gnome-tour
    ]) ++ (with pkgs; [
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

  hardware = {
    bluetooth = {
      enable = true;
      powerOnBoot = true;
      disabledPlugins = [ "sap" ];
    };
    nvidia.prime = {
      offload.enable = false;
      amdgpuBusId = "PCI:8:0:0";
      nvidiaBusId = "PCI:1:0:0";
    };
    logitech.wireless = {
      enable = true;
      enableGraphical = true;
    };
    graphics.extraPackages = [ pkgs.amdvlk ];
  };

  services = {
    asusd = {
      enable = true;
      enableUserService = true;
    };
    supergfxd = {
      enable = true;
      settings = {
        mode = "integrated";
        vfio_enable = false;
        vfio_save = false;
        always_reboot = true;
        no_logind = false;
        logout_timeout_s = 180;
      };

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
      videoDrivers = [ "amdgpu" ];
      screenSection = ''
        Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
        Option         "AllowIndirectGLXProtocol" "off"
        Option         "TripleBuffer" "on"
      '';
    };

    libinput = {
      enable = true;
      mouse = {
        scrollButton = 8;
        scrollMethod = "button";
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

        # Remove NVIDIA USB xHCI Host Controller devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c0330", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA USB Type-C UCSI devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x0c8000", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA Audio devices, if present
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x040300", ATTR{power/control}="auto", ATTR{remove}="1"
        # Remove NVIDIA VGA/3D controller devices
        ACTION=="add", SUBSYSTEM=="pci", ATTR{vendor}=="0x10de", ATTR{class}=="0x03[0-9]*", ATTR{power/control}="auto", ATTR{remove}="1"
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
          capslock = overload(capslock, rightalt)
          leftmeta = layer(meta_mac)
          rightmeta = layer(meta_mac)
          leftalt = layer(option_mac)
          rightalt = layer(option_mac)

          [capslock]
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

          # macOS style bindings
          [meta_mac:M]
          l = C-l
          a = C-a
          t = C-t
          w = C-w
          f = C-f
          c = C-c
          v = C-v
          backspace = C-backspace
          leftshift = compose

          [option_mac:A]
          backspace = C-backspace
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
    pki.certificateFiles = [ ./ca.crt ];
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

