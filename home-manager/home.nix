{ home_state_version, ... }:
{
  imports = [
    ./modules/modules.nix
  ];

  home = {
    username = "utlight";
    homeDirectory = "/home/utlight";
    stateVersion = home_state_version;
  };
}
