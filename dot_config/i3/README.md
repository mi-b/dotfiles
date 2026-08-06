# i3 Desktop Setup

Full i3 tiling window manager setup with Catppuccin Mocha theme.
Designed for use over xrdp on a shared Ubuntu machine.

## What's Included

| Component      | Tool     | Purpose                        |
| -------------- | -------- | ------------------------------ |
| Window manager | i3       | Tiling WM for X11              |
| Status bar     | polybar  | System info, workspaces, tray  |
| Launcher       | rofi     | Application launcher           |
| Compositor     | picom    | Shadows, transparency          |
| Notifications  | dunst    | Desktop notifications          |
| Lock screen    | i3lock   | Screen lock (solid background) |
| Wallpaper      | feh      | Static wallpaper               |
| Idle timer     | xautolock| Auto-lock after 5 minutes      |

> [!NOTE]
> Consider upgrading to `i3lock-color` for a Catppuccin-themed lock screen
> with clock display and blurred background.
> The current setup uses plain `i3lock` with a solid `#1e1e2e` background.

## Installation

Deploy with chezmoi:

```console
$ chezmoi apply
```

The install script (`run_onchange_install-i3.sh.tmpl`) runs automatically on
first apply and installs all required packages.
It only runs on Linux machines with `desktop.enabled` set to `true`.

## xrdp Setup

The `~/.xsession` file tells xrdp to start i3 instead of GNOME.
It is deployed automatically by chezmoi as `dot_xsession`.

After applying, disconnect your current RDP session and reconnect.
xrdp will pick up the new `.xsession` on the next login.

To switch back to GNOME temporarily:

```bash
# Replace the contents of ~/.xsession
echo "exec gnome-session" > ~/.xsession
```

Then reconnect via RDP.

## Testing Locally

If you have a physical X11 session (not xrdp), you can test with:

```console
$ startx ~/.xsession
```

Or switch to a free TTY (`Ctrl+Alt+F3`) and run `startx` from there.

## Keybindings

`$mod` is the **Super** key (Windows key).

### Applications

| Binding           | Action                  |
| ----------------- | ----------------------- |
| `$mod+Return`     | Open terminal (kitty)   |
| `$mod+Space`      | Open launcher (rofi)    |

### Window Management

| Binding           | Action                  |
| ----------------- | ----------------------- |
| `$mod+q`          | Kill focused window     |
| `$mod+f`          | Toggle fullscreen       |
| `$mod+Shift+f`    | Toggle floating         |
| `$mod+b`          | Split horizontal        |
| `$mod+v`          | Split vertical          |
| `$mod+d`          | Toggle tiling/float focus |
| `$mod+r`          | Enter resize mode       |
| `$mod+Escape`     | Lock screen             |
| `$mod+Shift+e`    | Exit i3 (with prompt)   |

### Focus and Move (Vim Keys)

| Binding           | Action                  |
| ----------------- | ----------------------- |
| `$mod+h/j/k/l`   | Focus left/down/up/right |
| `$mod+Shift+h/j/k/l` | Move window left/down/up/right |
| Arrow key variants also work |                |

### Resize Mode

Enter with `$mod+r`, exit with `Escape` or `Return`.

| Key               | Action                  |
| ----------------- | ----------------------- |
| `h` / `Left`      | Shrink width            |
| `l` / `Right`     | Grow width              |
| `k` / `Up`        | Shrink height           |
| `j` / `Down`      | Grow height             |

### Workspaces

| Binding           | Action                  |
| ----------------- | ----------------------- |
| `$mod+1-0`        | Switch to workspace 1–10 |
| `$mod+Shift+1-0`  | Move window to workspace 1–10 |
| `$mod+Tab`        | Show scratchpad         |
| `$mod+Shift+Tab`  | Move to scratchpad      |

### Media Keys

| Key                      | Action                         |
| ------------------------ | ------------------------------ |
| `XF86AudioRaiseVolume`   | Volume up 5%                   |
| `XF86AudioLowerVolume`   | Volume down 5%                 |
| `XF86AudioMute`          | Toggle mute                    |
| `XF86AudioMicMute`       | Toggle mic mute                |
| `XF86MonBrightnessUp`    | Brightness up 5%               |
| `XF86MonBrightnessDown`  | Brightness down 5%             |
| `XF86AudioPlay/Pause`    | Play/pause                     |
| `XF86AudioNext/Prev`     | Next/previous track            |

## Theme

Catppuccin Mocha throughout:

- **Borders**: lavender (`#b4befe`) active, overlay0 (`#6c7086`) inactive
- **Gaps**: 3px inner, 5px outer
- **Border width**: 2px
- **Font**: FiraCode Nerd Font

## Differences from Hyprland Setup

| Feature              | Hyprland              | i3                    |
| -------------------- | --------------------- | --------------------- |
| Display protocol     | Wayland               | X11                   |
| Animations           | Yes (bezier curves)   | No                    |
| Blur                 | Yes                   | No                    |
| Window rounding      | 8px                   | No (picom limited)    |
| Gestures             | 3-finger swipe        | Not included          |
| Bar                  | waybar                | polybar               |
| Launcher             | wofi                  | rofi                  |
| Lock screen          | hyprlock (themed)     | i3lock (solid colour) |
| Idle daemon          | hypridle              | xautolock             |
| Wallpaper            | swaybg                | feh                   |
| Clipboard            | wl-clipboard          | xclip                 |
| Screenshots          | grim + slurp          | maim                  |
| Remote (xrdp)        | Not supported         | Works natively        |

## File Layout

```
~/.config/
├── i3/
│   └── config              # i3 window manager configuration
├── polybar/
│   ├── config.ini          # Status bar configuration
│   └── catppuccin-mocha.ini # Colour palette
├── rofi/
│   └── config.rasi         # Application launcher
├── picom/
│   └── picom.conf          # X11 compositor
├── dunst/
│   └── dunstrc             # Notification daemon
└── kitty/
    └── ...                 # Terminal emulator
~/.xsession                 # xrdp session entry point
```
