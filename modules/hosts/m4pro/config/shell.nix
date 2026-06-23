_: {
  flake.modules.darwin.m4proShellAliases = _: {
    programs.zsh.enable = true;

    environment.shellAliases = {
      lg = "lazygit";
      k = "kubectl";
    };
  };
}
