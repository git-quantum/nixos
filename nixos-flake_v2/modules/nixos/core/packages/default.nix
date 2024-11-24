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

    ### DESKTOP
    (if systemSettings.desktop == "gnome" then
      gnomeExtensions.gsconnect
        gnomeExtensions.just-perfection
        gnomeExtensions.blur-my-shell
        gnomeExtensions.caffeine
        gnomeExtensions.appindicator
    else { })


    ### BROWSER
    firefox
  ];
}
