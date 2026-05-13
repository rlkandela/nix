{ ... }:
{
  flake.modules.homeManager.ghosttyConfig =
    { pkgs, ... }:
    {
      programs.ghostty = {
        enable = true;

        package = if pkgs.stdenv.hostPlatform.isDarwin then pkgs.ghostty-bin else pkgs.ghostty;

        # As we cannot build the package, these must be set to false
        installVimSyntax = false;
        installBatSyntax = false;

        enableZshIntegration = true;
        clearDefaultKeybinds = false;

        settings = {
          # Fonts
          font-size = 18;

          # Theme
          theme = "Catppuccin Mocha";

          # Shell
          shell-integration = "detect";
          shell-integration-features = "cursor,sudo,title";
        };
      };
    };
}
