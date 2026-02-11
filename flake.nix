{
  description = "Example nix-darwin system flake";

  inputs = {
    nixpkgs.url = "github:NixOS/nixpkgs/nixpkgs-unstable";
    nix-darwin.url = "github:LnL7/nix-darwin/master";
    nix-darwin.inputs.nixpkgs.follows = "nixpkgs";
    nix-homebrew.url = "github:zhaofengli-wip/nix-homebrew";
  };

  outputs = inputs@{ self, nix-darwin, nixpkgs, nix-homebrew }:
    let
    # lazygit-overlay = final: prev: {
    #   lazygit = prev.lazygit.overrideAttrs (old: rec {
    #     version = "unstable-2025-11-12";
    #     src = prev.fetchFromGitHub {
    #       owner = "jesseduffield";
    #       repo = "lazygit";
    #       rev = "a7126d54569deae322e1bd6a8930e518912d6b3f";
    #       sha256 = "sha256-23wX518lu4kplGXToazuUfLS30G+onRsEIpsbcLc7vo=";
    #     };
    #   });
    # };



    configuration = { pkgs, config, ... }: {
# List packages installed in system profile. To search by name, run:
# $ nix-env -qaP | grep wget
      nixpkgs.overlays =
        [
          # lazygit-overlay
        ];
      environment.systemPackages =
        [
          pkgs.mkalias
          pkgs.neovim
          pkgs.lazygit
          pkgs.nerd-fonts.jetbrains-mono
          pkgs.pyenv
          pkgs.nodejs_24
          pkgs.bun
          pkgs.claude-code
          pkgs.opencode
          pkgs.tokei
          pkgs.yq-go
          pkgs.difftastic
          pkgs.ffmpeg-full
          pkgs.awscli2
          pkgs.ripgrep
          pkgs.minikube
          pkgs.acme-sh
          pkgs.gh
          pkgs.commitizen
          pkgs.tmux
          pkgs.ghostty-bin
          pkgs.kubectl
          pkgs.kubernetes-helm
          pkgs.k9s
          pkgs.skaffold
          pkgs.tilt
        ];

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
        ];
        masApps = {
# "AppName" = <app id>;
        };
        onActivation.cleanup = "zap";
        onActivation.autoUpdate = true;
        onActivation.upgrade = true;
      };

# Allowed unfree licenses
      nixpkgs.config.allowUnfreePredicate = pkg: builtins.elem (nixpkgs.lib.getName pkg) [
# "obsidian"
        "claude-code"
      ];

# Make apps installed by nix appear in spotlight search
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
          name = "system-applications";
          paths = config.environment.systemPackages;
          pathsToLink = ["/Applications"];
        };
      in
        pkgs.lib.mkForce ''
# Set up applications
        echo "setting up /Applications..." >&2
        rm -rf /Applications/Nix\ Apps
        mkdir -p /Applications/Nix\ Apps
        find ${env}/Applications -maxdepth 1 -type l -exec readlink '{}' + |
        while read -r src; do
          app_name=$(basename "$src")
            echo "copying $src" >&2
            ${pkgs.mkalias}/bin/mkalias "$src" "/Applications/Nix Apps/$app_name"
            done
            '';


# Necessary for using flakes on this system.
      nix.settings.experimental-features = "nix-command flakes";

# Enable alternative shell support in nix-darwin.
# programs.fish.enable = true;

# Set Git commit hash for darwin-version.
      system.configurationRevision = self.rev or self.dirtyRev or null;

# Used for backwards compatibility, please read the changelog before changing.
# $ darwin-rebuild changelog
      system.stateVersion = 6;

# The platform the configuration will be used on.
      nixpkgs.hostPlatform = "aarch64-darwin";

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
                "/Users/raulcandelaarias/Applications/Clash Ninja.app"
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

# Nix Homebrew
  nix-brew = { pkgs, ... }: nix-homebrew.darwinModules.nix-homebrew
  {
    lib = pkgs.lib;
    nix-homebrew = {
      enable = true;
# Apple Silicon Only
      enableRosetta = true;
# User owning the Homebrew prefix
      user = "raulcandelaarias";
      mutableTaps = false;
      autoMigrate = true;
    };
  };
  in
  {
# Build darwin flake using:
# $ darwin-rebuild build --flake .#m4pro
    darwinConfigurations."m4pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
        nix-brew
      ];
    };
  };
}
