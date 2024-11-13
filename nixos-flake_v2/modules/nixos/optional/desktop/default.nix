{
  services = {
    xserver = {
      enable = true;
      # Gnome
      displayManager.gdm.enable = false;
      desktopManager.gnome.enable = false;
  
      # KDE
      displayManager.sddm.enable = true;
      desktopManager.plasma6.enable = true;
    };
  };
}
