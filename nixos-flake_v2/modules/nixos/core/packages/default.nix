{ pkgs, systemSettings, ... }: {
  environment.systemPackages = with pkgs; [
    freshfetch
    ### CODE
    vscode-fhs
    git
    ptyxis
    distrobox

    ### SYSTEM
    wget
    tree
    helix

    ### BROWSER
    firefox
  ];
}
