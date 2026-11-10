_: {
  flake.modules.homeManager.ghosttyConfig = {pkgs, ...}: {
    programs.ghostty = {
      enable = true;

      package =
        if pkgs.stdenv.hostPlatform.isDarwin
        then pkgs.ghostty-bin
        else pkgs.ghostty;

      # As we cannot build the package, these must be set to false
      installVimSyntax = false;
      installBatSyntax = false;

      enableZshIntegration = true;
      clearDefaultKeybinds = false;

      settings = {
        # Fonts
        font-size = 18;

        # Theme
        theme = "Catppuccin Frappe";

        # Shell
        shell-integration = "detect";
        shell-integration-features = "cursor,sudo,title";

        # Quick Terminal (Quake-Style)
        quick-terminal-position = "top";
        quick-terminal-size = "50%";
        quick-terminal-animation-duration = 0.15;
        quick-terminal-autohide = false;
        quick-terminal-space-behavior = "move";
        quick-terminal-screen = "mouse";

        # Applescript
        macos-applescript = true;
      };
    };
  };
}
