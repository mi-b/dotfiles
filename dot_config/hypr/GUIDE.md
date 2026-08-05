# Understanding Hyprland

A practical introduction for someone who has never used a tiling Wayland
compositor before.

## What is Hyprland?

Hyprland is a **tiling Wayland compositor**.
That sentence contains three things worth unpacking.

### Wayland

Wayland is the display protocol that replaces the venerable X11 (Xorg).
X11 has been around since 1987 and it shows — it was designed for a world
where a networked terminal was exciting technology.
Wayland is simpler, more secure, and better suited to modern hardware.

The practical difference: some older tools assume X11 and may not work
without an XWayland compatibility layer (which Hyprland provides).

### Compositor

On Wayland, the **compositor** is the thing that manages windows,
handles input, talks to the GPU, and draws everything on screen.
It replaces both the X server and the window manager in one programme.

### Tiling

A **tiling** window manager arranges windows automatically so they fill
the screen without overlapping.
You don't drag windows around with a mouse; instead, new windows split
the available space and you navigate between them with keybindings.

This sounds restrictive until you try it.
After a week you'll wonder why you ever dragged rectangles around
manually.

## Core Concepts

### Windows

A window is what you'd expect: a terminal, a browser, an editor.
In Hyprland, windows are either **tiled** (arranged automatically) or
**floating** (positioned freely, like a traditional desktop).

Toggle floating with `Super+V`.

### Workspaces

Workspaces are virtual desktops.
Hyprland supports up to 10 numbered workspaces (and more if you want
them).
Switch with `Super+1` through `Super+0`.

Think of workspaces as rooms in a house: the terminal room, the browser
room, the "I'll deal with this later" room.

### The Modifier Key

Almost every Hyprland keybinding starts with a **modifier key**.
In this configuration, the modifier is `Super` (the key with the Windows
logo, or `Command` on Apple keyboards).

### Layouts

Hyprland supports several tiling layouts.
This configuration uses **dwindle**: each new window splits the current
space in half, alternating between horizontal and vertical splits.

```
┌───────────┬───────────┐
│           │           │
│     1     │     2     │
│           │           │
│           ├─────┬─────┤
│           │  3  │  4  │
└───────────┴─────┴─────┘
```

You can toggle the split direction with `Super+S`.

## How the Configuration Works

### Single File

This branch uses a single configuration file in plain **hyprlang**
(Hyprland's own configuration language):

```
~/.config/hypr/hyprland.conf
```

Hyprlang is a simple key-value format with sections.
It is not Lua, TOML, or YAML.
It looks like this:

```hyprlang
general {
    gaps_in = 3
    gaps_out = 5
    border_size = 2
}

bind = SUPER, Return, exec, kitty
```

### Structure of the Config

The configuration is organised into logical sections:

| Section | What it controls |
|---------|-----------------|
| `env` | Environment variables for the Wayland session |
| `monitor` | Display detection and layout |
| `input` | Keyboard, mouse, touchpad settings |
| `general` | Gaps, borders, layout choice |
| `decoration` | Rounding, shadows, blur |
| `animations` | Window open/close/move effects |
| `dwindle` | Dwindle layout options |
| `misc` | Miscellaneous (logo, wallpaper) |
| `exec-once` | Programmes to start when Hyprland launches |
| `bind` / `bindm` | Keybindings and mouse bindings |

### Companion Programmes

Hyprland is deliberately **not** a full desktop environment.
It tiles windows and handles input.
Everything else is a separate programme:

| Programme | Purpose | Config location |
|-----------|---------|-----------------|
| **Waybar** | Status bar (clock, battery, network, etc.) | `~/.config/waybar/` |
| **Dunst** | Notification daemon | `~/.config/dunst/dunstrc` |
| **Wofi** | Application launcher | `~/.config/wofi/` |

These are started automatically via `exec-once` lines in the Hyprland
config.

## Quick Reference

### Keybindings

| Action | Bind |
|--------|------|
| Open terminal | `Super+Enter` |
| Open launcher | `Super+Space` |
| Close window | `Super+Q` |
| Focus left/down/up/right | `Super+H/J/K/L` |
| Move window | `Super+Shift+H/J/K/L` |
| Switch workspace | `Super+1..0` |
| Move window to workspace | `Super+Shift+1..0` |
| Toggle floating | `Super+V` |
| Fullscreen | `Super+F` |
| Toggle split direction | `Super+S` |
| Exit Hyprland | `Super+Shift+E` |

Arrow keys work as alternatives to `H/J/K/L`.

Mouse: `Super+Left-drag` moves windows, `Super+Right-drag` resizes.

### The HJKL Pattern

If you use Vim or Neovim, the navigation keys are familiar:

```
     K
     ↑
 H ←   → L
     ↓
     J
```

This pattern is used consistently for focus and window movement.

## Useful Commands

Once inside a Hyprland session, you can query and control it from any
terminal:

```bash
# List connected monitors
hyprctl monitors

# List all windows
hyprctl clients

# List active keybindings
hyprctl binds

# Reload the configuration (no restart needed)
hyprctl reload

# Get the Hyprland version
hyprctl version
```

## What to Expect on First Boot

1. You will see a **dark background** with no wallpaper.
   This is normal — no wallpaper manager is configured.
2. A **status bar** (Waybar) should appear at the top.
3. Press `Super+Enter` to open a terminal.
4. Press `Super+Space` to open the application launcher.
5. If nothing happens, something went wrong with the build or config.
   Check `~/.local/share/hyprland/hyprland.log` for errors.

## Troubleshooting

### Nothing happens when I press Super+Enter

- Is `kitty` installed? Run `which kitty` in a TTY.
- Is the config in the right place? Check `~/.config/hypr/hyprland.conf`.

### Waybar does not appear

- Is `waybar` installed? Run `which waybar`.
- Check Waybar logs: `journalctl --user -u waybar` or run `waybar`
  manually from a terminal to see errors.

### The screen is blank after login

- GDM has known issues with Hyprland.
  Try logging in from a TTY instead: `Ctrl+Alt+F3`, log in, run
  `Hyprland`.
- Check the Hyprland log: `~/.local/share/hyprland/hyprland.log`.

### I want to go back to my normal desktop

Log out (`Super+Shift+E`), then choose your previous session from the
GDM login screen.

## Further Reading

- [Hyprland Wiki](https://wiki.hypr.land/) — the definitive reference
- [Master Tutorial](https://wiki.hypr.land/Getting-Started/Master-Tutorial/)
  — official getting-started guide
- [Configuring Variables](https://wiki.hypr.land/Configuring/Variables/)
  — all configuration options
- [Catppuccin for Hyprland](https://github.com/catppuccin/hyprland)
  — the theme palette used in this configuration
