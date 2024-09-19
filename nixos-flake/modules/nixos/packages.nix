{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    freshfetch
    wget
    tree
    helix
    firefox
  ];
}
