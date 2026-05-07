{
  self,
  ...
}:
{
  flake.modules.darwin.m4ProPkgs =
    { pkgs, ... }:
    {
      nixpkgs.overlays = [
        self.hosts.m4pro.overlays.ffmpeg-overlay
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
    };
}
