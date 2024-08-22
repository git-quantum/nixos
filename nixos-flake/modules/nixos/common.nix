{
  # Enable sound with Pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alse.support32Bit = true;
    pulse.enable = true;
  };
  
  # Allow unfree pkgs
  nixpkgs.config.allowUnfree = true;

  # Enable CUPS for printing
  services.priting.enable = true;
  
  # Enable Zram
  zramSwap.enable = true;

  # Optimize SSD
  services.fstrim.enable = true;

  # Enable 32bits support applications
  hardware.opengl.driSupport32bit = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Disable mouse acceleration
  services.libinput.mouse.accelProfile = "flat";
}
