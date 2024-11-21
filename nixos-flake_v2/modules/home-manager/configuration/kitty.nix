{ pkgs, userSettings, ... }: {

  programs.kitty = {
    enable = true;
    shellIntegration.enableBashIntegration = (userSettings.shell == "bash");
    shellIntegration.enableZshIntegration = (userSettings.shell == "zsh");
    themeFile = userSettings.theme;

    settings = {
      confirm_os_window_close = 0;
      window_padding_width = 10;
      scrollback_lines = 10000;
      enable_audio_bell = false;
      mouse_hide_wait = 60;
    };
  };
}
