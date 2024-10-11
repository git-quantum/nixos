{
  description = "Quantum's custom flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";

    home-manager.url = "github:nix-community/home-manager/master";
    home-manager.inputs.nixpkgs.follows =
      "nixpkgs"; # Override nixpkgs input from HM Flakes, to be sync with our nixpkgs defined above

    nixos-cosmic = {
      url = "github:lilyinstarlight/nixos-cosmic";
      inputs.nixpkgs.follows = "nixpkgs";
    };
  };

  outputs = { self, nixpkgs, ... }@inputs:
    let
      ########## SYSTEM
      systemSettings = {
        system = "x86_64-linux";
        hostname = "hortus";
        profile = "laptop-system76"; # A profile defined from the profile directory
        profilePath = "" + ${profile};
        gpuType = "nvidia"; # Choose weither "amd" or "nvidia"

      };

      ########### USER
      userSettings = {
        username = "quantum";
        mail = "quentinhr@pm.me";
        dotfilesDir = "~/.config";
        theme = "";
        font = "";
        editor = "";
        userModulesPath = ../../../modules/home-manager/configuration;
        systemModulesPath = ../../../modules/nixos;
        wm = "";
        desktop = "cosmic"; # A desktop defined from the desktop directory
      };


      pkgs =
        nixpkgs.legacyPackages.${system}; # Mandatory argument now: https://nix-community.github.io/home-manager/release-notes.xhtml#sec-release-22.11-highlights
      lib = nixpkgs.lib;

    in {
      # Nixos system    
      nixosConfigurations = {
        ${systemSettings.profile} = lib.nixosSystem {
          system = userSettings.system;
          
          modules = [
            ./hosts/laptops/system76/configuration.nix

            inputs.nixos-cosmic.nixosModules.default
            
            nix.settings {
              substituters = [ "https://cosmic.cachix.org/" ];
              trusted-public-keys = [
                "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
              ];
            }
          ];
          
          specialArgs = {
            profile = "laptop-system76";
            inherit inputs nixosModulesPath;
            inherit systemSettings;
            inherit userSettings;

          };
        };
      };

      # Home-manager
      homeConfigurations = {
        ${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/laptops/system76/home.nix ];
        };
      };
    };

}
