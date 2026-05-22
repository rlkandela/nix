{inputs, ...}: {
  flake.overlays.ffmpeg = _: prev: let
    pinnedPkgs = import inputs.nixpkgs-ffmpeg {
      system = prev.stdenv.hostPlatform.system;
    };
  in {
    inherit (pinnedPkgs) ffmpeg-full;
  };
}
