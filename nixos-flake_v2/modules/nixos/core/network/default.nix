{
  networking = {
    hostName = "laptop-system76";
    wireless.enable = true;  # Enables wireless support via wpa_supplicant.
    networkmanager.enable = true;
  };

  boot.initrd.systemd.network.wait-online.enable = false;
}
