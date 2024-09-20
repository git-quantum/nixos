{ config, pkgs, ... }:

# Ensure gs.sh is created if gamingMode on
let
    # Check if Steam is installed on the system
    steamInstalled = builtins.exec "which steam" == 0;

in
{
    # Create the .sh if steam is installed
    home.file."${config.home.homeDirectory}/.config/hm-modules/gaming//gs.sh".text = if steamInstalled then builtins.readFile ../scripts/gs.sh;
}