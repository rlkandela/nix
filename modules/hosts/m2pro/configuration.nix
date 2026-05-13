{ self, ... }:
{
  flake.modules.darwin.m2proConfig =
    { pkgs, lib, ... }:
    {
      imports = [
        self.modules.darwin.m2proPkgs
        self.modules.darwin.m2proSystem
        self.modules.darwin.m2proHomebrew
        self.modules.darwin.m2proHomeManager
        self.modules.darwin.appsInSpotlight
      ];

      nix.settings.experimental-features = [
        "nix-command"
        "flakes"
      ];

      # System user
      users.users.rlkandela = {
        name = "rlkandela";
        home = "/Users/rlkandela";
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
