{ systemSettings, ... }:
let
  kdeDesktop = {
    services = {
      # KDE
      displayManager.sddm.enable = false;
      desktopManager.plasma6.enable = false;
    };
  };
in
{
  gnomeDesktop =
    if systemSettings.desktop == "gnome" then {
      services = {
        xserver = {
          enable = true;
          # Gnome
          displayManager.gdm.enable = true;
          desktopManager.gnome.enable = true;
        };
      };
    } else kdeDesktop;
}
