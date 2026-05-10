{ inputs, ... }:
{
  flake.modules.darwin.m2proBrew =
    { pkgs, ... }:
    inputs.nix-homebrew.darwinModules.nix-homebrew {
      lib = pkgs.lib;
      nix-homebrew = {
        enable = true;
        # Apple Silicon Only
        enableRosetta = true;
        # User owning the Homebrew prefix
        user = "rlkandela";
        mutableTaps = false;
        autoMigrate = true;
      };
    };
}
