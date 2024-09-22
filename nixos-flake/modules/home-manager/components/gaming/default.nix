{ config, pkgs, lib, ... }:

let
  # Add script's location to Nixos managed paths
  gsScriptPath = builtins.path {
    name = "gs.sh";
    path = ./../../scripts/gs.sh;
  };

  # Get pkgs at system and user level
  systemPackages = config.environment.systemPackages or [ ];
  userPackages = config.home.packages or [ ];

  # Check if pkgs.steam is present in user packages
  isSteamInstalled = lib.elem pkgs.steam userPackages;

in {
  # Debug
  home.activation = {
    steamCheck = ''
      echo "System packages: ${toString systemPackages}"
      echo "User packages: ${toString userPackages}"
      echo "Steam installed: ${toString isSteamInstalled}"
    '';
  };

  # Add dotfile if steam installed
  home.file = lib.mkIf isSteamInstalled {
    "gs.sh" = {
      source = gsScriptPath;
      target = ".config/hm-modules/gaming/gs.sh";
      executable = true;
    };
  };
}
