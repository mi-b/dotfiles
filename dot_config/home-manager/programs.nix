{ pkgs, ... }:

{
  # --- direnv + nix-direnv (cached flake devShells) ---
  # nix-direnv provides cached Nix devShell evaluation.
  # Shell hook (eval "$(direnv hook bash)") is in bashrc (chezmoi-managed).
  programs.direnv = {
    enable = true;
    nix-direnv.enable = true;
    enableBashIntegration = false; # chezmoi manages bashrc
  };

  # --- starship prompt ---
  # Binary is in packages.nix. Config file is managed by chezmoi
  # (uses OS-specific templating). Shell hook is in bashrc.

  # --- bat (cat replacement with syntax highlighting) ---
  # Theme file is managed by chezmoi (dot_config/bat/themes/).
  # bat cache is rebuilt by a chezmoi run_onchange script.
  programs.bat = {
    enable = true;
    config = {
      theme = "Catppuccin Mocha";
    };
  };

  # --- fzf ---
  programs.fzf = {
    enable = true;
    enableBashIntegration = false; # chezmoi manages bashrc
  };

  # --- zoxide ---
  programs.zoxide = {
    enable = true;
    enableBashIntegration = false; # chezmoi manages bashrc
  };
}
