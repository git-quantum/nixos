{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    freshfetch
    git
    wget
    tree
    helix
    firefox
  ];
}
