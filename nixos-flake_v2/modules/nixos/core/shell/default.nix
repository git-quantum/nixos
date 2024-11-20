{ pkgs, userSettings, ... }:
{
  # Set shell by default
  environment.shells = with pkgs; [ bashInteractive zsh ];
  users.defaultUserShell = with pkgs;if userSettings.shell != "bash" then zsh else bash;
}
