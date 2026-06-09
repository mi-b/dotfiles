# dotfiles

This repo contains the dot-files for my machine(s). The files are managed using [Chezmoi](https://chezmoi.io).

## How to run

```shell
sh -c "$(curl -fsLS get.chezmoi.io)" -- init --apply mi-b
```
or

```shell
sh -c "$(curl -fsLS https://get.chezmoi.io)" -- init --apply git@github.com:mi-b/dotfiles.git
```
