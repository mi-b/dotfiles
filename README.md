# dotfiles

Personal dotfiles for Linux and Windows machines, managed with
[chezmoi](https://chezmoi.io).
Packages are declared via [Nix](https://nixos.org/) and
[Home Manager](https://nix-community.github.io/home-manager/) (Linux only).
GUI applications use [Nix](https://nixos.org/) or [Flatpak](https://flatpak.org/).

## What it does

| Layer                              | Managed by                   | Scope                                                      |
| ---------------------------------- | ---------------------------- | ---------------------------------------------------------- |
| CLI tools, LSPs, formatters, fonts | Nix / Home Manager           | `~/.config/home-manager/`                                  |
| GUI applications                   | Nix / Home Manager + Flatpak | Firefox, VLC (Nix)                                         |
| Electron apps (Signal)             | Nix / Home Manager (wrapped) | Launched with `--no-sandbox` — see [caveats](#nix-caveats) |
| Containers (Podman)                | Nix + system `uidmap`        | Rootless containers via `containers.conf`                  |
| Window manager & system services   | apt + Nix / Home Manager     | Binaries from apt (PPA/repos), config from Home Manager    |
| Dotfile templates & config         | chezmoi                      | Shell, editor, terminal, WM configs                        |

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
3. Install Nix-managed GUI apps and any declared Flatpaks
4. Deploy dotfiles and configs

Some steps require `sudo`. That is deliberate, not a bug.

## Machine types

| Machine         | Gets                                                   |
| --------------- | ------------------------------------------------------ |
| Linux (desktop) | Full Nix + Home Manager + Flatpak + WM                 |
| Windows         | Neovim config, bashrc, starship only (no Home Manager) |

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

## Nix caveats

### SUID binaries

The Nix store cannot hold SUID binaries (mode `4755`, owned by root).
This affects two categories:

- **Electron apps** (Signal, etc.) — Chromium's SUID sandbox helper
  (`chrome-sandbox`) won't work from `/nix/store/`.
  Signal is wrapped with `--no-sandbox` via `symlinkJoin`/`makeWrapper`,
  which disables Chromium's OS-level process sandbox.
  Signal's own encryption is unaffected.
- **Rootless containers** (Podman) — `newuidmap`/`newgidmap` require SUID
  to map subordinate UIDs.
  These come from the system `uidmap` package (installed via apt in
  `run_once_install-desktop-runtime.sh`).
  A `containers.conf` managed by Home Manager points Podman's
  `helper_binaries_dir` at both the Nix store (for `netavark`, `conmon`,
  etc.) and `/usr/bin` (for the SUID helpers).

### GPU acceleration

GPU-accelerated Nix apps use [nixGL](https://github.com/nix-community/nixGL)
to access the host system's GL/Vulkan drivers.
nixGL wraps individual apps rather than replacing system-wide driver paths,
so it is safe on **multi-user machines** — other users' GPU access is
unaffected.

To wrap a Nix package for GPU access in a Home Manager module:

```nix
config.lib.nixGL.wrap pkgs.kitty
```

Home Manager's `targets.genericLinux.nixGL` is configured with
`defaultWrapper = "nvidia"` for the discrete GPU.

> [!WARNING]
> The alternative approach, `targets.genericLinux.gpu`, installs GPU
> libraries system-wide via `/run/opengl-driver`.
> This **breaks other users'** GPU access on shared machines and can crash
> the lock screen due to glibc version mismatches.
> The driver version and hash are kept commented out in `base.nix` for
> reference.

Nix CLI tools (e.g. `ffmpeg` with NVENC) can use the GPU for compute and
encoding without nixGL wrapping.
See [`docs/NIX.md`](docs/NIX.md) for the full write-up.

## Duplicated configs (Linux + Windows)

The following chezmoi-managed configs are also declared in Home Manager for
Linux. They remain in chezmoi solely for Windows. Once Windows is split into
its own branch or repo, these can be deleted from chezmoi:

- `dot_config/yazi/` — `programs.yazi` in Home Manager
- `dot_config/lazygit/config.yml` — `programs.lazygit` in Home Manager

## xrdp (i3 only)

The `~/.xsession` file tells xrdp to start i3 instead of GNOME.
It is deployed automatically by chezmoi via `dot_xsession`.

After applying, disconnect your current RDP session and reconnect.
xrdp picks up the new `.xsession` on the next login.

To switch back to GNOME temporarily:

```bash
echo "exec gnome-session" > ~/.xsession
```

Then reconnect via RDP.

> [!NOTE]
> Hyprland does not work over xrdp — it requires native Wayland.

## Licence

Unlicensed. Steal what you like.
