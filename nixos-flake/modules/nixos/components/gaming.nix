{ pkgs, lib, config, ... }: {
  options = {
    custom.gamingMode.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Setup gaming configuration.";
      default = false;
    };
  };

  config = lib.mkIf config.custom.gamingMode.enable {
    # Setup Steam with gamescope session
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };
    };

    hardware.xone.enable = true; # support for the xbox controller USB dongle

    # Goverlay / Lutris / Bottles
    environment = {
      systemPackages = with pkgs; [ 
        discord 
        goverlay 
        mangohud
        lutris
        bottles 
      ];
    };

    # Gamemode
    programs.gamemode.enable = true;
  };
}
