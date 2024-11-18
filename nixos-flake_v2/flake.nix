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
        nixosVersion = "2405";
        system = "x86_64-linux";
        hostname = "hortus";
        profile = "laptop-system76"; # A profile defined from the profile directory
        profilePath = ./profiles/${profile};
        gpuType = "nvidia"; # Choose weither "amd" or "nvidia"
        systemModulesPath = ./modules/nixos;

      };

      ########### USER
      userSettings = rec {
        username = "hoaq";
        mail = "quentinhr@pm.me";
        dotfilesDir = /home/${username}/.config;
        theme = "";
        font = "";
        editor = "";
        userModulesPath = ./modules/home-manager/configuration;
        wm = "";
        desktop = "kdew"; # A desktop defined from the desktop directory
      };


      pkgs =
        nixpkgs.legacyPackages.${systemSettings.system}; # Mandatory argument now: https://nix-community.github.io/home-manager/release-notes.xhtml#sec-release-22.11-highlights
      lib = nixpkgs.lib;

    in {
      
      systemHostname = systemSettings.hostname;

      # Nixos system    
      nixosConfigurations = {
        ${systemSettings.hostname} = lib.nixosSystem {
          system = systemSettings.system;
          modules = [
            #./hosts/laptops/system76/configuration.nix
            #./profiles/${systemSettings.profile}/configuration.nix
            "${systemSettings.profilePath}/configuration.nix"
            # Debug profilePath pour s'assurer qu'il est relatif
            #(builtins.trace "Importing configuration from: '${systemSettings.profilePath}/configuration.nix'"
            #import "${systemSettings.profilePath}/configuration.nix")
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
        ${userSettings.username} = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ 
	          # ./hosts/laptops/system76/home.nix 
            "${systemSettings.profilePath}/home.nix"
	        ];
        };
      };
    };
}
