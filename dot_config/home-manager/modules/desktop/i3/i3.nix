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
      (polybar.override { i3Support = true; })
      i3status
      feh
      xautolock
      maim
    ]
  );
}
