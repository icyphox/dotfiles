{ config, lib, pkgs, modulesPath, ... }:

let
  keys = [
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAICJPYX06+qKr9IHWfkgCtHbExoBOOwS/+iAWbog9bAdk icy@wyndle"
    "ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIIlcByNC93n6dH41uxdLvbtf8XfKF0hoN35548PRga3M icy@kvothe"
  ];

in

{
  users.users.git.openssh.authorizedKeys.keys = keys;
  users.users.icy.openssh.authorizedKeys.keys = keys;
}
