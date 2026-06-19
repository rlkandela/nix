_: {
  flake.modules.homeManager.m4proHomeManagerSettings = _: {
    my.neovim.enable = true;
    my.neovim.theme = {
      enable = true;
      name = "catppuccin";
      style = "frappe";
    };
  };
}
