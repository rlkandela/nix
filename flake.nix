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
    configuration = { pkgs, config, ... }: {
      # List packages installed in system profile. To search by name, run:
      # $ nix-env -qaP | grep wget
      environment.systemPackages =
        [
	  pkgs.mkalias
          pkgs.neovim
	  pkgs.nerd-fonts.jetbrains-mono
        ];

	homebrew = {
	  enable = true;
	  casks = [
            "arc"
	    "the-unarchiver"
	    "iina"
	    "hammerspoon"
	    "iterm2"
	    "obsidian"
	    "hiddenbar"
	  ];
	  brews = [
	    "gpg2"
	    "gnupg"
	    "pinentry-mac"
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
        ];

      # Make apps installed by nix appear in spotlight search
      system.activationScripts.applications.text = let
        env = pkgs.buildEnv {
	  name = "system-applications";
	  paths = config.environment.systemPackages;
	  pathsToLink = "/Applications";
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
          };
	  dock = {
	    minimize-to-application = true;
	    mru-spaces = false;
	    show-recents = false;
	    persistent-apps = [
              "/System/Applications/System Settings.app"
              "/System/Cryptexes/App/System/Applications/Safari.app"
	      "/Applications/Arc.app"
	      "/Applications/iTerm.app"
	      "/Applications/Docker.app"
	      "/Applications/Visual Studio Code.app"
	      "/Applications/Obsidian.app"
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
  in
  {
    # Build darwin flake using:
    # $ darwin-rebuild build --flake .#m4pro
    darwinConfigurations."m4pro" = nix-darwin.lib.darwinSystem {
      modules = [
        configuration
	nix-homebrew.darwinModules.nix-homebrew
	{
	  nix-homebrew = {
	    enable = true;
	    enableRosetta = true;
            user = "raulcandelaarias";
	  };
	}
      ];
    };
  };
}
