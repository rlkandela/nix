{inputs, ...}: {
  flake.modules.darwin.m2proPkgs = {pkgs, ...}: {
    nixpkgs.overlays = [
      # self.overlays.ffmpeg
      # self.overlays.helm
    ];

    environment.systemPackages = [
      pkgs.nixfmt
      pkgs.fzf
      pkgs.isort
      pkgs.alacritty
      pkgs.mkalias
      pkgs.neovim
      pkgs.pnpm
      pkgs.nodejs_22
      pkgs.ripgrep
      pkgs.tmux
      pkgs.lazygit
      pkgs.ghostty-bin
      pkgs.pyenv
      pkgs.gnupg
      pkgs.pinentry_mac
      pkgs.step-cli
      pkgs.inetutils
      pkgs.dotnet-sdk_8
      pkgs.go
      pkgs.delve
      pkgs.iperf3
      pkgs.nerd-fonts.jetbrains-mono
      pkgs.toybox
      pkgs.kubernetes-helm
      pkgs.k3d
      pkgs.claude-code
      pkgs.opencode
    ];

    # Allowed unfree licenses
    nixpkgs.config.allowUnfreePredicate = pkg:
      builtins.elem (inputs.nixpkgs.lib.getName pkg) [
        "claude-code"
      ];
  };
}
