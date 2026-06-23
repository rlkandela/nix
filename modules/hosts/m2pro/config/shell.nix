_: {
  flake.modules.darwin.m2proShellAliases = _: {
    programs.zsh.enable = true;

    environment.shellAliases = {
      lg = "lazygit";
      k = "kubectl";
    };
  };
}
