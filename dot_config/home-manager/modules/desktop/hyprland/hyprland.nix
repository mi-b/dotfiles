{
  config,
  lib,
  pkgs,
  ...
}:

{
  home.packages = lib.mkIf (config.host.wm == "hyprland") (
    with pkgs;
    [
      waybar
      swaybg
      grim
      slurp
      wl-clipboard
      hypridle
      bluetuith
    ]
  );
}
