{
  networking = {
    hostName = "laptop-system76";
    wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
  };

  systemd.network.wait-online.enable = false;
}