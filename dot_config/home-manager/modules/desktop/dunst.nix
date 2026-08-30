{ ... }:

{
  services.dunst = {
    enable = true;
    settings = {
      global = {
        follow = "keyboard";
        width = "(100, 350)";
        height = "(0, 300)";
        origin = "top-right";
        offset = "(10, 10)";
        notification_limit = 5;
        progress_bar_min_width = 100;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 6;
        text_icon_padding = 10;
        gap_size = 4;
        corner_radius = 8;
        corners = "all";
        font = "FiraCode Nerd Font 10";
        format = "<b>%s</b>\\n%b";
        enable_recursive_icon_lookup = true;
        icon_theme = "Adwaita";
        max_icon_size = 64;
      };
      urgency_low = {
        timeout = 8;
      };
      urgency_normal = {
        timeout = 10;
        default_icon = "dialog-information";
      };
      urgency_critical = {
        timeout = 0;
        default_icon = "dialog-warning";
      };
    };
  };
}
