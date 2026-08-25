{ ... }:

{
  programs.lazygit = {
    enable = true;
    settings = {
      os.editPreset = "nvim";
      git.diffRenderers = [
        { command = "delta --paging=never --side-by-side"; }
        { type = "rawGit"; }
      ];
      gui.sidePanelWidth = 0.2;
    };
  };
}
