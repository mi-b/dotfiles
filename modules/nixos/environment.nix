{
  config,
  pkgs,
  ...
}: {
  ### Environment ================================================================
  environment = {
    shells = [
      "/run/current-system/sw/bin/zsh"
    ];
  };
  # ===========================================================================
}
