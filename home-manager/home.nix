{ home_state_version, pkgs, ... }:
{
  imports = [
    ./modules/modules.nix
  ];

  home = {
    username = "utlight";
    homeDirectory = "/home/utlight";
    stateVersion = home_state_version;
    sessionVariables.TERMINAL = "alacritty";
  };
}
