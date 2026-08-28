{ config, ... }:

let
  isHyprland = config.host.wm == "hyprland";
in
{
  programs.kitty = {
    enable = true;

    font = {
      name = "FiraCode Nerd Font";
      size = 12.0;
    };

    shellIntegration.mode = null;

    settings = {
      hide_window_decorations = isHyprland;
      window_padding_width = 5;
      confirm_os_window_close = "-1 count-background";

      scrollback_lines = 50000;

      enable_audio_bell = false;
      visual_bell_duration = "0.1";
      visual_bell_color = "#333333";

      clipboard_control = "write-clipboard read-clipboard";
    };

    extraConfig = ''
      # Home Manager forces no-rc when using shellIntegration.mode.
      # We need prompt-aware shell integration without cursor shape changes.
      shell_integration no-cursor
    '';

    keybindings = {
      "kitty_mod+right" = "next_window";
      "kitty_mod+left" = "next_window";
      "kitty_mod+up" = "next_tab";
      "kitty_mod+down" = "previous_tab";
      "ctrl+shift+b" = "launch --type=os-window --cwd=current";
    };
  };
}
