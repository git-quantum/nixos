{ pkgs, userSettings, ... }:
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
      echo "Zsh version"
    '';
  };

  programs.bash = {
    enable = if userSettings.shell == "bash" then true else false;
    enableCompletion = true;
    # enableVteIntegration = true;
    historyControl = [ "erasedups" ];
    historyFile = "~/.bash_history";
    historySize = 1000;
    shellAliases = customAliases;
    initExtra = ''
      # Personnalisation du prompt avec Solarized Dark
      PS1='\[\e[38;5;73;1m\]\t\[\e[0m\] \[\e[38;5;102m\]-\[\e[0m\] \[\e[38;5;166;1m\]@\H\[\e[0;38;5;102m\]:\[\e[38;5;161;1m\]\w\[\e[0m\] \[\e[38;5;178;1;2m\]($(git branch --show-current 2>/dev/null))\[\e[0m\] \[\e[38;5;102m\]___________\[\e[0m\] \[\e[38;5;106m\][\[\e[1;2m\]$?\[\e[22m\]]\a\n\[\e[38;5;102;1;2m\]\u\[\e[0m\] \[\e[38;5;196;1m\]\$\[\e[0m\] \[\e[38;5;104;1;5m\]>\[\e[0m\] '
      # PS1='\[\e[38;5;73;1m\]\t\[\e[0m\] \[\e[38;5;102m\]-\[\e[0m\] \[\e[38;5;166;1m\]@\H\[\e[0;38;5;102m\]:\[\e[38;5;161;1m\]\w\[\e[38;5;178;2m\]$(__git_ps1 " (%s)")\[\e[0m\] \[\e[38;5;102m\]___________\[\e[0m\] \[\e[38;5;106m\][\[\e[1;2m\]$?\[\e[22m\]]\a\n\[\e[38;5;196;1m\]\$\[\e[38;5;102;2m\]\u\[\e[0m\] \[\e[38;5;104;1;5m\]>\[\e[0m\] '

      freshfetch
      echo "Bash version"
    '';
  };

}
