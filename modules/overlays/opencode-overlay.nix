{inputs, ...}: {
  flake.overlays.opencode = _: prev: let
    pinnedPkgs = import inputs.nixpkgs-opencode {
      system = prev.stdenv.hostPlatform.system;
    };
  in {
    inherit (pinnedPkgs) opencode;
  };
}
