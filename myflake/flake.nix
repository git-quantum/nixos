{
  description = "Quantum's custom flake";

  inputs = {
    nixpkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home-manager.url = "github:nix-community/home-manager/master"
    home-manager.inputs.nixpkgs.follows = "nixpkgs"; # Override nixpkgs input from HM Flakes, to be sync with our nixpkgs defined above
  };

  outputs = { self, nixpkgs, ... }@inputs:
  let
    system = "x86_64-linux";
    pkgs = nixpkgs.legacyPackages.${system}; # Mandatory argument now: https://nix-community.github.io/home-manager/release-notes.xhtml#sec-release-22.11-highlights
    lib = nixpkgs.lib;
    
  in
  {
    # Nixos system    
    nixosConfiguration = {
      system76-laptop = {
        lib.nixosSystem = {
          inherit system ;
          modules = [ ./configuration.nix ];
        };
      };
    };

    # Home-manager
    homemanager.Configurations = {
      quantum = home-manager.lib.homeManagerConfiguration {
        inherit pkgs;
        modules = [ ./home.nix ];
      };
    };
  };

}
 
