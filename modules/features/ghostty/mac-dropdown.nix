_: {
  flake.modules.darwin.macGhosttyDropdown = _: {
    homebrew.casks = [
      "hammerspoon"
    ];

    launchd.user.agents.hammerspoon = {
      command = "/usr/bin/open -a Hammerspoon";

      serviceConfig = {
        RunAtLoad = true;
      };
    };
  };
  flake.modules.homeManager.macGhosttyDropdown = {pkgs, ...}: {
    home.packages = [
      (pkgs.writeShellScriptBin "ghostty-dropdown" ''
        /usr/bin/osascript <<'APPLESCRIPT'
        tell application "System Events"
          if not (exists process "Ghostty") then
            tell application "Ghostty" to activate
              
            repeat until exists process "Ghostty"
              delay 0.1
            end repeat
          end if
        end tell

        tell application "System Events"
            tell process "Ghostty"
                click menu item "Quick Terminal" of menu "View" of menu bar 1
            end tell
        end tell
        APPLESCRIPT
      '')
    ];

    home.file.".hammerspoon/init.lua".text = ''
      hs.hotkey.bind({"cmd"}, 50, function()
        hs.execute("/bin/zsh -lc 'ghostty-dropdown'")
      end)
    '';
  };
}
