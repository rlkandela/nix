{ inputs, ... }:
{
  flake.modules.darwin.m4proBrew =
    { pkgs, ... }:
    inputs.nix-homebrew.darwinModules.nix-homebrew {
      lib = pkgs.lib;
      nix-homebrew = {
        enable = true;
        # Apple Silicon Only
        enableRosetta = true;
        # User owning the Homebrew prefix
        user = "raulcandelaarias";
        mutableTaps = false;
        autoMigrate = true;
      };
    };
}
