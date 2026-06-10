# dotfiles

This repo contains the dotfiles for my machines.
They are managed with [chezmoi](https://chezmoi.io), because typing the same setup twice is already insulting.

## Install chezmoi

```sh
sh -c "$(curl -fsLS https://get.chezmoi.io/lb)"
```

This installs `chezmoi` into `~/.local/bin`.

## Initialise the repo

Public shorthand:

```sh
chezmoi init mi-b
```

SSH for the private repo:

```sh
chezmoi init git@github.com:mi-b/dotfiles.git
```

## Review before applying

```sh
chezmoi diff
chezmoi apply
```

Do not blindly run `init --apply` unless you are happy to let the repo make system changes immediately.

## What `chezmoi apply` may do

Depending on the answers you give during initial setup, the repo can:

- manage shell and editor config
- install development tools
- install desktop applications
- install Firefox
- install Google Chrome
- apply a small curated set of GNOME `dconf` settings

Some of those steps require `sudo`.
That is deliberate, not a bug, though it can still be irritating.

## Initial prompts

The repo asks for:

- workspace: `private` or `work`
- whether the machine is a desktop system
- whether to install development tools
- whether to install desktop applications
- whether to install Firefox
- whether to install Google Chrome

These answers are stored in `~/.config/chezmoi/chezmoi.yaml`.
