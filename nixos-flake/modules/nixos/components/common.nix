{ pkgs, ...}: {
  # Enable sound with Pipewire
  hardware.pulseaudio.enable = false;
  security.rtkit.enable = true;
  services.pipewire = {
    enable = true;
    alsa.enable = true;
    alsa.support32Bit = true;
    pulse.enable = true;
  };
  
  # Allow unfree pkgs
  nixpkgs.config.allowUnfree = true;

  # Enable CUPS for printing
  services.printing.enable = true;
  
  # Enable Zram
  zramSwap.enable = true;

  # Optimize SSD
  services.fstrim.enable = true;

  # Enable 32bits support applications
  ## nixpkg 24.04
  #hardware.opengl.driSupport32bit = true;

  ## nixpkg-unstable
  hardware.graphics.enable32Bit = true;

  # Enable flakes
  nix.settings.experimental-features = [ "nix-command" "flakes" ];

  # Disable mouse acceleration
  services.libinput.mouse.accelProfile = "flat";

  # Set zsh shell by default
  environment.shells = with pkgs; [ zsh ];
  users.defaultUserShell = pkgs.zsh;
  programs.zsh.enable = true;

}
