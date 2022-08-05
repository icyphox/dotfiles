{ config
, pkgs
, theme
, ...
}:

{

  imports = [
    ./dunst.nix
    ./picom.nix
    ./sxhkd.nix
    ./mbsync.nix
  ];

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 60 * 60 * 24 * 7;
      maxCacheTtl = 60 * 60 * 24 * 7;
      pinentryFlavor = "curses";
    };
  };

}
