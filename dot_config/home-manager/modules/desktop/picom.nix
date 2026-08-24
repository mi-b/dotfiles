{ config, lib, ... }:

{
  services.picom = lib.mkIf (config.host.wm == "i3") {
    enable = true;
    backend = "xrender";
    vSync = false;
    shadow = true;
    shadowOffsets = [ (-6) (-6) ];
    shadowOpacity = 0.75;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Polybar'"
      "class_g = 'i3-frame'"
      "_GTK_FRAME_EXTENTS@:c"
    ];
    fade = false;
    inactiveOpacity = 1.0;
    activeOpacity = 1.0;
    settings = {
      shadow-radius = 6;
      shadow-color = "#1e1e2e";
      frame-opacity = 1.0;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      use-damage = true;
      wintypes = {
        tooltip = { shadow = false; };
        dock = { shadow = false; };
        dnd = { shadow = false; };
        popup_menu = { shadow = true; };
        dropdown_menu = { shadow = true; };
      };
    };
  };
}
