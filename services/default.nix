{ config
, pkgs
, ...
}:

{

  services = {
    gpg-agent = {
      enable = true;
      defaultCacheTtl = 60 * 60 * 24 * 7;
      maxCacheTtl = 60 * 60 * 24 * 7;
      pinentryPackage = pkgs.pinentry-gnome3;
    };
  };
}
