{ config, pkgs, ... }:

{
  home.sessionVariables = {
    # Firefox uses D-Bus idle inhibition under Hypridle; force native Wayland
    # and portal integration so media playback is visible to the session.
    MOZ_ENABLE_WAYLAND = "1";
    GTK_USE_PORTAL = "1";
  };

  programs.firefox = {
    enable = true;
    # nixGL wrapper required on non-NixOS to expose host GL/EGL drivers.
    package = config.lib.nixGL.wrap pkgs.firefox;
    configPath = "${config.xdg.configHome}/mozilla/firefox";
  };
}
