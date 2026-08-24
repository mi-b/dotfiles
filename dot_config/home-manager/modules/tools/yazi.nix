{ pkgs, ... }:

{
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
