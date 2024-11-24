{ systemSettings, ... }:
let
  kdeDesktop = {
    services = {
      # KDE
      displayManager.sddm.enable = false;
      desktopManager.plasma6.enable = false;
    };
  };

  gnomeDesktop = {
    services = {
      xserver = {
        enable = true;
        # Gnome
        displayManager.gdm.enable = true;
        desktopManager.gnome.enable = true;
      };
    };
  };

in
{
  config = if systemSettings.desktop == "gnome" then gnomeDesktop else kdeDesktop;
}
