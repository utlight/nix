{
  pkgs,
  unstable_pkgs,
  zen_browser,
  ...
}:
{
  nixpkgs.config.allowUnfree = true;

  programs.steam = {
    enable = true;
    gamescopeSession = {
      enable = true;
    };
  };

  environment.systemPackages =
    (with pkgs; [
      #desktop
      xwayland-satellite
      fuzzel
      alacritty
      afterglow-cursors-recolored

      #other
      gnome-boxes
      spice-vdagent
      home-manager
    ])
    ++ (with unstable_pkgs; [
      #development
      jetbrains-toolbox
      azure-functions-core-tools
      azure-cli
      azurite
      zed-editor
      nil
      nixd

      #work
      teams-for-linux

      #gaming
      protonup-qt
      mangohud

      #web
      zen_browser.packages.x86_64-linux.default
    ]);
}
