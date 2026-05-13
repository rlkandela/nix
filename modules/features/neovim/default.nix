{ self, inputs, ... }:
{
  flake.modules.homeManager.neovim =
    { config, lib, ... }:
    {
      imports = [
        inputs.nvf.homeManagerModules.default
        self.modules.homeManager.neovimConfig
      ];

      options.my.neovim = {
        enable = lib.mkEnableOption "neovim custom config";
      };

      config = lib.mkIf config.my.neovim.enable {
        programs.nvf.enable = true;
      };
    };
}
