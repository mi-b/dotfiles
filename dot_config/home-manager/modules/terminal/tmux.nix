{ ... }:

{
  programs.tmux = {
    enable = true;
    keyMode = "vi";
    customPaneNavigationAndResize = true;
    extraConfig = ''
      set -g set-clipboard on
      set -g allow-passthrough on
    '';
  };
}
