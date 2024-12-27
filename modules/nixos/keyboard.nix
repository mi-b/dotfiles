{
  config,
  pkgs,
  ...
}:
{
  ### Keyboard Settings =================================================

  # Waylands input service which handles mouse and touchpad.
  # services.libinput = {
  #   enable = true;
  #   touchpad = {
  #     tapping = true;
  #     tappingButtonMap = "lrm";
  #     naturalScrolling = true;
  #     horizontalScrolling = true;
  #   };
  # };

  i18n.defaultLocale = "en_US.UTF-8";

  console = {
    keyMap = "us";
  };

  services.xserver = {
    xkb = {
      layout = "English US";
      variant = "";
      options = "ctrl:nocaps";
    };
  };

  # Logitech Receiver and Solaar Gui
  hardware.logitech.wireless = {
    enable = true;
    enableGraphical = true;
  };

  environment.systemPackages = with pkgs; [
    # Logitech
    solaar
    xorg.xmodmap
  ];

  # ===========================================================================
}
