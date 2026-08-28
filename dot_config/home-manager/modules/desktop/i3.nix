{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = lib.mkIf (config.host.wm == "i3") (
    with pkgs;
    [
      i3
      i3lock
      polybar
      i3status
      feh
      xautolock
      maim
    ]
  );
}
