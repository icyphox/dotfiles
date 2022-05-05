{ pkgs, ... }:

let
  name = "kctx";
  kubectx = "${pkgs.kubectx}/bin/kubectx";
  fzy = "${pkgs.fzy}/bin/fzy";
in
pkgs.writeShellScriptBin name
  ''
    ctx="$(${kubectx} | ${fzy})"
    ${kubectx} "$ctx"
  ''
