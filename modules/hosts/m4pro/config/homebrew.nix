_: {
  flake.modules.darwin.m4proHomebrew = _: {
    homebrew = {
      enable = true;
      casks = [
        "arc"
        "vlc"
        "the-unarchiver"
        "iina"
        "hammerspoon"
        "iterm2"
        "obsidian"
        "hiddenbar"
        "openvpn-connect"
        "github"
        "warp"
      ];
      brews = [
        "nvm"
        "wireshark"
        "readline"
        "xz"
        "jj"
        "kind"
        "qemu"
        "watch"
        "luarocks"
      ];
      masApps = {
        # "AppName" = <app id>;
      };
      onActivation = {
        # Using ZAP no longer requires to use --force
        cleanup = "zap";
        # extraFlags = ["--force"];
        autoUpdate = true;
        upgrade = true;
      };
    };
  };
}
