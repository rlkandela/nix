{
  ...
}:
{
  flake.modules.darwin.m4proSystem =
    { ... }:
    {
      # System settings
      security.pam.services.sudo_local.touchIdAuth = true;
      system = {
        primaryUser = "raulcandelaarias";
        keyboard = {
          enableKeyMapping = true;
          remapCapsLockToEscape = true;
        };
        defaults = {
          controlcenter = {
            BatteryShowPercentage = true;
          };
          trackpad = {
            Clicking = true;
            Dragging = true;
          };
          NSGlobalDomain = {
            "com.apple.mouse.tapBehavior" = 1;
            "com.apple.keyboard.fnState" = false;
            ApplePressAndHoldEnabled = false;
          };
          dock = {
            autohide = true;
            autohide-delay = 0.1;
            minimize-to-application = false;
            mru-spaces = false;
            show-recents = false;
            persistent-apps = [
              "/System/Applications/System Settings.app"
              "/System/Cryptexes/App/System/Applications/Safari.app"
              # "/Applications/Microsoft Outlook.app"
              "/Applications/Arc.app"
              "/Applications/Nix Apps/Ghostty.app"
              "/Applications/Docker.app"
              "/Applications/Visual Studio Code.app"
              "/Applications/Spotify.app"
              "/Applications/Obsidian.app"
              "/Users/raulcandelaarias/Applications/Excalidraw.app"
              "/Users/raulcandelaarias/Applications/To Do.app"
            ];
          };
          finder = {
            _FXShowPosixPathInTitle = false;
            _FXSortFoldersFirst = true;
            AppleShowAllExtensions = true;
            AppleShowAllFiles = true;
            FXEnableExtensionChangeWarning = true;
            FXPreferredViewStyle = "clmv";
            NewWindowTarget = "Home";
            ShowPathbar = true;
            ShowExternalHardDrivesOnDesktop = true;
            ShowMountedServersOnDesktop = true;
            ShowRemovableMediaOnDesktop = true;
          };
        };
      };
    };
}
