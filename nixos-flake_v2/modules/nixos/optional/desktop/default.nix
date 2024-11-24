{ pkgs, systemSettings, ... }:
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

    environment.systemPackages = with pkgs; [
      gnomeExtensions.just-perfection
      gnomeExtensions.blur-my-shell
      gnomeExtensions.caffeine
      gnomeExtensions.appindicator
    ];
  };

in
{
  config = if systemSettings.desktop == "gnome" then gnomeDesktop else kdeDesktop;
}
