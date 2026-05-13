{ self, ... }:
{
  flake.modules.darwin.m4proHomeManager =
    { ... }:
    {
      imports = [
        self.modules.darwin.homeManager
      ];

      my.homeManager = {
        enable = true;
        primaryUser = "raulcandelaarias";
        sharedModules = [
          self.modules.homeManager.ghosttyConfig
        ];
      };
    };
}
