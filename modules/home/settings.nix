# My own settings to build the NixOS home configurations.
{ lib, ... }:
with lib;
{
  # Some option declarations which can be used to specify
  # in `config.settings.???`
  options = {
    settings = {
      user.name = mkOption {
        description = "The default user name.";
        default = "Michael Baumann";
        type = types.str;
      };

      user.email = mkOption {
        description = "The default email of the user.";
        default = "mikebaumann@bluewin.ch";
        type = types.str;
      };
    };
  };
}
