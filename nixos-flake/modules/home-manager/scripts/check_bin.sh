{ pkgs }:

pkgs.writeShellScriptBin "check_bin" ''
  if (which $1)
    exit 0
  else
    exit 1
''
