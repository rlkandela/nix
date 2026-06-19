_: {
  flake.modules.homeManager.m2proHomeManagerSettings = _: {
    my.neovim.enable = true;
    my.neovim.theme = {
      enable = true;
      name = "catppuccin";
      style = "frappe";
    };
  };
}
