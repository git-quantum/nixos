{ lib, pkgs, config, ... }:

let
  # Fonction qui vérifie si le chemin du paquet existe dans le /nix/store
  checkIfInstalled = pkgName: builtins.any (path: builtins.match ".*/${pkgName}-.*" path != null) (builtins.readDir "/nix/store");
in
{
  # Définition des options pour permettre de spécifier le nom du paquet
  options.pkgChecker.pkgName = lib.mkOption {
    type = lib.types.str;
    description = "The name of the package to check in the /nix/store.";
    example = "bash";
  };

  # Configuration des valeurs de l'option
  config = lib.mkIf (checkIfInstalled config.pkgChecker.pkgName) {
    assertions = [
      {
        assertion = true;
        message = "Package ${config.myPackageChecker.packageName} is installed in /nix/store.";
      }
    ];
  };
}
