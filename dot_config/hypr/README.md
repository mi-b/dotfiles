# Hyprland Minimal Test

Minimal Hyprland configuration for a first test on Ubuntu 24.04.

## What this branch includes

- Hyprland config (plain hyprlang, no Lua)
- Waybar (workspaces, clock, network, volume, battery, tray)
- Dunst (notifications)
- Wofi (application launcher)
- Catppuccin Mocha theme throughout
- FiraCode Nerd Font

## What this branch does not include

- No wallpaper (`hyprpaper`)
- No lock screen (`hyprlock`)
- No idle daemon (`hypridle`)
- No monitor-specific rules
- No laptop lid handling
- No media/brightness keys
- No app autostart beyond bar/notifications/network applet

## Ubuntu 24.04 installation

> [!TIP]
> Consider taking a [Timeshift](https://github.com/linuxmint/timeshift)
> snapshot before installing Hyprland.
> It lets you roll the entire system back if something goes sideways.
> `sudo apt install timeshift`, open it, take a snapshot — done.

### 1. Add the Hyprland PPA

Hyprland is not in the Ubuntu 24.04 repositories.
The [cppiber PPA](https://github.com/cppiber/hyprland-ppa) provides
pre-built packages, so there is no need to compile from source.

```bash
sudo apt install -y software-properties-common
sudo add-apt-repository -y ppa:cppiber/hyprland
sudo apt update
```

### 2. Install Hyprland and the desktop portal

`xdg-desktop-portal-hyprland` is the Hyprland-specific portal backend.
Without it, screen sharing, file picker dialogs, and screenshot tools
will not work under Hyprland.

```bash
sudo apt install -y hyprland xdg-desktop-portal-hyprland
```

### 3. Install runtime packages from Ubuntu repos

```bash
sudo apt install -y \
    kitty waybar wofi dunst \
    pipewire wireplumber \
    xdg-desktop-portal \
    qtwayland5 qt6-wayland \
    network-manager-gnome \
    fonts-noto fonts-firacode \
    brightnessctl playerctl pavucontrol \
    wl-clipboard grim slurp
```

### 4. Apply chezmoi config

```bash
chezmoi apply
```

### 5. Test

1. Log out of your current session.
2. On the GDM login screen, click your username.
3. Look for the **gear icon** (bottom-right) and choose **Hyprland**.
4. Log in.

### 6. Quick test checklist

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
| Exit Hyprland | `Super+Shift+E` |

Arrow keys also work for focus and move.

Mouse: `Super+Left-drag` moves windows, `Super+Right-drag` resizes.

### 7. Revert

If Hyprland does not suit you:

1. Log out.
2. Choose your previous session from GDM.
3. Switch branch and reapply:

```bash
cd ~/.local/share/chezmoi
git checkout main
chezmoi apply
```

## Known caveats

- GDM has reported bugs with Hyprland. If login fails, try from a TTY:
  `Ctrl+Alt+F3`, log in, run `Hyprland`.
- No wallpaper is set. You will see a plain dark background.
