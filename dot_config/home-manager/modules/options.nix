{ lib, ... }:

{
  options.host = {
    wm = lib.mkOption {
      type = lib.types.enum [
        "hyprland"
        "i3"
      ];
      description = "Window manager for this host.";
    };
    gitUserName = lib.mkOption {
      type = lib.types.str;
      description = "Git user name for this host.";
    };
    gitUserEmail = lib.mkOption {
      type = lib.types.str;
      description = "Git email for this host.";
    };
  };
}
