{inputs, ...}: {
  flake.overlays.sqlfluff = _: prev: let
    pinnedPkgs = import inputs.nixpkgs-sqlfluff {
      system = prev.stdenv.hostPlatform.system;
    };
  in {
    inherit (pinnedPkgs) sqlfluff;
  };
}
