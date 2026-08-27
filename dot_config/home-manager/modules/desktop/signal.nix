{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.host.signalDesktop.enable = lib.mkEnableOption "Signal Desktop";

  config = lib.mkIf config.host.signalDesktop.enable {
    home.packages = [ pkgs.signal-desktop ];
  };
}
