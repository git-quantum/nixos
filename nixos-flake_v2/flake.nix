{
  description = "Hoaq's custom flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows =
      "nixpkgs"; # Override nixpkgs input from HM Flakes, to be sync with our nixpkgs defined above
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      ########## SYSTEM
      systemSettings = rec {
        nixosVersion = "2411";
        system = "x86_64-linux";
        hostname = "hortus";
        profile = "laptop-system76"; # A profile defined from the profile directory
        profilePath = ./profiles/${profile};
        gpuType = "nvidia"; # Choose weither "amd" or "nvidia"
        systemModulesPath = ./modules/nixos;
        desktop = "gnome"; # A desktop defined from the desktop directory

      };

      ########### USER
      userSettings = rec {
        username = "hoaq";
        mail = "";
        dotfilesDir = /home/${username}/.config;
        theme = "Solarized_Dark";
        font = "";
        shell = "bash";
        editor = "helix";
        userModulesPath = ./modules/home-manager/configuration;
        wm = "";
      };

      pkgs =
        nixpkgs.legacyPackages.${systemSettings.system}; # Mandatory argument now: https://nix-community.github.io/home-manager/release-notes.xhtml#sec-release-22.11-highlights
      lib = nixpkgs.lib;

    in
    {

      systemHostname = systemSettings.hostname;

      # Nixos system    
      nixosConfigurations = {
        ${systemSettings.hostname} = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            # "${systemSettings.profilePath}/configuration.nix" 
            (systemSettings.profilePath + /configuration.nix)
          ];

          specialArgs = {
            inherit inputs;
            inherit systemSettings;
            inherit userSettings;
          };
        };
      };

      # Home-manager
      homeConfigurations = {
        ${userSettings.username} =
          inputs.home-manager.lib.homeManagerConfiguration {
            inherit pkgs;
            modules = [
              (systemSettings.profilePath + /home.nix)
            ];

            extraSpecialArgs = {
              inherit inputs;
              inherit systemSettings;
              inherit userSettings;
            };
          };
      };
    };
}
