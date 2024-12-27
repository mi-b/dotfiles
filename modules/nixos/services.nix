{
  config,
  pkgs,
  ...
}:
{
  ### Services ================================================================
  services = {
    # UDev settings.
    udev.packages = [
      pkgs.headsetcontrol
    ];

    # Dbus settings.
    dbus = {
      enable = true;
      # Choosing `broker` here uses
      # the new dbus implementation
      # which makes systemd units.
      implementation = "broker";
    };

    upower.enable = true;
    locate.enable = true;

    # For `udisksctl power-off` etc.
    udisks2.enable = true;

    tumbler.enable = true; # Thumbnailing DBus service.
  };

  programs.dconf.enable = true;

  # ===========================================================================
}
