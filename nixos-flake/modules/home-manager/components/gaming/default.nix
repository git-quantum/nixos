{ config, pkgs, lib, ... }:
let 
    # Add script's location to Nixos managed paths
    gsScriptPath = builtins.path {
      name = "gs.sh";
      path = ./../../scripts/gs.sh;
    };

    # Check if Steam is installed on system
    isSteamInstalled = lib.mkIf (lib.elem pkgs.steam (config.environment.systemPackages or []));
   
in
{
    # Copy script in target locations if Steam installed
    home.file = isSteamInstalled {
        "gs.sh" = {
            source = gsScriptPath;
            target = ".config/hm-modules/gaming/gs.sh";
            executable = true;
        };
    };
}
