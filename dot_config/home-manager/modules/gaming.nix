{
  config,
  lib,
  pkgs,
  ...
}:

{
  options.gaming.steam.enable = lib.mkEnableOption "Steam";

  config = lib.mkIf config.gaming.steam.enable {
    home.packages = with pkgs; [
      steam
    ];
  };
}
