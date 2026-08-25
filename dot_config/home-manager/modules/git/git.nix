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
  };
}
