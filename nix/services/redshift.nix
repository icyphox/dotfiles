{ config
, pkgs
, ...
}:

{
  services.redshift = {
    enable = true;
    temperature = {
      day = 5000;
      night = 4000;
    };
    tray = false;
    provider = "manual";
    latitude = "12";
    longitude = "77";
  };
}
