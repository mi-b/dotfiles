{ ... }:

let
  # Terminal apps (nvim, yazi) ship .desktop files with Terminal=true, which
  # relies on an xdg-terminal-exec helper that is unreliable under bare i3 /
  # Hyprland. Define explicit entries that launch inside kitty instead, so
  # "open this file/directory" works predictably on both WMs.
  editor = "nvim-kitty.desktop";
  fileManager = "yazi-kitty.desktop";
  pdfViewer = "org.pwmt.zathura.desktop";
  imageViewer = "org.gnome.eog.desktop";
  browser = "firefox.desktop";
  mediaPlayer = "vlc.desktop";

  # Shared MIME -> handler map, applied identically on i3 and Hyprland since
  # this module lives in the WM-agnostic modules/ tree.
  defaults = {
    # --- Web ---
    "x-scheme-handler/http" = browser;
    "x-scheme-handler/https" = browser;
    "text/html" = browser;
    "application/xhtml+xml" = browser;

    # --- PDF / PostScript ---
    "application/pdf" = pdfViewer;
    "application/postscript" = pdfViewer;
    "application/x-bzpdf" = pdfViewer;
    "application/x-gzpdf" = pdfViewer;
    "application/x-xzpdf" = pdfViewer;

    # --- Images ---
    "image/png" = imageViewer;
    "image/jpeg" = imageViewer;
    "image/gif" = imageViewer;
    "image/bmp" = imageViewer;
    "image/webp" = imageViewer;
    "image/tiff" = imageViewer;
    "image/svg+xml" = imageViewer;

    # --- Directories ---
    "inode/directory" = fileManager;

    # --- Archives (yazi browses in place) ---
    "application/zip" = fileManager;
    "application/x-tar" = fileManager;
    "application/gzip" = fileManager;
    "application/x-7z-compressed" = fileManager;
    "application/x-rar-compressed" = fileManager;
    "application/vnd.rar" = fileManager;
    "application/x-bzip2" = fileManager;
    "application/x-xz" = fileManager;
    "application/zstd" = fileManager;

    # --- Plain text / source code ---
    "text/plain" = editor;
    "text/markdown" = editor;
    "text/x-markdown" = editor;
    "text/x-csrc" = editor;
    "text/x-chdr" = editor;
    "text/x-c++src" = editor;
    "text/x-c++hdr" = editor;
    "text/x-python" = editor;
    "text/x-shellscript" = editor;
    "text/x-tex" = editor;
    "text/x-makefile" = editor;
    "text/x-lua" = editor;
    "application/x-shellscript" = editor;
    "application/json" = editor;
    "application/xml" = editor;
    "text/xml" = editor;
    "application/toml" = editor;
    "application/x-yaml" = editor;
    "text/yaml" = editor;

    # --- Video ---
    "video/mp4" = mediaPlayer;
    "video/x-matroska" = mediaPlayer;
    "video/webm" = mediaPlayer;
    "video/quicktime" = mediaPlayer;
    "video/x-msvideo" = mediaPlayer;
    "video/mpeg" = mediaPlayer;

    # --- Audio ---
    "audio/mpeg" = mediaPlayer;
    "audio/flac" = mediaPlayer;
    "audio/x-wav" = mediaPlayer;
    "audio/ogg" = mediaPlayer;
    "audio/aac" = mediaPlayer;
    "audio/opus" = mediaPlayer;
    "audio/x-m4a" = mediaPlayer;
  };
in
{
  # Explicitly export XDG base directory variables (XDG_CONFIG_HOME,
  # XDG_DATA_HOME, XDG_STATE_HOME, XDG_CACHE_HOME) in the session environment,
  # ensuring Home Manager and all XDG-aware tools agree on paths.
  xdg.enable = true;

  # Custom launchers for terminal apps inside kitty (see note above).
  xdg.desktopEntries = {
    nvim-kitty = {
      name = "Neovim (kitty)";
      genericName = "Text Editor";
      exec = "kitty nvim %F";
      terminal = false;
      noDisplay = true;
      mimeType = [
        "text/plain"
        "inode/directory"
      ];
    };
    yazi-kitty = {
      name = "Yazi (kitty)";
      genericName = "File Manager";
      exec = "kitty yazi %F";
      terminal = false;
      noDisplay = true;
      mimeType = [ "inode/directory" ];
    };
  };

  xdg.mimeApps = {
    enable = true;
    defaultApplications = defaults;
    # Also surface these handlers in "Open with" menus, not just as sole default.
    associations.added = defaults;
  };

  # Force-overwrite mimeapps.list — GNOME rewrites this file when you change
  # default applications via the GUI, which conflicts with HM's symlink.
  xdg.configFile."mimeapps.list".force = true;
}
