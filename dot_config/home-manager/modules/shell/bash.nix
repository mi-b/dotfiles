{ ... }:

{
  programs.bash = {
    enable = true;
    enableCompletion = true;
    historyControl = [
      "ignoreboth"
      "erasedups"
    ];
    historySize = 10000;
    historyFileSize = 20000;
    shellOptions = [
      "histappend"
      "checkwinsize"
    ];
    shellAliases = {
      lg = "lazygit";
      cmc = "cd $(chezmoi source-path)";
      nvs = "cd ~/.config/nvim/ && nvim";
      cme = "chezmoi edit";
      ".." = "cd ..";
      "..." = "cd ../..";
      "...." = "cd ../../..";
      "....." = "cd ../../../..";
      "......" = "cd ../../../../..";
    };

    bashrcExtra = ''
      # Ensure login shells pick up the system Nix profile on this host.
      if [ -f "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh" ]; then
        . "/nix/var/nix/profiles/default/etc/profile.d/nix-daemon.sh"
      fi
    '';

    initExtra = ''
      case ";''${PROMPT_COMMAND-};" in
        *";history -a; history -n;"*) ;;
        *) PROMPT_COMMAND="history -a; history -n''${PROMPT_COMMAND:+; $PROMPT_COMMAND}" ;;
      esac
      export PROMPT_COMMAND

      # Open selected files in nvim via fzf.
      fn() { fzf -m --preview='bat --color=always {}' --bind 'enter:become(nvim {+})'; }
    '';
  };

  programs.lesspipe.enable = true;

  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
  };
}
