{ config, pkgs, ... }:

# Ensure gs.sh is created if gamingMode on
let
  # Check if Steam is installed on the system
  steamInstalled = builtins.exec "which steam" == 0;

  gsScript = ''
        #!/usr/bin/env bash
                set -xeuo pipefail

                gamescopeArgs=(
                    --adaptive-sync # VRR support
                    --hdr-enabled
                    --mangoapp # performance overlay
                    --rt
                    --steam
                )
                steamArgs=(
                    -pipewire-dmabuf
                    -tenfoot
                )
                mangoConfig=(
                    cpu_temp
                    gpu_temp
                    ram
                    vram
                )
                mangoVars=(
                    MANGOHUD=1
                    MANGOHUD_CONFIG="$(IFS=,; echo "${mangoConfig[*]}")"
                )

                export "${mangoVars[@]}"
                exec gamescope "${gamescopeArgs[@]}" -- steam "${steamArgs[@]}"
    ''
in
{
  # Create the .sh if steam is installed
  home = {
    file.".config/hm-modules/gaming/gs.sh" = {
        text = if steamInstalled then gsScript;
        executable = true; chmod +x the the new script
    };
  };
}