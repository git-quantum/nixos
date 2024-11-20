{ userSettings, ... }:
let
  customAliases = {
    ll = "ls -l";
    la = "ls -la";
    test = "echo 'test zsh ?'";

  };

in
{
  programs.zsh = {
    enable = if userSettings.shell == "zsh" then true else false;
    enableCompletion = true;
    autosuggestion.enable = true;
    syntaxHighlighting.enable = true;
    shellAliases = customAliases;
    dotDir = ".config/zsh";
    initExtra = ''
      PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
      %F{green}→%f "
      RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
      [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '
      freshfetch
    '';
  };

  programs.bash = {
    enable = if userSettings.shell == "bash" then true else false;
    enableCompletion = true;
    enableVteIntegration = true;
    historyControl = [ "erasedups" ];
    historyFile = "~/.bash_history";
    historySize = 1000;
    shellAliases = customAliases;
    initExtra = ''
      PROMPT=" ◉ %U%F{magenta}%n%f%u@%U%F{blue}%m%f%u:%F{yellow}%~%f
      %F{green}→%f "
      RPROMPT="%F{red}▂%f%F{yellow}▄%f%F{green}▆%f%F{cyan}█%f%F{blue}▆%f%F{magenta}▄%f%F{white}▂%f"
      [ $TERM = "dumb" ] && unsetopt zle && PS1='$ '

      freshfetch
    '';
  };

}
