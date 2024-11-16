{ config, pkgs, systemSettings, userSettings, ... }: {
  imports = [ # Include the results of the hardware scan.
    ./hardware-configuration.nix
    #import "${systemSettings.systemModulesPath}/core"
    ../../modules/nixos/core


    ../../modules/nixos/optional/desktop
    ../../modules/nixos/optional/gpu2
    ../../modules/nixos/optional/mouse
    ../../modules/nixos/optional/printing
    ../../modules/nixos/optional/sound
    ../../modules/nixos/optional/ssd
    ../../modules/nixos/optional/system76
    ../../modules/nixos/optional/zram
  ];

  # Gaming mode
  custom.gamingMode.enable = true;

  # GPU
  custom.gpu.mode = "nvidia";

  users.users.${userSettings.username} = {
    isNormalUser = true;
    description = "Hoaq";
    home = "/home/hoaq";
    extraGroups = [ "networkmanager" "wheel" ];
    packages = with pkgs;
      [
        #  thunderbird
      ];
  };

  # Disable password for Wheel usergroup
  security.sudo.wheelNeedsPassword = false;

}
