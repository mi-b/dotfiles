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
        progress_bar_height = 12;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 100;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 6;
        text_icon_padding = 10;
        frame_color = "#b4befe";
        gap_size = 4;
        separator_color = "frame";
        corner_radius = 8;
        corners = "all";
        font = "FiraCode Nerd Font 10";
        format = "<b>%s</b>\\n%b";
        ellipsize = "middle";
        enable_recursive_icon_lookup = true;
        icon_theme = "Adwaita";
        min_icon_size = 24;
        max_icon_size = 64;
        browser = "xdg-open";
        force_xwayland = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#6c7086";
        timeout = 8;
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#b4befe";
        highlight = "#89b4fa";
        timeout = 10;
        default_icon = "dialog-information";
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8";
        highlight = "#f38ba8";
        timeout = 0;
        default_icon = "dialog-warning";
      };
    };
  };
}
