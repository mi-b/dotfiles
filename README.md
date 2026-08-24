# dotfiles

Personal dotfiles for Linux and Windows machines, managed with
[chezmoi](https://chezmoi.io).
Packages are declared via [Nix](https://nixos.org/) and
[Home Manager](https://nix-community.github.io/home-manager/) (Linux only).
GUI applications use [Flatpak](https://flatpak.org/).

## What it does

| Layer | Managed by | Scope |
| ----- | ---------- | ----- |
| CLI tools, LSPs, formatters, fonts | Nix / Home Manager | `~/.config/home-manager/` |
| GUI applications | Flatpak (declared in Home Manager) | Chrome, Firefox, VS Code, VLC, GIMP, Inkscape |
| Window manager & desktop services | apt | Hyprland or i3 + pipewire, dunst, etc. |
| Dotfile templates & config | chezmoi | Shell, editor, terminal, WM configs |

## Bootstrap a new machine

```console
# 1. Install chezmoi
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)"

# 2. Initialise (SSH for private repo)
chezmoi init git@github.com:mi-b/dotfiles.git

# 3. Review and apply
chezmoi diff
chezmoi apply
```

`chezmoi apply` will:

1. Install Nix and Flatpak (if missing)
2. Apply Home Manager configuration (all CLI tools, LSPs, fonts)
3. Install Flatpak GUI apps
4. Deploy dotfiles and configs

Some steps require `sudo`. That is deliberate, not a bug.

## Machine types

| Machine | Gets |
| ------- | ---- |
| Linux (desktop) | Full Nix + Home Manager + Flatpak + WM |
| Windows | Neovim config, bashrc, starship only (no Home Manager) |

## Initial prompts

Chezmoi asks for:

- **workspace**: `private` or `work` (affects git identity)
- **wm**: `hyprland`, `i3`, or `none` (affects WM packages and configs)

Answers are stored in `~/.config/chezmoi/chezmoi.yaml`.

## Updating packages

```console
cd ~/.local/share/chezmoi/dot_config/home-manager
nix flake update
home-manager switch --flake .
git add flake.lock && git commit -m "chore: update flake.lock"
```

Or simply edit the Nix files and run `chezmoi apply` — the `run_onchange`
script detects changes and re-applies.

## Per-project development environments

See [`docs/NIX.md`](docs/NIX.md) for details on using Nix flakes + direnv
for pinned per-project dependencies.

## Duplicated configs (Linux + Windows)

The following chezmoi-managed configs are also declared in Home Manager for
Linux. They remain in chezmoi solely for Windows. Once Windows is split into
its own branch or repo, these can be deleted from chezmoi:

- `dot_config/yazi/` — `programs.yazi` in Home Manager
- `dot_config/lazygit/config.yml` — `programs.lazygit` in Home Manager

## Licence

Unlicensed. Steal what you like.
