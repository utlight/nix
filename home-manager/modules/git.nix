{
  programs.gh.enable = true;
  programs.git = {
    enable = true;
    settings = {
      user.name = "utlight";
      user.email = "oalekseiev@tutamail.com";

      init.defaultBranch = "master";
    };
  };
}
