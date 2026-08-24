{ config, pkgs, ... }:

let
  isHyprland = config.host.wm == "hyprland";
in
{
  xdg.configFile."kitty/kitty.conf".text = ''
    # Kitty configuration — only non-default settings.

    # --- Font ---
    font_family      FiraCode Nerd Font
    bold_font        auto
    italic_font      auto
    bold_italic_font auto
    font_size        12.0
    disable_ligatures never

    # --- Window ---
    hide_window_decorations ${if isHyprland then "yes" else "no"}
    window_padding_width    5
    confirm_os_window_close 0

    # --- Scrollback ---
    scrollback_lines 50000

    # --- Bell ---
    enable_audio_bell    no
    visual_bell_duration 0.1
    visual_bell_color #333333

    # --- Clipboard & remote ---
    clipboard_control    write-clipboard read-clipboard
    allow_remote_control no
    allow_hyperlinks     yes

    # --- Theme ---
    include themes/mocha.conf
    ${if isHyprland then ''

    # --- Shell integration ---
    shell_integration no-cursor'' else ""}

    # --- Keybindings ---
    map kitty_mod+right next_window
    map kitty_mod+left  next_window
    map kitty_mod+up    next_tab
    map kitty_mod+down  previous_tab
    map ctrl+shift+b launch --type=os-window --cwd=current
  '';

  xdg.configFile."kitty/themes/mocha.conf".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/mocha.conf";
    hash = "sha256-cWrJfNVCuuT/NbU8qYCq5PAB4MS8WcT74AMBm+IO+c0=";
  };
}
