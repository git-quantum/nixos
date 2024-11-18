{
  services = {
      # KDE
      displayManager.sddm.enable = false;
      desktopManager.plasma6.enable = false;
      
    xserver = {
      enable = true;
      # Gnome
      displayManager.gdm.enable = true;
      desktopManager.gnome.enable = true;
    };
  };
}
