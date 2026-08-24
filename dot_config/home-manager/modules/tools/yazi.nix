{ pkgs, ... }:

let
  catppuccin-yazi = pkgs.fetchFromGitHub {
    owner = "catppuccin";
    repo = "yazi";
    rev = "d62802be39210ea10e54b3e3b09735c6cb9e57c1";
    hash = "sha256-bwzEO8exoBwa19q+jnYjHkaamGl2mhfukIEhDfUCRGI=";
  };

  catppuccin-mocha-flavor = pkgs.runCommand "catppuccin-mocha-yazi" { } ''
    mkdir -p $out
    cp ${catppuccin-yazi}/themes/mocha/catppuccin-mocha-blue.toml $out/flavor.toml
  '';
in
{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    shellWrapperName = "y";

    flavors.catppuccin-mocha = catppuccin-mocha-flavor;

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
}
