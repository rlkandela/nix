{ self, inputs, ... }:
{
  flake.darwinConfigurations."m2pro" = inputs.nix-darwin.lib.darwinSystem {
    modules = [
      self.modules.darwin.m2proConfig
      self.modules.darwin.m2proBrew
    ];
  };
}
