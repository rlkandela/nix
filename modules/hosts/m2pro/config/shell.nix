_: {
  flake.modules.darwin.m2proShellAliases = _: {
    programs.zsh.enable = true;

    environment.shellAliases = {
      lg = "lazygit";
      k = "kubectl -n \${K_NS:-default}";
      kdr = "kubectl -n \${K_NS:default} --dry-run=client -o yaml";
    };
  };
}
