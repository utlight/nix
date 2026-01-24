{
  programs.yazi = {
    enable = true;
    enableBashIntegration = true;
    keymap = {
      mgr.prepend_keymap = [
        {
          run = [ ''shell -- printf "file://%s\n" %s | wl-copy -t text/uri-list'' ];
          on = [
            "c"
            "y"
          ];
          desc = "Copy file";
        }
      ];
    };
  };
}
