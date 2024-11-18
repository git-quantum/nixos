{pkgs, lib, config, userSettings, systemSettings, ...}: 
let
  currentNixosVersion = builtins.substring 0 5 ((import <nixos> {}).lib.version);
  nixosVersionNewerThan24_11 = lib.strings.versionAtLeast currentNixosVersion "24.11";
  nixosVersionOlderThan24_11 = !nixosVersionNewerThan24_11;

  

  gpuConfig = if systemSettings.gpuType == "nvidia" then {
    serviceConfig = { 
      xserver.videoDrivers = [ "nvidia" ]; 
    };

    hardwareConfig = {
      nvidia = {
        open = false;
        modesetting.enable = true;
        nvidiaSettings = true;
      };
    };
  } else {
    serviceConfig = {
      xserver.videoDrivers = [ "amdgpu" ];
    };
    
    hardwareConfig = { 
      amdgpu.opencl.enable = true; 
    };
  };

  graphicAccelerationConfig = if systemSettings.nixosVersion >= "2411" then{
    graphics.enable = true;
    graphics.enable32Bit = true;  
  } else if systemSettings.nixosVersion <= "2405" then {
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32Bit = true;
  } else {};

in
{
  hardware = lib.mkMerge [
    gpuConfig.hardwareConfig
    graphicAccelerationConfig
  ];

  services = lib.mkMerge [
    gpuConfig.serviceConfig
  ];
}
