{ pkgs, ... }:

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
}
