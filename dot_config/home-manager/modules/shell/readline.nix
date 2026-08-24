{ ... }:

{
  programs.readline = {
    enable = true;
    variables = {
      editing-mode = "vi";
      keyseq-timeout = 50;
      completion-ignore-case = true;
      show-all-if-ambiguous = true;
      show-mode-in-prompt = true;
      vi-ins-mode-string = "\\1\\e[5 q\\2";
      vi-cmd-mode-string = "\\1\\e[1 q\\2";
    };
    extraConfig = ''
      set keymap vi-command
      "\C-l": clear-screen
      set keymap vi-insert
      "\C-l": clear-screen
    '';
  };
}
