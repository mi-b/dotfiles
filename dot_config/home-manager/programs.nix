{ pkgs, ... }@args:

{
  # --- bash ---
  programs.bash = {
    enable = true;
    historyControl = [ "ignoreboth" "erasedups" ];
    historySize = 10000;
    historyFileSize = 20000;
    shellOptions = [ "histappend" "checkwinsize" ];
    shellAliases = {
      lg = "lazygit";
      nvs = "cd ~/.config/nvim/ && nvim";
    };

    # Runs early in .bashrc, before the interactive guard.
    bashrcExtra = ''
      # Append /usr/share/java to PATH (sessionPath only prepends).
      case ":$PATH:" in
        *":/usr/share/java:"*) ;;
        *) [ -d /usr/share/java ] && PATH="$PATH:/usr/share/java" ;;
      esac
      export PATH

      # Source Nix daemon profile.
      if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
        . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
      fi

      # Source Home Manager session variables.
      if [ -f "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh" ]; then
        . "$HOME/.nix-profile/etc/profile.d/hm-session-vars.sh"
      fi
    '';

    # Runs after the interactive guard and after all program integrations
    # (direnv, fzf, starship, zoxide).
    initExtra = ''
      set -o vi

      ..() { cd ..; }
      ...() { cd ../..; }
      ....() { cd ../../..; }
      .....() { cd ../../../..; }
      ......() { cd ../../../../..; }

      case ";''${PROMPT_COMMAND:-};" in
        *";history -a; history -n;"*) ;;
        *)
          if [ -n "''${PROMPT_COMMAND:-}" ]; then
            PROMPT_COMMAND="history -a; history -n; $PROMPT_COMMAND"
          else
            PROMPT_COMMAND="history -a; history -n"
          fi
          ;;
      esac
      export PROMPT_COMMAND

      # Remap Caps Lock to Ctrl (X11 only; Wayland handles this via compositor).
      if [ "$XDG_SESSION_TYPE" = "x11" ]; then
        setxkbmap -option ctrl:nocaps
        xset -q 2>/dev/null | grep -q "Caps Lock:   on" && xdotool key Caps_Lock
      fi

      if [ -x /usr/bin/lesspipe ]; then
        eval "$(SHELL=/bin/sh lesspipe)"
      fi

      # Load distro completions when present.
      if [ -f /usr/share/bash-completion/bash_completion ]; then
        . /usr/share/bash-completion/bash_completion
      elif [ -f /etc/bash_completion ]; then
        . /etc/bash_completion
      fi

      # Vi-mode cursor shape: beam (insert), block (normal).
      # Must run after starship init to avoid being overridden.
      if [[ $- == *i* ]]; then
        bind 'set show-mode-in-prompt on'
        bind "set vi-ins-mode-string \1"$'\e'"[5 q\2"
        bind "set vi-cmd-mode-string \1"$'\e'"[1 q\2"
      fi

      y() {
        local tmp cwd
        tmp="$(mktemp -t "yazi-cwd.XXXXXX")" || return 1
        yazi "$@" --cwd-file="$tmp"
        cwd="$(tr -d '\0' < "$tmp")"
        if [ -n "$cwd" ] && [ "$cwd" != "$PWD" ]; then
          builtin cd -- "$cwd" || return
        fi
        rm -f -- "$tmp"
      }

      ff() { find -type f | fzf -m --preview='bat --color=always {}'; }
      fd() { find -type d | fzf; }
      fn() { fzf -m --preview='bat --color=always {}' --bind 'enter:become(nvim {+})'; }
      ffn() { find -type f | fzf --bind 'enter:become(nvim {})'; }
      fdn() { find -type d | fzf --preview='bat --color=always {}' --bind 'enter:become(nvim {})'; }
    '';
  };

  # --- direnv + nix-direnv (cached flake devShells) ---
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };

  # --- starship prompt ---
  # Config lives here; chezmoi only manages starship.toml on Windows.
  programs.starship = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      add_newline = false;
      command_timeout = 1000;
      palette = "catppuccin_mocha";

      format = builtins.concatStringsSep "" [
        "$username"
        "$hostname"
        "\${custom.ip}"
        "$directory"
        "$git_branch"
        "$git_status"
        "$character"
      ];

      hostname = {
        ssh_only = true;
        format = "[$hostname](bold yellow)";
      };

      custom.ip = {
        when = "test -n \"$SSH_CONNECTION\"";
        command = "ip route get 1 | awk '{print \" (\" $7 \")\"; exit}'";
        format = "[$output](bold yellow) ";
        shell = [ "bash" "--noprofile" "--norc" ];
      };

      nodejs.disabled = true;

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };

      palettes.catppuccin_mocha = {
        rosewater = "#f5e0dc";
        flamingo = "#f2cdcd";
        pink = "#f5c2e7";
        mauve = "#cba6f7";
        red = "#f38ba8";
        maroon = "#eba0ac";
        peach = "#fab387";
        yellow = "#f9e2af";
        green = "#a6e3a1";
        teal = "#94e2d5";
        sky = "#89dceb";
        sapphire = "#74c7ec";
        blue = "#89b4fa";
        lavender = "#b4befe";
        text = "#cdd6f4";
        subtext1 = "#bac2de";
        subtext0 = "#a6adc8";
        overlay2 = "#9399b2";
        overlay1 = "#7f849c";
        overlay0 = "#6c7086";
        surface2 = "#585b70";
        surface1 = "#45475a";
        surface0 = "#313244";
        base = "#1e1e2e";
        mantle = "#181825";
        crust = "#11111b";
      };
    };
  };

  # --- bat (cat replacement with syntax highlighting) ---
  programs.bat = {
    enable = true;
    themes = {
      "Catppuccin Mocha" = {
        src = pkgs.fetchFromGitHub {
          owner = "catppuccin";
          repo = "bat";
          rev = "6810349b28055dce54076712fc05fc68da4b8ec0";
          hash = "sha256-lJapSgRVENTrbmpVyn+UQabC9fpV1G1e+CdlJ090uvg=";
        };
        file = "themes/Catppuccin Mocha.tmTheme";
      };
    };
    config = {
      theme = "Catppuccin Mocha";
    };
  };

  # --- kitty (config only; package installed via apt) ---
  xdg.configFile."kitty/kitty.conf".text = let
    isHyprland = args.wm == "hyprland";
  in ''
    # Kitty configuration — only non-default settings.

    # --- Font ---
    font_family      FiraCode Nerd Font
    bold_font        auto
    italic_font      auto
    bold_italic_font auto
    font_size        12.0
    disable_ligatures never

    # --- Window ---
    hide_window_decorations ${if isHyprland then "yes" else "no"}
    window_padding_width    5
    confirm_os_window_close 0

    # --- Scrollback ---
    scrollback_lines 50000

    # --- Bell ---
    enable_audio_bell    no
    visual_bell_duration 0.1
    visual_bell_color #333333

    # --- Clipboard & remote ---
    clipboard_control    write-clipboard read-clipboard
    allow_remote_control no
    allow_hyperlinks     yes

    # --- Theme ---
    include themes/mocha.conf
    ${if isHyprland then ''

    # --- Shell integration ---
    shell_integration no-cursor'' else ""}

    # --- Keybindings ---
    map kitty_mod+right next_window
    map kitty_mod+left  next_window
    map kitty_mod+up    next_tab
    map kitty_mod+down  previous_tab
    map ctrl+shift+b launch --type=os-window --cwd=current
  '';

  xdg.configFile."kitty/themes/mocha.conf".source = pkgs.fetchurl {
    url = "https://raw.githubusercontent.com/catppuccin/kitty/main/themes/mocha.conf";
    hash = "sha256-cWrJfNVCuuT/NbU8qYCq5PAB4MS8WcT74AMBm+IO+c0=";
  };

  # --- git ---
  programs.git = {
    enable = true;
    userName = args.gitUserName;
    userEmail = args.gitUserEmail;
    lfs.enable = true;
    aliases = {
      pushf = "push --force-with-lease";
    };
    delta = {
      enable = true;
      options = {
        features = "catppuccin-mocha";
        "catppuccin-mocha" = {
          blame-palette = "#1e1e2e #181825 #11111b #313244 #45475a";
          commit-decoration-style = "#6c7086 bold box ul";
          dark = true;
          file-decoration-style = "#6c7086";
          file-style = "#cdd6f4";
          hunk-header-decoration-style = "#6c7086 box ul";
          hunk-header-file-style = "bold";
          hunk-header-line-number-style = "bold #a6adc8";
          hunk-header-style = "file line-number syntax";
          line-numbers-left-style = "#6c7086";
          line-numbers-minus-style = "bold #f38ba8";
          line-numbers-plus-style = "bold #a6e3a1";
          line-numbers-right-style = "#6c7086";
          line-numbers-zero-style = "#6c7086";
          minus-emph-style = "bold syntax #694559";
          minus-style = "syntax #493447";
          plus-emph-style = "bold syntax #4e6356";
          plus-style = "syntax #394545";
          map-styles = "bold purple => syntax #5b4e74, bold blue => syntax #445375, bold cyan => syntax #446170, bold yellow => syntax #6b635b";
          syntax-theme = "Catppuccin Mocha";
        };
      };
    };
    extraConfig = {
      core.autocrlf = "input";
      init.defaultBranch = "main";
      column.ui = "auto";
      branch.sort = "-committerdate";
      pull.rebase = true;
      merge.conflictStyle = "zdiff3";
      rerere.enabled = true;
      diff.algorithm = "histogram";
      diff.colorMoved = "default";
      fetch.prune = true;
      push.recurseSubmodules = "check";
      submodule.recurse = true;
      transfer.fsckObjects = true;
      tag.sort = "version:refname";
    };
  };

  # --- fzf ---
  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
  };

  # --- zoxide ---
  programs.zoxide = {
    enable = true;
    enableBashIntegration = true;
  };

  # --- tmux ---
  programs.tmux = {
    enable = true;
    extraConfig = ''
      bind h select-pane -L
      bind j select-pane -D
      bind k select-pane -U
      bind l select-pane -R

      set -g set-clipboard on
      set -g allow-passthrough on
    '';
  };

  # --- readline ---
  programs.readline = {
    enable = true;
    variables = {
      keyseq-timeout = 50;
      completion-ignore-case = true;
      show-all-if-ambiguous = true;
    };
    extraConfig = ''
      set keymap vi-command
      "\C-l": clear-screen
      set keymap vi-insert
      "\C-l": clear-screen
    '';
  };

  # --- lazygit ---
  programs.lazygit = {
    enable = true;
    settings = {
      os.editPreset = "nvim";
      git.diffRenderers = [
        { command = "delta --paging=never --side-by-side --features catppuccin-mocha"; }
        { type = "rawGit"; }
      ];
      gui = {
        sidePanelWidth = 0.2;
        theme = {
          activeBorderColor = [ "#89b4fa" "bold" ];
          inactiveBorderColor = [ "#a6adc8" ];
          optionsTextColor = [ "#89b4fa" ];
          selectedLineBgColor = [ "#45475a" ];
          inactiveViewSelectedLineBgColor = [ "#313244" ];
          cherryPickedCommitBgColor = [ "#45475a" ];
          cherryPickedCommitFgColor = [ "#89b4fa" ];
          unstagedChangesColor = [ "#f38ba8" ];
          defaultFgColor = [ "#cdd6f4" ];
          searchingActiveBorderColor = [ "#f9e2af" ];
        };
      };
    };
  };

  # --- yazi ---
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    settings = {
      mgr = {
        show_hidden = true;
        ratio = [ 1 3 4 ];
      };
      preview = {
        wrap = "yes";
        max_width = 1920;
        max_height = 1080;
      };
    };
    theme = {
      flavor = {
        dark = "catppuccin-mocha";
      };
    };
    flavors = {
      catppuccin-mocha = "${pkgs.fetchFromGitHub {
        owner = "catppuccin";
        repo = "yazi";
        rev = "d62802be39210ea10e54b3e3b09735c6cb9e57c1";
        hash = "sha256-bwzEO8exoBwa19q+jnYjHkaamGl2mhfukIEhDfUCRGI=";
      }}/themes/mocha/catppuccin-mocha-blue.toml";
    };
  };
}
