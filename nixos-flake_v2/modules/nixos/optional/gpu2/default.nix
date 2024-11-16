{pkgs, lib, config, gpuType, ...}: 
let
  currentNixosVersion = builtins.substring 0 5 ((import <nixos> {}).lib.version);
  nixosVersionNewerThan24_11 = lib.strings.versionAtLeast currentNixosVersion "24.11";
  nixosVersionOlderThan24_11 = !nixosVersionNewerThan24_11;

  gpuConfig = if gpuType == "nvidia" then {
    services.xserver.videoDrivers = [ "nvidia" ];
    hardware.nvidia = {
      open = false;
      modesettings.enable = true;
      nvidia.setting = true;
    };
  } else {
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware.amdgpu.opencl.enable = true;
  };

  graphicAccelerationConfig = if nixosVersionNewerThan24_11 then{
    graphics.enable = true;
    graphics.enable32Bit = true;  
  } else if nixosVersionOlderThan24_11 then {
    opengl.enable = true;
    opengl.driSupport = true;
    opengl.driSupport32bit = true;
  };

in
{
  hardware = lib.mkMerge [
    gpuConfig
    graphicAccelerationConfig
  ];
};
