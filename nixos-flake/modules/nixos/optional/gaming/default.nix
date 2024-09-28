{ pkgs, lib, config, ... }: {
  options = {
    custom.gamingMode.enable = lib.mkOption {
      type = lib.types.bool;
      description = "Setup gaming configuration.";
      default = false;
    };
  };

  config = lib.mkIf config.custom.gamingMode.enable {
    hardware.xone.enable = true; # support for the xbox controller USB dongle
    
    programs = {
      steam = {
        enable = true;
        gamescopeSession.enable = true;
      };

      gamemode.enable = true;
    };

    environment = {
      systemPackages = with pkgs; [ 
        discord 
        goverlay 
        mangohud
        lutris
        bottles 
      ];
    };
  };
}
