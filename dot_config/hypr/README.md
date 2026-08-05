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

Hyprland is **not packaged** for Ubuntu 24.04. You must build it manually.

### 1. Install runtime packages from Ubuntu repos

```bash
sudo apt update && sudo apt install -y \
    kitty waybar wofi dunst \
    pipewire wireplumber \
    xdg-desktop-portal \
    qtwayland5 qt6-wayland \
    network-manager-gnome \
    fonts-noto fonts-firacode \
    brightnessctl playerctl pavucontrol \
    wl-clipboard grim slurp
```

### 2. Install build dependencies

```bash
sudo apt install -y \
    meson wget build-essential ninja-build cmake-extras cmake \
    gettext gettext-base fontconfig libfontconfig-dev libffi-dev \
    libxml2-dev libdrm-dev libxkbcommon-x11-dev libxkbregistry-dev \
    libxkbcommon-dev libpixman-1-dev libudev-dev libseat-dev seatd \
    libxcb-dri3-dev libegl-dev libgles2 libegl1-mesa-dev glslang-tools \
    libinput-bin libinput-dev libxcb-composite0-dev libavutil-dev \
    libavcodec-dev libavformat-dev libxcb-ewmh2 libxcb-ewmh-dev \
    libxcb-present-dev libxcb-icccm4-dev libxcb-render-util0-dev \
    libxcb-res0-dev libxcb-xinput-dev libtomlplusplus3 libre2-dev
```

### 3. Build Hyprland and ecosystem from source

Follow the official wiki:
<https://wiki.hypr.land/Getting-Started/Installation/>

Short version:

```bash
# Build dependencies first (latest tagged releases):
#   wayland, wayland-protocols, libdisplay-info
# Then Hyprland sub-projects:
#   hyprutils, hyprlang, hyprcursor, hyprgraphics,
#   hyprwayland-scanner, aquamarine

git clone --recursive https://github.com/hyprwm/Hyprland
cd Hyprland
make all && sudo make install
```

Also build from source:

- `xdg-desktop-portal-hyprland`
- `hyprpaper`
- `hyprlock`
- `hypridle`
- `hyprpolkitagent`

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
- Ubuntu 24.04 lags behind on Wayland dependencies; builds may need
  manual dependency resolution.
- The Lua config requires Hyprland 0.55+ (which supports Lua natively).
  If you build an older version, use `feat/hyprland-minimal` instead
  (plain hyprlang).
- No wallpaper is configured by default. Edit `hyprpaper.conf` to add one.
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
