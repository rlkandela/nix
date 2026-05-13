{ inputs, ... }:
let
  commonHmConfig =
    {
      config,
      lib,
      pkgs,
      ...
    }:
    {
      options.my.homeManager = {
        enable = lib.mkEnableOption "home-manager integrated in nix-darwin";

        primaryUser = lib.mkOption {
          type = lib.types.str;
          description = "Primary user of the host";
          example = "rlkandela";
        };

        stateVersion = lib.mkOption {
          type = lib.types.str;
          default = "25.11";
          description = "home.stateVersion of the primary user.";
        };

        sharedModules = lib.mkOption {
          type = lib.types.listOf lib.types.deferredModule;
          default = [ ];
          description = ''
            Home Manager modules that will be applied to the primary user of the host.
          '';
        };
      };

      config = lib.mkIf config.my.homeManager.enable {
        home-manager = {
          useGlobalPkgs = true;
          useUserPackages = false;
          backupFileExtension = "hm-backup";

          sharedModules = config.my.homeManager.sharedModules;

          users.${config.my.homeManager.primaryUser} = {
            home.stateVersion = config.my.homeManager.stateVersion;
          };
        };
      };
    };
in
{
  flake.modules.darwin.homeManager = {
    imports = [
      inputs.home-manager.darwinModules.home-manager
      commonHmConfig
    ];
  };

  flake.modules.nixos.homeManager = {
    imports = [
      inputs.home-manager.nixosModules.home-manager
      commonHmConfig
    ];
  };
}
