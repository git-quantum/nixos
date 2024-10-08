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
      system = "x86_64-linux";
      pkgs =
        nixpkgs.legacyPackages.${system}; # Mandatory argument now: https://nix-community.github.io/home-manager/release-notes.xhtml#sec-release-22.11-highlights
      lib = nixpkgs.lib;

    in {
      # Nixos system    
      nixosConfigurations = {
        laptop-system76 = lib.nixosSystem {
          inherit system;
          modules = [
            {
              nix.settings = {
                substituters = [ "https://cosmic.cachix.org/" ];
                trusted-public-keys = [
                  "cosmic.cachix.org-1:Dya9IyXD4xdBehWjrkPv6rtxpmMdRel02smYzA85dPE="
                ];
              };
            }
            inputs.nixos-cosmic.nixosModules.default
            ./hosts/laptops/system76/configuration.nix
          ];
        };
      };

      # Home-manager
      homeConfigurations = {
        quantum = inputs.home-manager.lib.homeManagerConfiguration {
          inherit pkgs;
          modules = [ ./hosts/laptops/system76/home.nix ];
        };
      };
    };

}
