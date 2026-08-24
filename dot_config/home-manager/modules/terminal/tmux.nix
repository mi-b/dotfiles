{ ... }:

{
  programs.tmux = {
    enable = true;
    terminal = "tmux-256color";
    escapeTime = 10;
    historyLimit = 50000;
    baseIndex = 1;
    mouse = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    extraConfig = ''
      set -g set-clipboard on
      set -g allow-passthrough on
    '';
  };
}
