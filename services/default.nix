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
      pinentryFlavor = "qt";
    };
    plan9port = {
      fontsrv.enable = true;
      plumber.enable = true;
    };
  };

}
