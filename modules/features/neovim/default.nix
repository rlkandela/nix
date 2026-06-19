{
  self,
  inputs,
  ...
}: let
  inherit (self.lib) mkNvimSettings;
  defaultTheme = {
    enable = true;
    name = "catppuccin";
    style = "frappe";
    transparent = false;
  };
in {
  flake.modules.homeManager.neovim = {
    config,
    lib,
    pkgs,
    ...
  }: {
    imports = [
      inputs.nvf.homeManagerModules.default
    ];

    options.my.neovim = {
      enable = lib.mkEnableOption "neovim custom config";
      theme = {
        enable = lib.mkEnableOption "neovim theme";

        name = lib.mkOption {
          type = lib.types.str;
          default = "onedark";
          description = "Theme name";
        };

        style = lib.mkOption {
          type = lib.types.nullOr lib.types.str;
          default = null;
          description = "Theme variant. May be null";
        };

        transparent = lib.mkOption {
          type = lib.types.bool;
          default = false;
          description = "Transparent background";
        };
      };
    };

    config = lib.mkIf config.my.neovim.enable {
      programs.nvf = {
        enable = true;
        settings.vim = mkNvimSettings {
          inherit lib pkgs;
          theme = config.my.neovim.theme;
        };
      };
    };
  };

  perSystem = {
    pkgs,
    lib,
    ...
  }: {
    packages.nvim =
      (inputs.nvf.lib.neovimConfiguration {
        inherit pkgs;
        modules = [
          {
            vim = mkNvimSettings {
              inherit pkgs;
              inherit lib;
              theme = defaultTheme;
            };
          }
        ];
      }).neovim;
  };
}
