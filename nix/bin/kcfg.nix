{ pkgs, ... }:

let
  name = "kcfg";
  fzy = "${pkgs.fzy}/bin/fzy";
  fd = "${pkgs.fd}/bin/fd";
in
pkgs.writeShellScriptBin name
  ''
    cfg="$(${fd} . ~/code/upcloud/.kube | ${fzy})"
    export KUBECONFIG="$cfg"
    echo "KUBECONFIG set to $cfg"
  ''
