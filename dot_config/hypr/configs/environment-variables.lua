-- Environment variables
--
-- Ensure Wayland session is correctly identified by desktop applications.
-- See https://wiki.hypr.land/Configuring/Environment-variables/

-- Prepend Nix profile paths so Nix-managed programs (wofi, waybar, etc.)
-- are available to all exec_cmd calls.  Display managers like GDM do not
-- source ~/.profile, so the Nix PATH is missing from the session.
local nixPaths = os.getenv("HOME") .. "/.nix-profile/bin:/nix/var/nix/profiles/default/bin"
local currentPath = os.getenv("PATH") or "/usr/local/bin:/usr/bin:/bin"
hl.env("PATH", nixPaths .. ":" .. currentPath)

hl.env("XDG_CURRENT_DESKTOP", "Hyprland")
hl.env("XDG_SESSION_TYPE", "wayland")
hl.env("XDG_SESSION_DESKTOP", "Hyprland")
hl.env("GDK_BACKEND", "wayland,x11")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")
