{ config
, pkgs
, ...
}:

{
  services.mbsync = {
    enable = true;
    frequency = "*:0/15";
  };
}
