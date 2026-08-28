# Hyprland Full Test

Full Hyprland configuration. Modular Lua config
with Catppuccin Mocha theme, FiraCode Nerd Font, and kitty-first workflow.

## What this branch includes

- Modular Lua Hyprland config (`hyprland.lua` + `configs/` directory)
- Waybar with modular includes (workspaces, clock, CPU, memory, network,
  volume, battery, tray)
- Dunst notifications
- Wofi launcher
- Hyprlock (lock screen with blurred screenshot, time/date display)
- Hypridle (conservative idle timers: dim 3 min, lock 5 min, dpms off 6 min)
- Hyprpaper (placeholder config — add your own wallpaper)
- Catppuccin Mocha theme throughout
- Swiss German keyboard layout with Caps Lock remapped to Ctrl
- Media keys (volume, brightness, playback)
- Scratchpad workspace (`Super+backtick`)
- Window rules (float settings apps, suppress maximize, XWayland fix)
- Three-finger swipe for workspace switching

## What this branch does not include

- No hardcoded monitor or resolution rules
- No laptop lid handling
- No forced app autostart on specific workspaces
- No suspend-on-idle (deliberately conservative)
- No SmartGit, Emacs, Dolphin, or Chromium
- No wallpaper (placeholder config only)

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

### 2. Install Hyprland and ecosystem

`xdg-desktop-portal-hyprland` is the Hyprland-specific portal backend.
Without it, screen sharing, file picker dialogs, and screenshot tools
will not work under Hyprland.

```bash
sudo apt install -y \
    hyprland \
    xdg-desktop-portal-hyprland \
    hyprlock \
    hypridle \
    hyprpaper
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

> [!NOTE]
> **Coming from `feat/hyprland-minimal`?** The only extra packages are
> `hyprlock`, `hypridle`, and `hyprpaper`. Install them and apply:
>
> ```bash
> sudo apt install -y hyprlock hypridle hyprpaper
> chezmoi apply
> ```

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
| Pseudo-tile | `Super+P` |
| Toggle split | `Super+S` |
| Scratchpad toggle | `Super+backtick` |
| Lock screen | `Super+Escape` |
| Exit Hyprland | `Super+Shift+E` |

Arrow keys also work for focus and move.

Mouse: `Super+Left-drag` moves windows, `Super+Right-drag` resizes.

Scroll: `Super+Scroll` switches workspaces.

Media keys work for volume, brightness, and playback (if hardware present).

### 7. After first successful boot

- Add a wallpaper: edit `~/.config/hypr/hyprpaper.conf`
- Adjust keyboard layout: edit `configs/input.lua`
- Add monitor rules: edit `configs/monitors.lua`
- Tweak idle timers: edit `hypridle.conf`

### 8. Revert

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
- The Lua config requires Hyprland 0.55+ (which supports Lua natively).
  If you build an older version, use `feat/hyprland-minimal` instead
  (plain hyprlang).
- No wallpaper is configured by default. Edit `hyprpaper.conf` to add one.
- Kitty's `allow_remote_control` causes double Enter/Backspace input.
  Keep it set to `no` (or `socket-only` if you need remote control).
- Caps Lock remapping is handled by Hyprland via
  `kb_options = ctrl:nocaps`.
  The i3/X11 setup applies its own remap in the i3 config.
- `hyprpolkitagent` may need to be started differently depending on how
  it was built. If the polkit agent fails, GUI privilege prompts will not
  appear.

## Differences from the minimal branch

| Feature | Minimal | Full |
|---------|---------|------|
| Config format | hyprlang | Lua (modular) |
| Lock screen | No | Yes (hyprlock) |
| Idle daemon | No | Yes (hypridle) |
| Wallpaper | No | Placeholder (hyprpaper) |
| Media keys | No | Yes |
| Scratchpad | No | Yes |
| Window rules | No | Yes |
| Animations | Defaults | Custom beziers |
| Waybar modules | 5 | 7 |
| Gestures | No | 3-finger swipe |
