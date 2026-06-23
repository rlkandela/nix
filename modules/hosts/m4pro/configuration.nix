{self, ...}: {
  flake.modules.darwin.m4proConfig = _: {
    imports = [
      self.modules.darwin.m4proPkgs
      self.modules.darwin.m4proSystem
      self.modules.darwin.m4proHomebrew
      self.modules.darwin.m4proHomeManager
      self.modules.darwin.m4proShellAliases
      self.modules.darwin.appsInSpotlight
    ];

    nix.settings.experimental-features = [
      "nix-command"
      "flakes"
    ];

    # System user
    users.users.raulcandelaarias = {
      name = "raulcandelaarias";
      home = "/Users/raulcandelaarias";
    };

    # Set Git commit hash for darwin-version.
    system.configurationRevision = self.rev or self.dirtyRev or null;

    # Used for backwards compatibility, please read the changelog before changing.
    # $ darwin-rebuild changelog
    system.stateVersion = 6;

    # The platform the configuration will be used on.
    nixpkgs.hostPlatform = "aarch64-darwin";
  };
}
