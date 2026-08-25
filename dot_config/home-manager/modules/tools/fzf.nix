{ ... }:

{
  programs.fzf = {
    enable = true;
    defaultCommand = "fd --type f --hidden --follow --exclude .git";
    fileWidget = {
      command = "fd --type f --hidden --follow --exclude .git";
      options = [ "--preview" "bat --color=always {}" ];
    };
    changeDirWidget = {
      command = "fd --type d --hidden --follow --exclude .git";
      options = [ "--preview" "tree -C {} | head -50" ];
    };
  };
}
