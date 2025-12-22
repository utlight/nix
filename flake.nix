{
  inputs = {
    stable_pkgs.url = "github:nixos/nixpkgs/nixos-25.11";
    unstable_pkgs.url = "github:nixos/nixpkgs/nixos-unstable";
    home_manager = {
      url = "github:nix-community/home-manager/release-25.11";
      inputs.nixpkgs.follows = "stable_pkgs";
    };

    nixos_hardware.url = "github:NixOS/nixos-hardware/master";

    zen_browser = {
      url = "github:youwen5/zen-browser-flake";
      inputs.nixpkgs.follows = "unstable_pkgs";
    };
  };

  outputs = inputs: {
    nixosConfigurations.nixos = inputs.stable_pkgs.lib.nixosSystem {
      specialArgs = {
        unstable_pkgs = import inputs.unstable_pkgs {
          system = "x86_64-linux";
          config.allowUnfree = true;
        };
        zen_browser = inputs.zen_browser;
      };
      modules = [
        ./nixos/configuration.nix
        inputs.nixos_hardware.nixosModules.lenovo-legion-16aph8
      ];
    };

    homeConfigurations.utlight = inputs.home_manager.lib.homeManagerConfiguration {
      pkgs = inputs.stable_pkgs.legacyPackages.x86_64-linux;
      extraSpecialArgs = {
        home_state_version = "25.11";
      };
      modules = [
        ./home-manager/home.nix
      ];
    };
  };
}
