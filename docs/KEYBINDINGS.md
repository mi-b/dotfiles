# Keybindings

## Window managers

`$mod` is the **Super** key (Windows key).

Both WMs share the same binding philosophy: vim-style navigation
(h/j/k/l), arrow key alternatives, and consistent modifier layering
(`$mod` for focus, `$mod+Shift` for move, `$mod+Ctrl` for monitor ops).

### Hyprland (Wayland)

#### Applications

| Binding        | Action                |
| -------------- | --------------------- |
| `$mod+Return`  | Open terminal (kitty) |
| `$mod+Space`   | Open launcher (wofi)  |
| `$mod+B`       | Bluetooth manager     |

#### Window management

| Binding        | Action               |
| -------------- | -------------------- |
| `$mod+Q`       | Close window (safe)  |
| `$mod+F`       | Toggle fullscreen    |
| `$mod+V`       | Toggle floating      |
| `$mod+P`       | Pseudo-tile          |
| `$mod+S`       | Toggle split         |
| `$mod+Escape`  | Lock screen          |
| `$mod+Shift+E` | Exit Hyprland        |

> [!NOTE]
> `$mod+Q` refuses to kill kitty windows that contain a running neovim
> process.
> Close neovim first, then close the window.

#### Focus and move

| Binding              | Action                         |
| -------------------- | ------------------------------ |
| `$mod+H/J/K/L`      | Focus left/down/up/right       |
| `$mod+Shift+H/J/K/L`| Move window left/down/up/right |
| `$mod+Ctrl+H/L`     | Move workspace to monitor      |
| Arrow key variants   | Also work for all of the above |

#### Workspaces

| Binding           | Action                        |
| ----------------- | ----------------------------- |
| `$mod+1..0`       | Switch to workspace 1–10      |
| `$mod+Shift+1..0` | Move window to workspace 1–10 |
| `$mod+Tab`        | Toggle scratchpad             |
| `$mod+Shift+Tab`  | Move to scratchpad            |

#### Mouse

| Binding           | Action             |
| ----------------- | ------------------ |
| `$mod+Left-drag`  | Move window        |
| `$mod+Right-drag` | Resize window      |
| `$mod+Scroll`     | Switch workspaces  |

### i3 (X11)

#### Applications

| Binding        | Action                |
| -------------- | --------------------- |
| `$mod+Return`  | Open terminal (kitty) |
| `$mod+Space`   | Open launcher (rofi)  |

#### Window management

| Binding        | Action                    |
| -------------- | ------------------------- |
| `$mod+Q`       | Kill focused window       |
| `$mod+F`       | Toggle fullscreen         |
| `$mod+Shift+F` | Toggle floating           |
| `$mod+B`       | Split horizontal          |
| `$mod+V`       | Split vertical            |
| `$mod+D`       | Toggle tiling/float focus |
| `$mod+R`       | Enter resize mode         |
| `$mod+Escape`  | Lock screen               |
| `$mod+Shift+R` | Reload i3 config          |
| `$mod+Shift+E` | Exit i3 (with prompt)     |

#### Focus and move

| Binding              | Action                         |
| -------------------- | ------------------------------ |
| `$mod+H/J/K/L`      | Focus left/down/up/right       |
| `$mod+Shift+H/J/K/L`| Move window left/down/up/right |
| `$mod+Ctrl+H/L`     | Move workspace to output       |
| Arrow key variants   | Also work for all of the above |

> [!NOTE]
> `$mod+L` and `$mod+Shift+L` do not work over RDP — Windows intercepts
> `Win+L` at the protocol level.
> Use `$mod+ö` / `$mod+Shift+ö` as alternatives (same physical position,
> one key right of `l` on Swiss German layout).

#### Workspaces

| Binding           | Action                                     |
| ----------------- | ------------------------------------------ |
| `$mod+1..0`       | Switch to workspace 1–10                   |
| `$mod+Shift+1..0` | Move window to workspace 1–10 (and follow) |
| `$mod+§`          | Show scratchpad                            |
| `$mod+Shift+§`    | Move to scratchpad                         |

#### Resize mode

Enter with `$mod+R`, exit with `Escape` or `Return`.

| Key           | Action        |
| ------------- | ------------- |
| `h` / `Left`  | Shrink width  |
| `l` / `Right` | Grow width    |
| `k` / `Up`    | Shrink height |
| `j` / `Down`  | Grow height   |

#### Screenshots (flameshot)

| Binding            | Action                     |
| ------------------ | -------------------------- |
| `Print`            | Interactive region capture |
| `$mod+Print`       | Full screen to clipboard   |
| `$mod+Shift+Print` | Full screen to file        |

### Shared media keys

Both WMs bind the same hardware keys:

| Key                     | Action              |
| ----------------------- | ------------------- |
| `XF86AudioRaiseVolume`  | Volume up 5%        |
| `XF86AudioLowerVolume`  | Volume down 5%      |
| `XF86AudioMute`         | Toggle mute         |
| `XF86AudioMicMute`      | Toggle mic mute     |
| `XF86MonBrightnessUp`   | Brightness up 5%    |
| `XF86MonBrightnessDown` | Brightness down 5%  |
| `XF86AudioPlay/Pause`   | Play/pause          |
| `XF86AudioNext/Prev`    | Next/previous track |

## Shell

### fzf

| Shortcut | Action                                 |
| -------- | -------------------------------------- |
| Ctrl+T   | Find file (fd), insert path at cursor  |
| Alt+C    | Find directory (fd), cd into selection |
| Ctrl+R   | Search command history                 |

### Custom functions

| Command | Action                                   |
| ------- | ---------------------------------------- |
| `fn`    | Fuzzy-find files, open selection in nvim |

### Yazi

| Command | Action                                    |
| ------- | ----------------------------------------- |
| `y`     | Open yazi; cd into last directory on exit |
