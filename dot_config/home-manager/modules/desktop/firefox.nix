{ config, pkgs, ... }:

{
  programs.firefox = {
    enable = true;
    # nixGL wrapper required on non-NixOS to expose host GL/EGL drivers.
    package = config.lib.nixGL.wrap pkgs.firefox;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
