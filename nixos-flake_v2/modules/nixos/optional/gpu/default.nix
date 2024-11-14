{lib, config, ...}: 
let
  currentNixosVersion = builtins.substring 0 5 ((import <nixos> {}).lib.version);
  nixosVersionNewerThan24_11 = lib.strings.versionAtLeast currentNixosVersion "24.11";
  nixosVersionOlderThan24_11 = !nixosVersionNewerThan24_11;

in
{
  options = {
    custom.gpu.mode = lib.mkOption {
      type = lib.types.enum [ "amd" "nvidia" ];
      description = "Choose whether to use 'amd' or 'nvidia' for GPU setup.";
      default = "amd";
    };
  };
  
  config = lib.mkMerge [
    # Setup Nvidia GPU
    (lib.mkIf (config.custom.gpu.mode == "nvidia") {
      services.xserver.videoDrivers = [ "nvidia" ];

      hardware.nvidia = {
	      open = false;
        modesetting.enable = true;
        nvidiaSettings = true;
      };
    })
    
    # Setup AMD GPU
    (lib.mkIf (config.custom.gpu.mode == "amd") {
      services.xserver.videoDrivers = [ "amdgpu" ];

      hardware = if nixosVersionNewerThan24_11 then {
        graphics.extraPackages = [ rocmPackages.clr.icd ];
      } else {
        opengl.extraPackages = [ rocmPackages.clr.icd ];
      };

      # hardware.graphics.extraPackages = lib.mkIf nixosVersionNewerThan24_11 {
      #   [
      #     rocmPackages.clr.icd
      #   ];
      # };
      
      # hardware.opengl.extraPackages = lib.mkIf nixosVersionOlderThan24_11 {
      #   [
      #     rocmPackages.clr.icd
      #   ];
      # };
    };

    # Setup graphic acceleration based on NixOS version
    hardware = lib.mkIf nixosVersionNewerThan24_11 {
      graphics.enable = true;
      graphics.enable32Bit = true;
    } // lib.mkIf nixosVersionOlderThan24_11 {
      opengl.enable = true;
      opengl.driSupport = true;
      opengl.driSupport32bit = true;
    };

    # # Setup graphic acceleration for version 24.11 or newer
    # (lib.mkIf nixosVersionNewerThan24_11 {
    #   hardware.graphics = {
    #     enable = true;
    #     enable32Bit = true;
    #   };
    # })

    # # For versions 24.04 or older
    # (lib.mkIf nixosVersionOlderThan24_11 {
    #   hardware.opengl = {
    #     enable = true;
    #     driSupport = true;
    #     driSupport32bit = true;
    #   };
    # })
  ];
}

