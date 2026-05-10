{ ... }:
{
  flake.modules.darwin.m2proSystem =
    { ... }:
    {
      # System settings
      security.pam.services.sudo_local.touchIdAuth = true;
      system = {
        primaryUser = "rlkandela";
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
            # persistent-apps = [];
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
        }
      };
    };
}
