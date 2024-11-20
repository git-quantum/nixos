{ pkgs, ... }: {
  programs.helix = {
    enable = true;

    settings = {
      theme = "solarized_dark";
      editor = {
        line-number = "relative";
        mouse = true;
        middle-click-paste = true;
        auto-completion = true;
        color-modes = true;
        bufferline = "multiple";
        cursorline = true;
        rulers = [ 120 ];
        true-color = true;

        cursor-shape = {
          insert = "bar";
          normal = "block";
          select = "underline";
        };

        file-picker = { hidden = false; };

        indent-guides = {
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

    # LANGUAGE CONFIGURATION
    languages = {
      language = [{
        name = "nix";
        auto-format = true;
        formatter.command = "${pkgs.nixpkgs-fmt}/bin/nixpkgs-fmt";
        language-servers = [ "nil" ];
      }];

      # LSP CONFIGURATION
      language-servers = { nil.command = "${pkgs.nil}/bin/nil"; };
    };

    # NEEDED PACKAGES
    extraPackages = with pkgs; [ nil ];
  };
}
