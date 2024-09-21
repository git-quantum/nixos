{ pkgs }:
pkgs.writeShellScriptBin "pkgChecker" ''
  if test -x /run/current-system/sw/bin/steam $1;
  then exit 0
  else exit 1
''