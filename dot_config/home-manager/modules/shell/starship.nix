{ ... }:

{
  programs.starship = {
    enable = true;
    settings = {
      add_newline = false;

      format = builtins.concatStringsSep "" [
        "$username"
        "$hostname"
        "\${custom.ip}"
        "$directory"
        "$git_branch"
        "$git_status"
        "$character"
      ];

      hostname = {
        ssh_only = true;
        format = "[$hostname](bold yellow)";
      };

      custom.ip = {
        when = "test -n \"$SSH_CONNECTION\"";
        command = "ip route get 1 | awk '{print \" (\" $7 \")\"; exit}'";
        format = "[$output](bold yellow) ";
        shell = [
          "bash"
          "--noprofile"
          "--norc"
        ];
      };

      nodejs.disabled = true;

      character = {
        success_symbol = "[>](bold green)";
        error_symbol = "[>](bold red)";
      };
    };
  };
}
