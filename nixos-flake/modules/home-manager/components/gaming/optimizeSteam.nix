{ pkgs, lib, config, ...}:
{
    imports = [
        (../../scripts/check_bin.nix {inherit pkgs;})
    ];

    let
        # Add script's location to Nixos managed paths
        gsScriptPath = builtins.path {
            name = "gs.sh";
            path = ./gs.sh;
        };

    in
    {
    # Copy script in target locations if Steam installed
    home.file = lib.mkIf (check_bin steam) then {
        "gs.sh" = {
            source = gsScriptPath;
            target = ".config/hm-modules/gaming/gs.sh";
            executable = true;
        };
    } else {};
    };

}