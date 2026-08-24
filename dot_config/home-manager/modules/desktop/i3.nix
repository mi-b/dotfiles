{ config, lib, pkgs, ... }:

{
  home.packages = lib.mkIf (config.host.wm == "i3") (with pkgs; [
    polybar
    i3status
    feh
    xautolock
    maim
  ]);
}
