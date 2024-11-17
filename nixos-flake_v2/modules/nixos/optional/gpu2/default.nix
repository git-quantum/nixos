{pkgs, lib, config, userSettings, systemSettings, ...}: 
let
  currentNixosVersion = builtins.substring 0 5 ((import <nixos> {}).lib.version);
  nixosVersionNewerThan24_11 = lib.strings.versionAtLeast currentNixosVersion "24.11";
  nixosVersionOlderThan24_11 = !nixosVersionNewerThan24_11;

  gpuConfig = if systemSettings.gpuType == "nvidia" then {
    services.xserver.videoDrivers = [ "nvidia" ];
    nvidia = {
      open = false;
      modesetting.enable = true;
      nvidiaSettings = true;
    };
  } else {
    services.xserver.videoDrivers = [ "amdgpu" ];
    hardware.amdgpu.opencl.enable = true;
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
    gpuConfig
    graphicAccelerationConfig
  ];
}
