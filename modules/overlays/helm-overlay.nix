{inputs, ...}: {
  flake.overlays.helm = _: prev: let
    pinnedPkgs = import inputs.nixpkgs-helm {
      system = prev.stdenv.hostPlatform.system;
    };
  in {
    inherit (pinnedPkgs) kubernetes-helm;
  };
}
