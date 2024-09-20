{
  programs.helix.enable = true;
  
  programs.helix.settings = {
    theme = "catppuccin_mocha";
    editor = {
      line-number = "relative";
      mouse = true;
      middle-click-paste = true;
      auto-completion = true;
      color-modes = true;
      bufferline = "multiple";
      cursorline = true;
      rulers = [120];
      true-color = true;
      #end-of-line-diagnostics = "hint";
      
      #inline-diagnostics = {
      #  cursor-line = "warning"; # show warnings and errors on the cursorline inline
      #};
      
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      
      file-picker = {
        hidden = false;
      };

      ident-guides = {
        character = "╎";
        render = true;
      };

      lsp = {
        # Disable automatically popups of signature parameter help
        auto-signature-help = false;
        # Show LSP messages in the status line
        display-messages = true;
      };

      statusline = {
        left = [ "mode" "spinner" "version-control" "file-name" ];
      };
    };  
  };
}
