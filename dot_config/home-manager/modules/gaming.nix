{
  config,
  lib,
  pkgs,
  ...
}:

let
  steam = config.lib.nixGL.wrap pkgs.steam;
in
{
  options.gaming.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf config.gaming.steam.enable {
    home.packages = [
      steam
    ];

    xdg.desktopEntries.steam = {
      name = "Steam";
      comment = "Manage and play games on Steam";
      exec = "${lib.getExe steam} %U";
      icon = "steam";
      terminal = false;
      categories = [ "Game" ];
      mimeType = [
        "x-scheme-handler/steam"
        "x-scheme-handler/steamlink"
      ];
    };
  };
}
