{
  # Explicitly export XDG base directory variables (XDG_CONFIG_HOME,
  # XDG_DATA_HOME, XDG_STATE_HOME, XDG_CACHE_HOME) in the session environment,
  # ensuring Home Manager and all XDG-aware tools agree on paths.
  xdg.enable = true;

  xdg.mimeApps = {
    enable = true;
    defaultApplications = {
      "image/png" = "org.gnome.eog.desktop";
      "image/jpeg" = "org.gnome.eog.desktop";
      "image/gif" = "org.gnome.eog.desktop";
      "image/bmp" = "org.gnome.eog.desktop";
      "image/webp" = "org.gnome.eog.desktop";
      "image/tiff" = "org.gnome.eog.desktop";
      "image/svg+xml" = "org.gnome.eog.desktop";
      "x-scheme-handler/http" = "firefox.desktop";
      "x-scheme-handler/https" = "firefox.desktop";
      "text/html" = "firefox.desktop";
      "application/xhtml+xml" = "firefox.desktop";
    };
  };

  # Force-overwrite mimeapps.list — GNOME rewrites this file when you change
  # default applications via the GUI, which conflicts with HM's symlink.
  xdg.configFile."mimeapps.list".force = true;
}
