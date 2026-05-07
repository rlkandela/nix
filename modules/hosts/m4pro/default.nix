{ self, inputs, ... }:
{
  flake.darwinConfigurations."m4pro" = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      self.modules.darwin.m4proConfig
      self.modules.darwin.m4proBrew
    ];
  };
}
