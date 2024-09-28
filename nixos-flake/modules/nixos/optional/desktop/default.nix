{
  services = {
    # Cosmic
    desktopManager.cosmic.enable = true;
    displayManager.cosmic-greeter.enable = true;

    xserver = {
      enable = true;
      # Gnome
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}