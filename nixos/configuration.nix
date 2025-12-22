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

  system.stateVersion = "25.11";
}
