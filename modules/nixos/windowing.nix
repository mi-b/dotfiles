{
  config,
  pkgs,
  pkgsStable,
  ...
}:
{
  # Enable the X11 windowing system.
  services.xserver.enable = true;
  services.xserver.autorun = true;

  # Display Manager ===========================================================
  services.displayManager = {
    autoLogin.enable = false;
    autoLogin.user = "herbert";
  };

  services.xserver.displayManager = {
    gdm = {
      enable = true;
      wayland = true;
    };
  };

  hardware = {
    graphics = {
      enable = true;
      enable32Bit = true;
    };
  };

  # ===========================================================================

  # Desktop Manager ===========================================================
  services.xserver.desktopManager.gnome.enable = true;
  # ===========================================================================
}
