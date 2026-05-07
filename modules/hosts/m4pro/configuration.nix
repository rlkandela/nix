{ self, ... }:
{

  flake.modules.darwin.m4proConfig =
    { pkgs, lib, ... }:
    {
      imports = [
        self.modules.darwin.m4ProPkgs
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];
    };
}
