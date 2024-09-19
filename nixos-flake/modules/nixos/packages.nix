{pkgs, ...}: {
  environment.systemPackages = with pkgs; [
    freshfetch
    vscode-fhs
    git
    wget
    tree
    helix
    firefox
  ];
}
