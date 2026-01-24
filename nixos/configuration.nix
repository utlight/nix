{
  imports = [
    ./hardware-configuration.nix

    ./packages.nix
    ./modules/modules.nix
  ];

  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.variables = {
    EDITOR = "zeditor";
  };

  system.stateVersion = "25.11";
}
