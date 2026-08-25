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
        max_width = 1920;
        max_height = 1080;
      };
    };
  };
}
