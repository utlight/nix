{
  imports = [
    ./hardware-configuration.nix

    ./packages.nix
    ./modules/modules.nix
  ];

  programs.nh = {
    enable = true;
    clean.enable = true;
    clean.extraArgs = "--keep-since 7d --keep 5";
    flake = "/home/utlight/.config/nix";
  };
  
  nix.settings.experimental-features = [
    "nix-command"
    "flakes"
  ];

  environment.variables = {
    EDITOR = "nvim";
  };

  system.stateVersion = "25.11";
}
