{
  config,
  lib,
  pkgs,
  ...
}:

{
  config = lib.mkIf (config.host.wm == "i3") {
    home.packages = with pkgs; [
      i3
      (polybar.override { i3Support = true; })
      i3status
      feh
      xautolock
      maim
    ];

    xsession = {
      enable = true;
      windowManager.command = "i3";
      profileExtra = ''. "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"'';
    };
  };
}
