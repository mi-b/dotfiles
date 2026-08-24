{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [ "ignoreboth" "erasedups" ];
    historySize = 10000;
    historyFileSize = 20000;
    shellOptions = [ "histappend" "checkwinsize" ];
    shellAliases = {
      lg = "lazygit";
      nvs = "cd ~/.config/nvim/ && nvim";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
    };

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

    initExtra = ''
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

      ff() { find -type f | fzf -m --preview='bat --color=always {}'; }
      fd() { find -type d | fzf; }
      fn() { fzf -m --preview='bat --color=always {}' --bind 'enter:become(nvim {+})'; }
      ffn() { find -type f | fzf --bind 'enter:become(nvim {})'; }
      fdn() { find -type d | fzf --preview='bat --color=always {}' --bind 'enter:become(nvim {})'; }
    '';
  };

  programs.lesspipe.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = true;
  };
}
