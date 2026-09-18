{ config, ... }:

{
  programs.git = {
    enable = true;
    lfs.enable = true;
    settings = {
      user.name = config.host.gitUserName;
      user.email = config.host.gitUserEmail;
      alias.pushf = "push --force-with-lease";
      alias.s = "status --short --branch";
      alias.l = "log --oneline --decorate --graph -20";
      alias.ll = "log --oneline --decorate --graph --all";
      alias.last = "log -1 HEAD --stat";
      alias.unstage = "restore --staged";
      alias.discard = "restore";
      alias.amend = "commit --amend --no-edit";
      alias.branches = "branch --sort=-committerdate";
      alias.recent = "for-each-ref --sort=-committerdate refs/heads/ --format='%(refname:short) %(committerdate:relative)'";
      core.autocrlf = "input";
      init.defaultBranch = "main";
      column.ui = "auto";
      branch.sort = "-committerdate";
      pull.rebase = true;
      merge.conflictStyle = "zdiff3";
      rerere.enabled = true;
      rerere.autoUpdate = true;
      diff.algorithm = "histogram";
      diff.colorMoved = "default";
      fetch.prune = true;
      push.autoSetupRemote = true;
      push.useForceIfIncludes = true;
      push.recurseSubmodules = "check";
      submodule.recurse = true;
      transfer.fsckObjects = true;
      tag.sort = "version:refname";
    };
  };

  programs.delta = {
    enable = true;
  };
}
