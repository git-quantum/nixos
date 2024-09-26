{ config, pkgs, lib, ... }:

let
  # Add script's location to Nixos managed paths
  gsScriptPath = builtins.path {
    name = "gs.sh";
    path = ./../../scripts/gs.sh;
  };

in {
  home.file."${config.home.homeDirectory}/.config/hm-modules/gaming/gs.sh".text =
    builtins.readFile gsScriptPath;
}
