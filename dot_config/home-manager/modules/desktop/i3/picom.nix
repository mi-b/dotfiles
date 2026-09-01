{ config, lib, ... }:

{
  services.picom = lib.mkIf (config.host.wm == "i3") {
    enable = true;
    backend = "xrender";
    shadow = true;
    shadowOffsets = [
      (-6)
      (-6)
    ];
    shadowOpacity = 0.75;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Polybar'"
      "class_g = 'i3-frame'"
      "_GTK_FRAME_EXTENTS@:c"
    ];
    settings = {
      shadow-radius = 6;
      shadow-color = "#1e1e2e";
      inactive-dim = 0.2;
      detect-client-opacity = true;
      wintypes = {
        tooltip = {
          shadow = false;
        };
        dock = {
          shadow = false;
        };
        dnd = {
          shadow = false;
        };
        popup_menu = {
          shadow = true;
        };
        dropdown_menu = {
          shadow = true;
        };
      };
    };
  };
}
