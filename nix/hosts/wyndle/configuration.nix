let
  asusctl-tar = fetchTarball "https://github.com/NixOS/nixpkgs/archive/a4a81b6f6c27e5a964faea25b7b5cbe611f98691.tar.gz";
in
{ self, config, pkgs, theme, lib, ... }:

{
  imports =
    [
      ./hardware-configuration.nix
      "${asusctl-tar}/nixos/modules/services/misc/asusctl.nix"
      "${asusctl-tar}/nixos/modules/services/misc/supergfxctl.nix"
    ];

  boot = {
    loader.systemd-boot.enable = true;
    loader.efi.canTouchEfiVariables = true;
    kernel.sysctl."net.ipv4.ip_forward" = 1;
    kernelParams = [ "mem_sleep_default=deep" ];
    kernelPatches = [{
      name = "three-hundred-hertz";
      patch = null;
      extraConfig = ''
        HZ_300 y
        HZ 300
      '';
    }];
    resumeDevice = "/dev/nvme0n1p2";
  };

  networking = {
    nameservers = [ "1.1.1.1" "1.0.0.1" ];
    wireless = {
      enable = true;
      interfaces = [ "wlp6s0" ];
      environmentFile = "/home/icy/secrets/wireless.env";
      networks = {
        Sanic.psk = "@PSK_SANI@";
        Gopalan5G.psk = "@PSK_GOPA@";
        denim.psk = "@PSK_DENI@";
      };
      extraConfig = ''
        ctrl_interface=/run/wpa_supplicant
        ctrl_interface_group=wheel
      '';
    };
    # dhcpcd.enable = true;
    hostName = "wyndle";
    useDHCP = false;
    interfaces.wlp6s0.useDHCP = true;
  };

  i18n.defaultLocale = "en_US.UTF-8";
  time.timeZone = "Asia/Kolkata";

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
  };

  nixpkgs.overlays = with self.overlays; [
    (self: super: {
      asusctl = pkgs.callPackage "${asusctl-tar}/pkgs/tools/misc/asusctl/default.nix" { };
      supergfxctl = pkgs.callPackage "${asusctl-tar}/pkgs/tools/misc/supergfxctl/default.nix" { };
    })
    nvim-nightly
    prompt
  ];

  environment = {
    systemPackages = with pkgs; [
      asusctl
      supergfxctl
      cwm
      man-pages
      git
      man-pages-posix
      (lib.hiPrio pkgs.bashInteractive_5)
    ];
    variables = {
      MOZ_USE_XINPUT2 = "1";
      GDK_SCALE = "2";
      GDK_DPI_SCALE = "0.5";
    };
    etc = {
      "wireplumber/bluetooth.lua.d/51-bluez-config.lua".text = ''
        bluez_monitor.properties = {
          ["bluez5.enable-sbc-xq"] = true,
          ["bluez5.enable-msbc"] = true,
          ["bluez5.enable-hw-volume"] = true,
          ["bluez5.headset-roles"] = "[ hsp_hs hsp_ag hfp_hf hfp_ag ]"
        }
      '';
    };
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
  };

  services = {
    asusctl.enable = true;
    supergfxctl.enable = true;
    pipewire = {
      enable = true;
      alsa.enable = true;
      alsa.support32Bit = true;
      pulse.enable = true;
    };
    xserver = {
      enable = true;
      layout = "us";
      displayManager.startx.enable = true;
      libinput.enable = true;
      dpi = 192;
      videoDrivers = [ "nvidia" ];
      screenSection = ''
        Option         "metamodes" "nvidia-auto-select +0+0 {ForceFullCompositionPipeline=On}"
        Option         "AllowIndirectGLXProtocol" "off"
        Option         "TripleBuffer" "on"
      '';
    };
    tailscale.enable = true;
    auto-cpufreq.enable = true;
    # 1. chmod for rootless backligh1t
    # 2. lotus58 bootloader mode for rootless qmk flashing
    udev = {
      extraRules = ''
        ACTION=="add", SUBSYSTEM=="backlight", KERNEL=="amdgpu_bl1", MODE="0666", RUN+="${pkgs.coreutils}/bin/chmod a+w /sys/class/backlight/%k/brightness"
        ACTION=="add", SUBSYSTEM=="usb", ATTRS{idVendor}=="2341", ATTRS{idProduct}=="0036", TAG+="uaccess", ENV{ID_MM_DEVICE_IGNORE}="1"
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

  powerManagement = {
    enable = true;
    powertop.enable = true;
  };

  users.users.icy = {
    isNormalUser = true;
    extraGroups = [ "wheel" "docker" "audio" "video" "dialout" ];
  };

  programs = {
    steam.enable = true;
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

