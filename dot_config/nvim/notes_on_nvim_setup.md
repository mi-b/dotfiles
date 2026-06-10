# Setting up neovim on Ubuntu

These are some notes taken during setup of neovim.
The setting is created by following the explanations of typecraft [Video Series](https://www.youtube.com/watch?v=zHTeCSVAFNY&ab_channel=typecraft).

## General setup

### Terminal and so

Use a normal terminal, bash, and starship if you want a prompt that looks
less like the shell has developed opinions.

### Fonts

get Nerd Font (e.g. Fira or Jetbrains) from [nerdfonts](https://www.nerdfonts.com/font-downloads)
download font and move font folter to `~/.fonts/`

```sh
rc-cache -fv
```

### Keyboard

Use GNOME keyboard settings or managed `dconf` to map Caps Lock to Ctrl.

## Notes on neovim setup

### General

path to config: `~/.config/nvim/init.lua`

Various configs? then add the following to `.bashrc`:

```sh
alias astronvim='NVIM_APPNAME=nvim-astro nvim'
alias nvim-typecraft='NVIM_APPNAME=nvim-typecraft nvim'
```

Do not install Homebrew here. Use Ubuntu packages or `uv` unless you have a
concrete reason to make package management more interesting than necessary.

### Telescope : live grep

For using live_grep with telescope, you need ripgrep (rg):

```sh
sudo apt install ripgrep
```

Windows:winget:

```sh
winget install --id=BurntSushi.ripgrep.MSVC  -e
```

### Markdown-preview

Get nodejs and npm

```sh
sudo apt install nodejs npm
```

cd ~/.local/share/nvim/lazy/markdown-preview.nvim/app
npm install


### Swagger

node.js permission error

```sh
mkdir -p ~/.npm-global
npm config set prefix '~/.npm-global'
export PATH="$HOME/.npm-global/bin:$PATH"
source ~/.bashrc
```

### Others
Use lazygit

```sh
winget install lazygit
```

### Debugger
#### Go

Get go and and [delve](https://github.com/go-delve/delve/tree/master/Documentation/installation):

```sh
sudo apt install golang-go
```

```sh
go install github.com/go-delve/delve/cmd/dlv@latest
```

Use yazi

https://yazi-rs.github.io/

Use tmux
