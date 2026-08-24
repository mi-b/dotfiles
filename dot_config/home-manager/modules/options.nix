{ lib, ... }:

{
  options.host = {
    wm = lib.mkOption {
      type = lib.types.enum [ "hyprland" "i3" "none" ];
      description = "Window manager for this host.";
    };
    workspace = lib.mkOption {
      type = lib.types.enum [ "private" "work" ];
      description = "Whether this is a work or private machine.";
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
