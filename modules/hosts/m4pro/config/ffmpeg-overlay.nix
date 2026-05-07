{ inputs, ... }:
{
  flake.modules.darwin.ffmpeg-overlay =
    final: prev:
    let
      pinnedPkgs = import inputs.nixpkgs-ffmpeg {
        system = prev.stdenv.hostPlatform.system;
      };
    in
    {
      ffmpeg-full = pinnedPkgs.ffmpeg-full;
    };
}
