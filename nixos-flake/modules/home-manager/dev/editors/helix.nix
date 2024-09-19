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
      
      cursor-shape = {
        insert = "bar";
        normal = "block";
        select = "underline";
      };
      
      file-picker = {
        hidden = false;
      };
      
    };
    
  };
  
}
