{ pkgs, lib, config, ...}:

let
    gsScriptPath = builtins.path {
      name = "gs.sh";
      path = ./../../scripts/gs.sh;
    };
    result = pkgs.runCommand "pkgChecker" {
        scriptPath = ./../../scripts/check_bin.sh;
    } ''
        # Exécuter le script et capturer l'exit code dans un fichier
        bash ${scriptPath}
        echo $? > $out
    '';
in
{
    # Lire le contenu du fichier de sortie pour obtenir l'exit code
    resultCode = builtins.readFile "${result}";

    # Copy script in target locations if Steam installed
    home.file = lib.mkIf (resultCode == 0) {
        "gs.sh" = {
            source = gsScriptPath;
            target = ".config/hm-modules/gaming/gs.sh";
            executable = true;
        };
    };


}

