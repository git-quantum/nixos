{ pkgs, ... }:
let
  customAliases = {
    ll = "ls -l";
    la = "ls -la";
    
  };
    
  
in {
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    autosuggestions.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = customAliases;
    ohMyZsh.enable = true;
    loginShellInit = "freshfetch";
  };
  

  environment.systemPackages = with pkgs; [
    freshfetch
  ];
         
}
