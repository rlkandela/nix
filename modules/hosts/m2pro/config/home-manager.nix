{ self, ... }:
{
  flake.modules.darwin.m2proHomeManager =
    { ... }:
    {
      imports = [
        self.modules.darwin.homeManager
      ];

      my.homeManager = {
        enable = true;
        primaryUser = "rlkandela";
        sharedModules = [
          self.modules.homeManager.ghosttyConfig
        ];
      };
    };
}

