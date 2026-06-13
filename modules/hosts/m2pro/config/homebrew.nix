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
        "PowerPoint" = 462062816;
        "CotEditor" = 1024640650;
        "Whatsapp" = 310633997;
        "Telegram" = 747648890;
      };
      onActivation = {
        # Using ZAP requires to use --force
        cleanup = "zap";
        extraFlags = ["--force"];
        autoUpdate = true;
        upgrade = true;
      };
    };
  };
}
