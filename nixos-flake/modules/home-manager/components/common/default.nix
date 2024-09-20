{
    #imports = [
    #    ./dev.nix
    #    ./helix.nix
    #    ./zsh.nix
    #];
    imports = builtins.filterSource (file: builtins.baseNameOf file == ".nix") .
}