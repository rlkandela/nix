{ ... }:
{
  flake.modules.darwin.m2proHomebrew =
    { ... }:
    {
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
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };
    };
}
