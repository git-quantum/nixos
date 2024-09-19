{lib, config, ...}: {
  
  options = {
    custom.gpu.mode = lib.mkOption {
      type = lib.types.str;
      description = " Choose whether to use 'amd' or 'nvidia' for GPU setup.";
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
    })
  ];
}

