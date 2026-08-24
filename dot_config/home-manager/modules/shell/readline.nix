{ ... }:

{
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
}
