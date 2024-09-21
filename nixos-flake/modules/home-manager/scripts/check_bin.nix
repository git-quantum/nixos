{ config, pkgs, lib, ... }:

let

  # Add script's location to Nixos managed paths
  gsScriptPath = builtins.path {
    name = "gs.sh";
    path = ./gs.sh;
  };

  # Définir le paquet que tu veux vérifier
  checkIfInstalled = { pkgName, availablePkgs }:
    lib.elem (pkgs."${pkgName}") availablePkgs;

in {
  options.pkgChecker.pkgName = lib.mkOption {
    type = lib.types.str;
    description = ''
      Vérifie si le paquet spécifié est installé dans le système.
    '';
    default = "";
  };

  config = lib.mkIf (config.pkgChecker.pkgName != "") {
    assertions = [{
      assertion = checkIfInstalled {
        pkgName = config.pkgChecker.pkgName;
        availablePkgs = config.environment.systemPackages;
      };
      message = "Le paquet ${config.checkIfInstalled} est installé.";
    }];

    home.file = {
      "gs.sh" = {
        source = gsScriptPath;
        target = ".config/hm-modules/gaming/gs.sh";
        executable = true;
      };
    };
  };
}
