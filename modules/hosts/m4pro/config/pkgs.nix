{
  self,
  inputs,
  ...
}:
{
  flake.modules.darwin.m4proPkgs =
    { pkgs, config, ... }:
    {
      nixpkgs.overlays = [
        self.overlays.ffmpeg
      ];

      environment.systemPackages = [
        pkgs.mkalias
        pkgs.neovim
        pkgs.lazygit
        pkgs.bruno
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
        pkgs.nixfmt
        pkgs.awscli2
        pkgs.ripgrep
        pkgs.minikube
        pkgs.acme-sh
        pkgs.golangci-lint
        pkgs.gh
        pkgs.commitizen
        pkgs.tmux
        pkgs.ghostty-bin
        pkgs.kubectl
        pkgs.kubernetes-helm
        pkgs.argocd
        pkgs.k9s
        pkgs.stern
        pkgs.skaffold
        pkgs.tilt
      ];

      # Allowed unfree licenses
      nixpkgs.config.allowUnfreePredicate =
        pkg:
        builtins.elem (inputs.nixpkgs.lib.getName pkg) [
          # "obsidian"
          "claude-code"
        ];

      # Make apps installed by nix appear in spotlight search
      system.activationScripts.applications.text =
        let
          env = pkgs.buildEnv {
            name = "system-applications";
            paths = config.environment.systemPackages;
            pathsToLink = [ "/Applications" ];
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

    };
}
