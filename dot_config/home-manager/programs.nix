{ pkgs, lib, ... }@args:

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

  # --- dunst ---
  services.dunst = {
    enable = true;
    settings = {
      global = {
        monitor = 0;
        follow = "keyboard";
        width = "(100, 350)";
        height = "(0, 300)";
        origin = "top-right";
        offset = "(10, 10)";
        scale = 0;
        notification_limit = 5;
        progress_bar = true;
        progress_bar_height = 12;
        progress_bar_frame_width = 0;
        progress_bar_min_width = 100;
        progress_bar_max_width = 300;
        progress_bar_corner_radius = 6;
        indicate_hidden = "yes";
        separator_height = 2;
        padding = 10;
        horizontal_padding = 10;
        text_icon_padding = 10;
        frame_width = 2;
        frame_color = "#b4befe";
        gap_size = 4;
        separator_color = "frame";
        corner_radius = 8;
        corners = "all";
        font = "FiraCode Nerd Font 10";
        line_height = 0;
        markup = "full";
        format = "<b>%s</b>\\n%b";
        alignment = "left";
        vertical_alignment = "center";
        show_age_threshold = -1;
        ellipsize = "middle";
        ignore_newline = "no";
        stack_duplicates = true;
        hide_duplicate_count = false;
        show_indicators = "yes";
        enable_recursive_icon_lookup = true;
        icon_theme = "Adwaita";
        icon_position = "left";
        min_icon_size = 24;
        max_icon_size = 64;
        sticky_history = "yes";
        history_length = 30;
        browser = "/usr/bin/xdg-open";
        always_run_script = true;
        force_xwayland = false;
        mouse_left_click = "close_current";
        mouse_middle_click = "do_action, close_current";
        mouse_right_click = "close_all";
        sort = "yes";
      };
      urgency_low = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#6c7086";
        timeout = 8;
      };
      urgency_normal = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#b4befe";
        highlight = "#89b4fa";
        timeout = 10;
        default_icon = "dialog-information";
      };
      urgency_critical = {
        background = "#1e1e2e";
        foreground = "#cdd6f4";
        frame_color = "#f38ba8";
        highlight = "#f38ba8";
        timeout = 0;
        default_icon = "dialog-warning";
      };
    };
  };

  # --- wofi (Wayland only) ---
  programs.wofi = lib.mkIf (args.wm == "hyprland") {
    enable = true;
    settings = {
      hide_scroll = true;
      show = "drun";
      width = "30%";
      lines = 8;
      line_wrap = "word";
      term = "kitty";
      allow_markup = true;
      layer = "overlay";
      allow_images = true;
      sort_order = "alphabetical";
      gtk_dark = true;
      image_size = 24;
      display_generic = false;
      location = "center";
      key_expand = "Tab";
      insensitive = true;
    };
    style = ''
      /* Wofi style — Catppuccin Mocha */

      * {
          font-family: FiraCode Nerd Font, Noto Sans, sans-serif;
          color: #cdd6f4;
          background: transparent;
      }

      #window {
          background: rgba(30, 30, 46, 0.92);
          margin: auto;
          padding: 5px;
          border-radius: 12px;
          border: 2px solid #b4befe;
      }

      #input {
          padding: 8px;
          margin-bottom: 10px;
          border-radius: 8px;
          background-color: #313244;
          color: #cdd6f4;
      }

      #outer-box {
          padding: 15px;
      }

      #img {
          margin-right: 10px;
      }

      #entry {
          padding: 6px;
          border-radius: 8px;
      }

      #entry:selected {
          background-color: #45475a;
      }

      #text {
          margin: 2px;
      }
    '';
  };

  # --- rofi (X11 only) ---
  xdg.configFile."rofi/config.rasi" = lib.mkIf (args.wm == "i3") {
    text = ''
      /* Rofi Configuration — Catppuccin Mocha */

      configuration {
          modi: "drun,run";
          show-icons: true;
          terminal: "kitty";
          drun-display-format: "{name}";
          case-sensitive: false;
      }

      @theme "/dev/null"

      * {
          base:     #1e1e2e;
          mantle:   #181825;
          surface0: #313244;
          surface1: #45475a;
          overlay0: #6c7086;
          text:     #cdd6f4;
          lavender: #b4befe;
          red:      #f38ba8;

          background-color: transparent;
          text-color:       @text;
          font:             "FiraCode Nerd Font 11";
      }

      window {
          width:            30%;
          background-color: @base;
          border:           2px;
          border-color:     @lavender;
          border-radius:    8px;
          padding:          0;
      }

      mainbox {
          background-color: @base;
          children:         [ inputbar, listview ];
      }

      inputbar {
          background-color: @surface0;
          padding:          12px;
          children:         [ prompt, entry ];
      }

      prompt {
          background-color: inherit;
          text-color:       @lavender;
          padding:          0 8px 0 0;
      }

      entry {
          background-color: inherit;
          placeholder:      "Search...";
          placeholder-color: @overlay0;
      }

      listview {
          background-color: @base;
          lines:            8;
          padding:          8px;
          spacing:          4px;
      }

      element {
          padding:       8px;
          border-radius: 4px;
      }

      element normal.normal {
          background-color: @base;
      }

      element selected.normal {
          background-color: @surface1;
          text-color:       @lavender;
      }

      element alternate.normal {
          background-color: @base;
      }

      element-icon {
          size: 20px;
          padding: 0 8px 0 0;
      }

      element-text {
          highlight: bold;
      }
    '';
  };

  # --- picom (X11 only) ---
  services.picom = lib.mkIf (args.wm == "i3") {
    enable = true;
    backend = "xrender";
    vSync = false;
    shadow = true;
    shadowOffsets = [ (-6) (-6) ];
    shadowOpacity = 0.75;
    shadowExclude = [
      "name = 'Notification'"
      "class_g = 'Polybar'"
      "class_g = 'i3-frame'"
      "_GTK_FRAME_EXTENTS@:c"
    ];
    fade = false;
    inactiveOpacity = 1.0;
    activeOpacity = 1.0;
    settings = {
      shadow-radius = 6;
      shadow-color = "#1e1e2e";
      frame-opacity = 1.0;
      detect-client-opacity = true;
      detect-transient = true;
      detect-client-leader = true;
      use-damage = true;
      wintypes = {
        tooltip = { shadow = false; };
        dock = { shadow = false; };
        dnd = { shadow = false; };
        popup_menu = { shadow = true; };
        dropdown_menu = { shadow = true; };
      };
    };
  };

  # --- git ---
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = args.gitUserName;
      user.email = args.gitUserEmail;
      alias.pushf = "push --force-with-lease";
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

  # --- delta ---
  programs.delta = {
    enable = true;
    enableGitIntegration = true;
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
    shellWrapperName = "y";
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
  };

  xdg.configFile."yazi/flavors/catppuccin-mocha.yazi/flavor.toml".source = let
    catppuccin-yazi = pkgs.fetchFromGitHub {
      owner = "catppuccin";
      repo = "yazi";
      rev = "d62802be39210ea10e54b3e3b09735c6cb9e57c1";
      hash = "sha256-bwzEO8exoBwa19q+jnYjHkaamGl2mhfukIEhDfUCRGI=";
    };
  in "${catppuccin-yazi}/themes/mocha/catppuccin-mocha-blue.toml";
}
