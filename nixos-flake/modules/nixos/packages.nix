{pkgs, ...}: {
  environment.systemPackage = with pkgs; {
    freshfetch
    wget
    tree
    helix
    firefox
    
  };
}
