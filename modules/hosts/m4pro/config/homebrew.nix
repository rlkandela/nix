{
  ...
}:
{
  flake.modules.darwin.m4proHomebrew =
    { ... }:
    {

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
          "gpg2"
          "gnupg"
          "pinentry-mac"
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
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

    };
}
