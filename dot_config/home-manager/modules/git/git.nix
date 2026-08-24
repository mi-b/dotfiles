{ config, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = config.host.gitUserName;
      user.email = config.host.gitUserEmail;
      alias.pushf = "push --force-with-lease";
      core.autocrlf = "input";
      init.defaultBranch = "main";
      column.ui = "auto";
      branch.sort = "-committerdate";
      pull.rebase = true;
      merge.conflictStyle = "zdiff3";
      rerere.enabled = true;
      diff.algorithm = "histogram";
      diff.colorMoved = "default";
      fetch.prune = true;
      push.recurseSubmodules = "check";
      submodule.recurse = true;
      transfer.fsckObjects = true;
      tag.sort = "version:refname";
    };
  };

  programs.delta = {
    enable = true;
    enableGitIntegration = true;
    options = {
      features = "catppuccin-mocha";
      "catppuccin-mocha" = {
        blame-palette = "#1e1e2e #181825 #11111b #313244 #45475a";
        commit-decoration-style = "#6c7086 bold box ul";
        dark = true;
        file-decoration-style = "#6c7086";
        file-style = "#cdd6f4";
        hunk-header-decoration-style = "#6c7086 box ul";
        hunk-header-file-style = "bold";
        hunk-header-line-number-style = "bold #a6adc8";
        hunk-header-style = "file line-number syntax";
        line-numbers-left-style = "#6c7086";
        line-numbers-minus-style = "bold #f38ba8";
        line-numbers-plus-style = "bold #a6e3a1";
        line-numbers-right-style = "#6c7086";
        line-numbers-zero-style = "#6c7086";
        minus-emph-style = "bold syntax #694559";
        minus-style = "syntax #493447";
        plus-emph-style = "bold syntax #4e6356";
        plus-style = "syntax #394545";
        map-styles = "bold purple => syntax #5b4e74, bold blue => syntax #445375, bold cyan => syntax #446170, bold yellow => syntax #6b635b";
        syntax-theme = "Catppuccin Mocha";
      };
    };
  };
}
