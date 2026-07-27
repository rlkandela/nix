_: {
  flake.modules.darwin.m2proHomebrew = _: {
    homebrew = {
      enable = true;
      casks = [
        "diffmerge"
        "warp"
        "qt-creator"
      ];
      brews = [
        "mas"
        "gettext"
        "jj"
        "qt6"
        "cmake"
      ];
      masApps = {
        "Yoink" = 457622435;
        "CotEditor" = 1024640650;
        "Whatsapp" = 310633997;
        "Telegram" = 747648890;
        "UTM" = 1538878817;
        "LastPass" = 6504626762;
        "StopTheScript" = 1588394487;
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
