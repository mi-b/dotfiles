{ ... }:

{
  programs.yazi = {
    enable = true;
    shellWrapperName = "y";

    settings = {
      mgr = {
        show_hidden = true;
        ratio = [
          1
          3
          4
        ];
      };
      preview = {
        wrap = "yes";
      };
    };
  };
}
